$:.unshift File.expand_path(File.dirname(__FILE__))
$:.unshift File.join(File.dirname(__FILE__), 'lib/')

require 'railsdav'

ActionController::ACCEPTED_HTTP_METHODS.add('propfind')

ActionController::Base.send(:include, Railsdav)
ActionController::Base.send(:include, Railsdav::ActAsFileWebDav)