#
# Snippets
#
class Radiant::RadiantSnippetResource < RadiantFileResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(record)
    @record = record
    @path = "snippets/#{record.name}#{filter_extension}"

  end

  def getcontenttype
    filter_content_type
  end
end