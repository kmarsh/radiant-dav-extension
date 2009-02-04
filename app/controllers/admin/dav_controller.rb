#
# This controller handles WebDav for Radiant
#
class Admin::DavController < ApplicationController

  act_as_railsdav
  no_login_required
  
  skip_before_filter :verify_authenticity_token
  before_filter :radiant_authentication, :prepare_root_resource

   def mkcol_for_path(path)
     raise WebDavErrors::ForbiddenError
   end

  #
  # Write content to a resource
  # +path+ path to the resource
  # +content+ the content to write
  #
  def write_content_to_path(path, content)

    # Ignore apple specific files
    raise WebDavErrors::UnSupportedTypeError if path.any? do |component|
      component.starts_with?('.') || component == 'mach_kernel' || component == 'Backups.backupdb'
    end

    logger.debug "Radiant WebDAV: write_content_to_path(#{path.inspect}, #{content})"
    @root.get_resource(path).write!(content);
  end

  def copy_to_path(resource, dest_path, depth)
    logger.debug "Radiant WebDAV: copy_to_path(#{resource}, #{dest_path}, #{depth})"
    raise WebDavErrors::TODO409Error
  end

  def move_to_path(resource, dest_path, depth)
    logger.debug "Radiant WebDAV: move_to_path(#{resource}, #{dest_path}, #{depth})"
    raise WebDavErrors::TODO409Error
  end

  #
  # Gets the resource for the request
  # +path+ the requested path
  #
  def get_resource_for_path(path)

    # Ignore apple specific files
    raise WebDavErrors::UnSupportedTypeError if path.any? do |component|
      component.starts_with?('.') || component == 'mach_kernel' || component == 'Backups.backupdb'
    end
    
    logger.debug "Radiant WebDAV: get_resource_for_path(#{path.inspect})"
    @root.get_resource(path)
  end

  #
  # Authenticate WebDav against Radiant users
  #
  def radiant_authentication
    basic_auth_required {|username, password| session[:user] = User.authenticate(username,password) }
  end

  #
  # Initializes the resource tree
  #
  def prepare_root_resource
    @root ||= RadiantBaseResource.new('')
    @root.prepare(session[:user])
  end

end