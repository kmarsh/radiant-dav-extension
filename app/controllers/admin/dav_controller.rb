#
# This controller handles WebDav for Radiant
#
class Admin::DavController < ApplicationController

  act_as_railsdav
  no_login_required
  
  skip_before_filter :verify_authenticity_token
  before_filter :radiant_authentication, :prepare_root_resource

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