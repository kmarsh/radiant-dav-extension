#
# Snippets
#
class RadiantSnippetResource < RadiantFileResource

  def extension
    filter_extension
  end

  def getcontenttype
    filter_content_type
  end
end