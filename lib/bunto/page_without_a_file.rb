module Bunto
  class PageWithoutAFile < Page
    def read_yaml(*)
      @data ||= {}
    end
  end
end
