#
# Stylesheet
#
class Sns::RadiantStylesheetResource < RadiantFileResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(record)
    @record = record
    if record.name =~ /\.css$/
      @path = "stylesheets/#{record.name}"
    else
      @path = "stylesheets/#{record.name}.css"
    end
  end

  def getcontenttype
    "text/css"
  end
end