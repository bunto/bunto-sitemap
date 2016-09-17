require 'addressable/uri'

module Bunto
  module SitemapFilters
    def normalize_url(input)
      Addressable::URI.parse(input).normalize.to_s
    end
  end
end
Liquid::Template.register_filter(Bunto::SitemapFilters)
