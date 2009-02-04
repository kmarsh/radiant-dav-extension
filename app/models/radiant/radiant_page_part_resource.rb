#
# Page part
#
class Radiant::RadiantPagePartResource < RadiantFileResource

  #
  # Initialize a file resource
  # +path+ path of the parent resource
  # +record+ ActiveRecord model
  #
  def initialize(path, record)
    @record = record
    @path = "#{path}/#{record.name}#{filter_extension}"

  end

  def getcontenttype
    filter_content_type
  end

  def displayname
    "#{record.name}#{filter_extension}"
  end
  
end