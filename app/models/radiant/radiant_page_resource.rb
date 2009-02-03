#
# Pages
#
class Radiant::RadiantPageResource < RadiantDirectoryResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(name, url)
    @record = record
    @path = "snippets/#{record.name}#{filter_extension}"

  end

  def getcontenttype
    filter_content_type
  end
end