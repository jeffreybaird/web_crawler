require 'httparty'
require 'nokogiri'

module WebCrawler
  class Page

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def get
      @get ||= HTTParty.get(url).body
    end

    def to_s
      url.to_s
    end

    def to_h()
      {
      resource: to_s,
      assets: {
          stylesheets: stylesheets,
          images: images,
          scripts: scripts
        },
      children: []}
    end

    def to_a
      to_h.to_to_a
    end

    def local_links
      formatted_links.select{|x| x.host == URI.parse(string_of_url(url)).host }
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

    def formatted_links
      links_as_uri_objects.map do |link|
        given_url = string_of_url(url)
        if link.scheme.nil?
          given_link = link.path[0] == '/' ? link.path : "/" + link.path
          URI.parse("http://" + URI.parse(given_url).host.to_s + given_link)
        else
          link
        end
      end.uniq
    end


    private

    def parsed_page
      @parsed_page ||= Nokogiri::HTML(get)
    end

    def string_of_url(url)
      url.is_a?(URI) ? url.to_s[0..-2] : url
    end

    def links_as_uri_objects
      links.map{|link| URI.parse(link)}
    end

    def links
      value(
        attributes(
        nodes('a'), "href"))
    end

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
