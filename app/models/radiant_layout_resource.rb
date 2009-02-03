#
# Layouts
#
class RadiantLayoutResource < RadiantFileResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(record)
    @record = record
    @path = record.name + extension
  end

  #
  # Returns the url of this resource
  #
  def href
    "/admin/dav/snippets/#{path}"
  end

  def extension
    ".html"
  end

  def getcontenttype
    "text/html"
  end

end