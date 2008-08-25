class RadiantDirectoryResource
  include WebDavResource

  attr_accessor :href, :record, :table

  WEBDAV_PROPERTIES = [:displayname, :creationdate, :getlastmodified, :getcontenttype, :getcontentlength]

  def initialize(href, table = nil)
    @href = href
    @table = table
  end

  def collection?
    return true
  end

  def delete!
    #record.destroy! unless record.nil?
  end

  def move! (dest_path, depth)

  end

  def copy! (dest_path, depth)

  end

  def children
    case @href
      when 'Pages'
        return Page.find(:all).map {|p| RadiantPageResource.new(p, "Pages/#{p.title}") }

      when 'Snippets'
        return Snippet.find(:all).map {|s| RadiantSnippetResource.new(s, "Snippets/#{s.name}") }

      when 'Layouts'
        return Layout.find(:all).map {|l| RadiantLayoutResource.new(l, "Layouts/#{l.name}") }
      
      when ''
        return [
          RadiantDirectoryResource.new('Pages', Page),
          RadiantDirectoryResource.new('Snippets', Snippet),
          RadiantDirectoryResource.new('Layouts', Layout)
        ]
    end
  end

  def properties
    WEBDAV_PROPERTIES
  end 

  def displayname
    @href
  end
   
  def creationdate
    if !record.nil? and record.respond_to? :created_at
      record.created_at.httpdate
    end
  end

  def getlastmodified
    if !record.nil? and record.respond_to? :updated_at
      record.updated_at.httpdate
    end
  end

  def set_getlastmodified(value)
    if !record.nil? and record.respond_to? :updated_at=
      record.updated_at = Time.httpdate(value)
      gen_status(200, "OK").to_s
    else
      gen_status(409, "Conflict").to_s
    end
  end
   
  def getetag
    #sprintf('%x-%x-%x', @st.ino, @st.size, @st.mtime.to_i) unless @file.nil?
  end

  def getcontenttype
    "httpd/unix-directory"
  end

  def getcontentlength 
    0
  end

  def data
    nil
  end
end