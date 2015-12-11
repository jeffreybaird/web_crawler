require_relative '../../test_helper'
module WebCrawler
  class JsonViewerTest < Minitest::Test

    def test_it_can_parse
      tree = PageTreeBuilder.new("http://www.jeffreyleebaird.com/").build
      viewer = JsonViewer.new(tree)
      actual = JSON.parse(viewer.to_json)
      expected = JSON.parse(File.read("test/resources/test.json"))
      assert actual == expected, "expected: #{expected} but got: #{actual.inspect}"
    end

  end
end
