#
# Javascripts
#
class RadiantJavascriptResource < RadiantFileResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(record)
    @record = record
    if record.name =~ /\.js$/
      @path = "javascripts/#{record.name}"
    else
      @path = "javascripts/#{record.name}.js"
    end
  end

  def getcontenttype
    "text/javascript"
  end
end