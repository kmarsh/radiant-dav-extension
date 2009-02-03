#
# Represents the root directory of the WebDav
# access
#
class RadiantRootResource < RadiantResource

  #
  # Prepare the WebDav root. This depends on the radiant installation and also
  # on the user permission
  # +user+ the logged in user
  #
  def prepare(user)

    # Snippets
    
    @children << RadiantDirectoryResource.new('snippets') do
      Snippet.find(:all).map {|s| RadiantSnippetResource.new(s) }
    end if user.developer? || user.admin?

    # Layouts

    @children << RadiantDirectoryResource.new('layouts') do
      Layout.find(:all).map {|l| RadiantLayoutResource.new(l) }
    end if user.developer? || user.admin?

    # SnS Extension

    if Object.const_defined?(:SnsExtension)
      @children << RadiantDirectoryResource.new('javascripts') do
        Javascript.find(:all).map {|l| RadiantJavascriptResource.new(l) }
      end if user.developer? || user.admin?
      @children << RadiantDirectoryResource.new('stylesheets') do
        Stylesheet.find(:all).map {|l| RadiantStylesheetResource.new(l) }
      end if user.developer? || user.admin?
    end

  end

end