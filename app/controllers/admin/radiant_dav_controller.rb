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

    if path.blank? or path.eql?("/") 
      return RadiantPageResource.new(Page.find(:first, :conditions => ['parent_id IS NULL']), href_for_path(path)) if path.blank? or path.eql?("/") 
      
    else
      
      last = path.split('/')
      
      if page = Page.find_by_slug(last)
        puts page.inspect
        return RadiantPageResource.new(page, href_for_path(path))
      else
        raise WebDavErrors::NotFoundError        
      end
      
      puts "** FIND FOR: #{path.inspect}"
    end

    
    # model, id = path.split('/')
    # 
    # unless model.nil?       
    #   Page.find :first rescue raise WebDavErrors::NotFoundError
    # end
    #  
    # if id.nil?
    #   return RadiantPageResource.new(Page, href_for_path(path))
    # else
    #   if /(\w+)\.yaml$/ =~ id
    #     return RadiantPageResource.new(Page.find_by_slug($1.to_i), href_for_path(path))
    #   else
    #     raise WebDavErrors::NotFoundError
    #   end
    # end
  end

end