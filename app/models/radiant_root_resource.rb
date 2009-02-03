#
# Represents the root directory of the WebDav
# access
#
class RadiantRootResource < RadiantResource

  #
  # Prepare the WebDav root. This depends on the radiant installation and also
  # on the user persmission
  # +user+ the logged in user
  #
  def prepare(user)

    @children << RadiantDirectoryResource.new('snippets') do
      Snippet.find(:all).map {|s| RadiantSnippetResource.new(s) }
    end if user.developer? || user.admin?
    
    @children << RadiantDirectoryResource.new('layouts') do
      Layout.find(:all).map {|l| RadiantLayoutResource.new(l) }
    end if user.developer? || user.admin?

    #@children << RadiantPageResource.new('pages')
  end

end