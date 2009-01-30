class Admin::DavController < ApplicationController
  act_as_railsdav
  no_login_required
  
  skip_before_filter :verify_authenticity_token
  
  def mkcol_for_path(path)
    puts "** RadiantDAV: mkcol_for_path(#{path})"
    
    raise WebDavErrors::ForbiddenError
  end
  
  def write_content_to_path(path, content)
    puts "** RadiantDAV: write_content_to_path(#{path}, #{content})"

    # Ignore apple specific files
    raise WebDavErrors::UnSupportedTypeError if path.any? do |component|
      component.starts_with?('.') || component == 'mach_kernel' || component == 'Backups.backupdb'
    end

    case path
      # Page Part
      when /^Pages\/(.+)\/(.+)$/

        if p = Page.find_by_title($1)          
          if pp = p.parts.find_by_name($2)
            pp.update_attribute(:content, content)
          end
        end
        
      when /^Snippets\/(.+)$/
        if s = Snippet.find_by_name($1)
          s.update_attribute(:content, content)
        end
        
      when /^Layouts\/(.+)$/
        if l = Layout.find_by_name($1)
          l.update_attribute(:content, content)
        end
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

    # Ignore apple specific files
    raise WebDavErrors::NotFoundError if path.any? do |component|
      component.starts_with?('.') || component == 'mach_kernel' || component == 'Backups.backupdb'
    end

    case path
      when ''
        return RadiantDirectoryResource.new('')

      when 'Pages'
        return RadiantDirectoryResource.new('Pages', Page)

      when 'Snippets'
        return RadiantDirectoryResource.new('Snippets', Snippet)

      when 'Layouts'
        return RadiantDirectoryResource.new('Layouts', Layout)
      else
        path_components = path.split('/')
        
        resource = path_components.first
        case resource
          when /layouts/i
            l = Layout.find_by_name(path_components[1])
            if l
              return RadiantLayoutResource.new(l, "Layouts/#{l.name}")
            else
              raise WebDavErrors::NotFoundError
            end
          when /pages/i
            p = Page.find_by_title(path_components[1])
            
            if p
              if !path_components[2].blank?
                pp = p.parts.find_by_name(path_components[2])
                if pp
                  return RadiantPagePartResource.new(pp, "Pages/#{p.title}/#{pp.name}")
                else 
                  raise WebDavErrors::NotFoundError
                end  
              else
                return RadiantPageResource.new(p, "Pages/#{p.title}")                
              end
              
            else
              raise WebDavErrors::NotFoundError
            end
            
          when /snippets/i
            s = Snippet.find_by_name(path_components[1])
            
            if s
              return RadiantSnippetResource.new(s, "Snippets/#{s.name}}")
            else
              raise WebDavErrors::NotFoundError
            end
            
          else
            raise WebDavErrors::NotFoundError
        end    
    end
  end

end