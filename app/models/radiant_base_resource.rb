#
# Base class for all Radiant WebDav resources
#
class RadiantBaseResource
  
  include WebDavResource

  attr_accessor :path, :record

  WEBDAV_PROPERTIES = [:displayname, :creationdate, :getlastmodified, :getcontenttype, :getcontentlength]

  #
  # Initializes a WebDav resource
  # +path+ path of the resource
  # +record+ ActiveRecord model if any
  #
  def initialize(path, record = nil)
    @path = path
    @record = record
    @children = []
    @prepared = false
  end

  #
  # Has this resource any childrens
  #
  def collection?
    true
  end

  #
  # Writes new content the resource
  #
  def write!(content)
    raise WebDavErrors::ForbiddenError
  end

  #
  # Remove the resource
  #
  def delete!
    raise WebDavErrors::ForbiddenError
  end

  #
  # Move the resource
  # +dest_path+ the destination of the resource
  # +depth+ depth
  #
  def move!(dest_path, depth)
    raise WebDavErrors::ForbiddenError
  end

  #
  # Copy the resource
  # +dest_path+ the destination of the resource
  # +depth+ depth
  #
  def copy!(dest_path, depth)
    raise WebDavErrors::TODO409Error
  end

  #
  # Returns the children of the resource
  #
  def children
    @children
  end

  #
  # Returns the WebDav properties
  #
  def properties
    WEBDAV_PROPERTIES
  end

  #
  # Returns the display name
  #
  def displayname
    path
  end

  #
  # Returns the creation date
  #
  def creationdate
    if !record.nil? and record.respond_to? :created_at
      record.created_at.httpdate
    end
  end

  #
  # Gets the last modified date
  #
  def getlastmodified
    if !record.nil? and record.respond_to? :updated_at
      record.updated_at.httpdate
    end
  end

  #
  # Updates the last modified date
  #
  def set_getlastmodified(value)
    if !record.nil? and record.respond_to? :updated_at=
      record.updated_at = Time.httpdate(value)
      gen_status(200, "OK").to_s
    else
      gen_status(409, "Conflict").to_s
    end
  end

  #
  # Returns the etag
  #
  def getetag
    #sprintf('%x-%x-%x', @st.ino, @st.size, @st.mtime.to_i) unless @file.nil?
  end

  #
  # Returns the content type
  #
  def getcontenttype
    "httpd/unix-directory"
  end

  #
  # Returns the the length of the content
  #
  def getcontentlength
    0
  end

  #
  # Returns the data of the resource
  #
  def data
    nil
  end

  #
  # Test if the actual resource is responsible for handling the request and
  # delegates the call to its children if not
  #
  # Returns the resource that is responsible, otherwise nil
  #
  def get_resource(resource_path)
    
    return self if path == resource_path

    @children.each do |c|
      resource = c.get_resource(resource_path)
      return resource if resource
    end if @children

    return nil
  end

  #
  # Returns the url of this resource
  #
  def href
    "/admin/dav/#{path}"
  end

  #
  # Determine the file extension depending on the resource's filter
  #
  # Returns a file extension
  #
  def filter_extension
    case record.filter_id
      when nil, '', 'WymEditor'
        return ".html"
      when 'Textile'
        return ".textile"
      when 'Markdown'
        return ".markdown"
    end
  end

  #
  # Determine the file content type depending on the resource's filter
  #
  # Returns a file content type
  #
  def filter_content_type
    case record.filter_id
      when '', 'WymEditor'
        return "text/html"
      when 'Textile'
        return "text/plain"
      when 'Markdown'
        return "text/plain"
    end
  end

  #
  # Prepare the WebDav root. This depends on the radiant installation and also
  # on the user permission
  # +user+ the logged in user
  #
  def prepare(user)

    if not @prepared
      # Pages

      @children << Radiant::RadiantPageResource.new('pages', Page.find_by_url('/'))

      # Snippets

      @children << RadiantDirectoryResource.new('snippets') do
        Snippet.find(:all).map {|s| Radiant::RadiantSnippetResource.new(s) }
      end if user.developer? || user.admin?

      # Layouts

      @children << RadiantDirectoryResource.new('layouts') do
        Layout.find(:all).map {|l| Radiant::RadiantLayoutResource.new(l) }
      end if user.developer? || user.admin?

      # SnS Extension

      if Object.const_defined?(:SnsExtension)
        @children << RadiantDirectoryResource.new('javascripts') do
          Javascript.find(:all).map {|l| Sns::RadiantJavascriptResource.new(l) }
        end if user.developer? || user.admin?
        @children << RadiantDirectoryResource.new('stylesheets') do
          Stylesheet.find(:all).map {|l| Sns::RadiantStylesheetResource.new(l) }
        end if user.developer? || user.admin?
      end

      @prepared = true
    end
  end
end