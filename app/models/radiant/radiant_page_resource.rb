#
# Pages
#
class Radiant::RadiantPageResource < RadiantDirectoryResource

  #
  # Initialize the WebDav directory
  # +path+ path of the WebDAV directory
  # +record+ Page ActiveRecord model
  #
  def initialize(path, record)
    @path = path
    @record = record
    @children = []

    if record.class.to_s == 'LanguageRedirectPage'
      process_language_redirect
    else
      # Add child pages
      @record.children.each do |p|
        @children << Radiant::RadiantPageResource.new("#{path}/#{p.title}", p)
      end

    end

    # Add page parts
    @record.parts.each do |pp|
      @children << Radiant::RadiantPagePartResource.new(path, pp)
    end

  end

  def displayname
    record.title
  end

  #
  # Remove the resource
  #
  def delete!
    record.destroy
  end

  private

    #
    # Processes a language redirect page. For each language found in the config
    # page part, add a Radiant page resource. Adds a default folder if a default
    # language '*' has been set and the language is not already added
    #
    def process_language_redirect
      # Add languages
      record.parts.each do |part|
        # Get language redirect configuration
        if part.name == 'config'
          # Loop all languages
          languages = []
          part.content.each_line do |language|
            # Get language name and base url
            config = language.split(':')
            # Check if configuration is correct
            if (config.length == 2)
              # Get language props
              lang = config[0]
              url = config[1]
              # Set name as default if '*'
              lang = "default" if lang == '*'
              # Add language if not already done
              if not languages.include?(url)
                # Get the language page
                p = Page.find_by_url(config[1])
                if p
                  @children << Radiant::RadiantPageResource.new("#{path}/#{lang}", p)
                  languages << url
                end
              end
            end
          end
        end
      end
    end
end