#
# Snippets
#
class RadiantSnippetResource < RadiantFileResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(record)
    @record = record
    @path = record.name + filter_extension
  end

  #
  # Returns the url of this resource
  #
  def href
    "/admin/dav/snippets/#{path}"
  end
  
  def extension
    filter_extension
  end

  def getcontenttype
    filter_content_type
  end
end