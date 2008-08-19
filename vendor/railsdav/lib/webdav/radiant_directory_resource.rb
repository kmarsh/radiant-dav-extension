# Copyright (c) 2006 Stuart Eccles
# Released under the MIT License.  See the LICENSE file for more details.

require 'find'
class RadiantDirectoryResource
  include WebDavResource

   attr_accessor :href, :record, :table
   
   WEBDAV_PROPERTIES = [:displayname, :creationdate, :getlastmodified, :getcontenttype, :getcontentlength]
   
   def initialize(*args)
       @href = '/'
    end

    def collection?
      return true
    end

    def delete!
      #record.destroy! unless record.nil?
    end

    def move! (dest_path, depth)
      
    end

    def copy! (dest_path, depth)
      
    end

    # The children of a Radiant page are its child pages and/or parts
    def children
      Page.find(:all).map{|p| RadiantPageResource.new(p, "/#{p.slug}") }
    end
  
   def properties
     WEBDAV_PROPERTIES
   end 

   def displayname
      "/"
   end
   
   def creationdate
      if !record.nil? and record.respond_to? :created_at
        record.created_at.httpdate
      end
   end
   
   def getlastmodified
      if !record.nil? and record.respond_to? :updated_at
        record.updated_at.httpdate
      end
   end
   
   def set_getlastmodified(value)
     if !record.nil? and record.respond_to? :updated_at=
      record.updated_at = Time.httpdate(value)
      gen_status(200, "OK").to_s
     else
        gen_status(409, "Conflict").to_s
     end
   end
   
   def getetag
      #sprintf('%x-%x-%x', @st.ino, @st.size, @st.mtime.to_i) unless @file.nil?
   end
      
   def getcontenttype
      "httpd/unix-directory"
   end
      
   def getcontentlength 
      #respond_to?(:content) ? content.size : 0
      0
   end
   
   def data
     nil
   end
   
end