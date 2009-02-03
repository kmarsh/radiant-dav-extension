#
# Layouts
#
class Radiant::RadiantLayoutResource < RadiantFileResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(record)
    @record = record
    @path = "layouts/#{record.name}.html"
  end

  def getcontenttype
    "text/html"
  end

end