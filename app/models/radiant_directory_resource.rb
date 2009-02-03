#
# A radiant resource that will be represent by a
# WebDav directory
#
class RadiantDirectoryResource < RadiantResource

  #
  # Initialize the WebDav directory
  # +path+ path of the directory
  # +&children+ block to retrive the children
  #
  def initialize(path, &children)
    @path = path
    @children = children.call
  end

  #
  # children fot this directory
  #
  def children
    @children
  end

end