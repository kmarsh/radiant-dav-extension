#
# Base class for all resources that will be seen as a file
#
class RadiantFileResource < RadiantBaseResource

  #
  # Initialize a file resource
  # +record+ ActiveRecord model
  #
  def initialize(record)
    @record = record
    @path = record.name
  end

  #
  # A file has no children
  #
  def children
    []
  end

  #
  # Default content type
  #
  def getcontenttype
    "text/plain"
  end

  #
  # Has this resource any childrens
  #
  def collection?
    false
  end

  #
  # Returns the file size
  #
  def getcontentlength
    record.content.size
  end

  #
  # returns the file data
  #
  def data
    record.content
  end

  #
  # Write new content to the file
  #
  def write!(content)
    record.content = content
    record.save!
  end

  #
  # Remove the resource
  #
  def delete!
    record.destroy
  end
end