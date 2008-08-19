class Admin::RadiantDavController < ApplicationController
  act_as_railsdav
  no_login_required
  
  skip_before_filter :verify_authenticity_token
  
  def mkcol_for_path(path)
    puts "** RadiantDAV: mkcol_for_path(#{path})"
    
    raise WebDavErrors::ForbiddenError
  end
  
  def write_content_to_path(path, content)
    puts "** RadiantDAV: write_content_to_path(#{path}, #{content})"
    
    page = Page.find_by_slug(path.split('/').last)
    
    if page
      body_part = page.parts.find(:first, :conditions => {:name => "body"})
      if body_part.update_attribute(:content, content)
        
      else
        
      end
    else
      
    end
  end
  
  def copy_to_path(resource, dest_path, depth)
    puts "** RadiantDAV: copy_to_path(#{resource}, #{dest_path}, #{depth})"
  end

  def move_to_path(resource, dest_path, depth)
    puts "** RadiantDAV: move_to_path(#{resource}, #{dest_path}, #{depth})"
  end

  def get_resource_for_path(path)
    puts "** RadiantDAV: get_resource_for_path(#{path.inspect})"

    # Save us the trouble if you're looking for anything that starts with . (I'm
    # looking at you, OS X Finder!)
    #raise WebDavErrors::NotFoundError if path.any? {|component| component[0, 1] == "." }

    case path
      when ''
        return RadiantDirectoryResource.new('/')
      when '/'
        return RadiantDirectoryResource.new('/')

      when '/Pages'
        return RadiantDirectoryResource.new('/Pages', Page)

      when '/Snippets'
        return RadiantDirectoryResource.new('/Snippets', Snippet)

      when '/Layouts'
        return RadiantDirectoryResource.new('/Layouts', Layout)
      else
        if page = Page.find_by_slug(last)
          puts page.inspect
          return RadiantPageResource.new(page, href_for_path(path))
        else
          raise WebDavErrors::NotFoundError        
        end        
    end
  end

end