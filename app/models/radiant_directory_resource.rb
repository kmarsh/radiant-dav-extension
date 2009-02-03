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
    @select_children = children
  end

  #
  # children fot this directory
  #
  def children
    @children = @select_children.call
  end

end