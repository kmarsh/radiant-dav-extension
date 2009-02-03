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

  def extension
    ".html"
  end

  def getcontenttype
    "text/html"
  end

end