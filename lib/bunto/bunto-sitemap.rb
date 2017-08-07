require "fileutils"

module Bunto
  class BuntoSitemap < Bunto::Generator
    safe true
    priority :lowest

    # Main plugin action, called by Bunto-core
    def generate(site)
      @site = site
      @site.pages << sitemap unless file_exists?("sitemap.xml")
      @site.pages << robots unless file_exists?("robots.txt")
    end

    private

    INCLUDED_EXTENSIONS = %W(
      .htm
      .html
      .xhtml
      .pdf
    ).freeze

    # Matches all whitespace that follows
    #   1. A '>' followed by a newline or
    #   2. A '}' which closes a Liquid tag
    # We will strip all of this whitespace to minify the template
    MINIFY_REGEX = %r!(?<=>\n|})\s+!

    # Array of all non-bunto site files with an HTML extension
    def static_files
      @site.static_files.select { |file| INCLUDED_EXTENSIONS.include? file.extname }
    end

    # Path to sitemap.xml template file
    def source_path(file = "sitemap.xml")
      File.expand_path "../#{file}", File.dirname(__FILE__)
    end

    # Destination for sitemap.xml file within the site source directory
    def destination_path(file = "sitemap.xml")
      @site.in_dest_dir(file)
    end

    def sitemap
      site_map = PageWithoutAFile.new(@site, File.dirname(__FILE__), "", "sitemap.xml")
      site_map.content = File.read(source_path).gsub(MINIFY_REGEX, "")
      site_map.data["layout"] = nil
      site_map.data["static_files"] = static_files.map(&:to_liquid)
      site_map.data["xsl"] = file_exists?("sitemap.xsl")
      site_map
    end

    def robots
      robots = PageWithoutAFile.new(@site, File.dirname(__FILE__), "", "robots.txt")
      robots.content = File.read(source_path("robots.txt"))
      robots.data["layout"] = nil
      robots
    end

    # Checks if a file already exists in the site source
    def file_exists?(file_path)
      if @site.respond_to?(:in_source_dir)
        File.exist? @site.in_source_dir(file_path)
      else
        File.exist? Bunto.sanitized_path(@site.source, file_path)
      end
    end
  end
end
