require 'httparty'
require 'nokogiri'

module WebCrawler
  class Page

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def run(url)
      parse_page(get)
    end

    def get
      @get ||= HTTParty.get(url).body
    end

    def parsed_page
      @parsed_page ||= Nokogiri::HTML(get)
    end

    def links
      value(
        attributes(
        nodes('a'), "href"))
    end

    def images
      value(attributes(
        nodes('img'),'src'))
    end

    def stylesheets
      value(attributes(
        nodes('link'),'href'))
    end

    def scripts
      value(attributes(
        nodes('script'),'src'))
    end

    private

    def attributes(nodes, attribute)
      nodes.select{|x| x.attributes[attribute]}.map{|x| x.attributes[attribute]}
    end

    def value(nodes)
      nodes.map(&:value)
    end

    def nodes(attribute)
      parsed_page.css(attribute)
    end

  end

end
