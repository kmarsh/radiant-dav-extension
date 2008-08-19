class Admin::RadiantDavController < ApplicationController
  act_as_railsdav
  no_login_required
  
  skip_before_filter :verify_authenticity_token
  
  def index
    render :text => "WebDAV"
  end
  
  def mkcol_for_path(path)
    puts "** RadiantDAV: mkcol_for_path(#{path})"  
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
    puts "** RadiantDAV: get_resource_for_path(#{path})"

     # return ActiveRecordResource.new(href_for_path(nil)) if path.blank? or path.eql?("/") 
     # model, id = path.split('/')
     # unless model.nil?
     #   
     #   kls = Inflector.classify( model )
     #   clazz = Module::const_get( kls )
     #   clazz.find :first rescue raise WebDavErrors::NotFoundError
     # end
     # 
     # if id.nil?
     #   return ActiveRecordResource.new(clazz, href_for_path(path))
     # else
     #   if /(\w+)\.yaml$/ =~ id
     #     return ActiveRecordResource.new(clazz.find($1.to_i), href_for_path(path))
     #   else
     #     raise WebDavErrors::NotFoundError
     #   end
     # end
     
    o = Page.find(:first)
    href = "/"

    return ActiveRecordResource.new(o,"#{href}#{o.id.to_s}.yaml")
  end

end