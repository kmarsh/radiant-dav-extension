# Copyright (c) 2006 Stuart Eccles
# Released under the MIT License.  See the LICENSE file for more details.

require 'find'
class RadiantPageResource
  include WebDavResource

   attr_accessor :html, :record, :table
   
   WEBDAV_PROPERTIES = [:displayname, :creationdate, :getlastmodified, :getcontenttype, :getcontentlength]
   @@classes = Hash.new
   
    Find.find( File.join(RAILS_ROOT, 'app/models') ) do |model|
          if File.extname(model) == ".rb" 
            model = File.basename(model, ".rb")
            kls = Inflector.classify( model )
            @@classes[model] = Module::const_get( kls )
          end
     end
   
   def initialize(*args)
       obj = args.first
       
       #bit hackey but kind_of? ActiveRecord::Base isnt working
       if obj.respond_to?(:save)
         @record = obj
       end
       if obj.is_a?(Class)
         @table = obj
       end

       @href = "/#{@record.slug}"

      # 
      # if args.last.is_a?(String)
      #     @href = args.last
      #     @href = @href + '/' if collection? and not @href.last == '/'
      #  end

      
    end

    def href
      record && record.url rescue "/"
    end

    def collection?
      false
    end

    def delete!
      record.destroy! unless record.nil?
    end

    def move! (dest_path, depth)
      
    end

    def copy! (dest_path, depth)
      
    end

    # The children of a Radiant page are its child pages and/or parts
    def children
     return []
    end
  
   def properties
     WEBDAV_PROPERTIES
   end 

   def displayname
      return "#{record.slug.to_s}" unless record.nil?
      # return @@classes.index(table) unless table.nil?
      # "/"
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
      "text/html"
   end
      
   def getcontentlength 
      #respond_to?(:content) ? content.size : 0
      YAML::dump( record ).to_s.size
   end
   
   def data
     record.parts.select{|p| p.name =="body"}.first.content
   end
   
end