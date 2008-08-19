class Admin::RadiantDavController < ApplicationController
  act_as_railsdav
  no_login_required
  
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
  end

end