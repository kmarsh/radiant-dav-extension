class RadiantPageResource
  include WebDavResource

  attr_accessor :html, :record, :table, :href

  WEBDAV_PROPERTIES = [:displayname, :creationdate, :getlastmodified, :getcontenttype, :getcontentlength]

  def initialize(*args)
    @record = args[0]
    @href = args[1]
  end

  def collection?
    true
  end

  def delete!
    record.destroy! unless record.nil?
  end

  def move! (dest_path, depth)

  end

  def copy! (dest_path, depth)

  end

  # The children of a Radiant page are its child pages and/or parts
  def children
    return @record.parts.map {|pp| RadiantPagePartResource.new(pp, "Pages/#{@record.title}/#{pp.name}")}
  end

  def properties
    WEBDAV_PROPERTIES
  end 

  def displayname
    return @record.title
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