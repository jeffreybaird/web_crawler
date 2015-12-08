require_relative '../../test_helper'
module WebCrawler
  class PageTest < Minitest::Test
    def test_it_can_get_a_page
      expected = File.read("./test/resources/actual.html")
      actual = Page.new("http://www.jeffreyleebaird.com").get
      assert actual == expected, "expected: #{expected} but got: #{actual}"
    end

    def test_it_can_find_all_links_on_a_page
      page = Page.new("http://www.jeffreyleebaird.com")
      page.expects(:get).
        returns(File.read("./test/resources/test.html"))
      actual = page.links
      expected = ["/", "http://www.industrialbjj.com/",
                  "http://learnwithjeff.com", "https://github.com/jeffreybaird",
                  "/blog", "http://learnwithjeff.com", "mailto:jeff@jeffreyleebaird.com",
                  "http://twitter.com/jeffrey_baird", "/", "/blog", "/public_key"]
      assert actual == expected, "expected: #{expected} but got: #{actual}"
    end

    def test_it_can_find_all_javascript_files_on_a_page
      page = Page.new("http://www.jeffreyleebaird.com")
      page.expects(:get).
        returns(File.read("./test/resources/test.html"))

      actual = page.scripts
      expected = ["fakestatic.js"]
      assert actual == expected, "expected: #{expected} but got: #{actual}"
    end

    def test_it_can_find_all_images_on_a_page
      page = Page.new("http://www.jeffreyleebaird.com")
      page.expects(:get).
        returns(File.read("./test/resources/test.html"))

      actual = page.images
      expected = ["img/jeffrey.jpg"]
      assert actual == expected, "expected: #{expected} but got: #{actual}"
    end

    def test_it_can_find_all_stylesheets_on_a_page
      page = Page.new("http://www.jeffreyleebaird.com")
      page.expects(:get).
        returns(File.read("./test/resources/test.html"))

      actual = page.stylesheets
      expected = ["http://yui.yahooapis.com/pure/0.6.0/base-min.css",
                  "http://yui.yahooapis.com/pure/0.6.0/pure-min.css",
                  "http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css"]
      assert actual == expected, "expected: #{expected} but got: #{actual}"
    end

    # def test_it_can_parse
    #   page.expects(:get).
    #     with("http://www.jeffreyleebaird.com").
    #     returns(File.read("./test/resources/test.html"))
    #
    #   actual = Page.run("http://www.jeffreyleebaird.com")
    #   expected = JSON.parse(File.read("test/resources/test.json")).to_json
    #   assert actual == expected, "expected: #{expected} but got: #{actual.inspect}"
    # end

  end

end
