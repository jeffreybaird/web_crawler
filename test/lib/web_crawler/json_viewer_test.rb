require_relative '../../test_helper'
module WebCrawler
  class JsonViewerTest < Minitest::Test

    def test_it_can_parse
      tree = PageTreeBuilder.new("http://www.jeffreyleebaird.com/").build
      viewer = JsonViewer.new(tree)
      actual = JSON.parse(viewer.to_h(tree).to_json)
      expected = JSON.parse(File.read("test/resources/test.json"))
      File.open('test.json','w+'){|f| f.write(actual)}
      assert actual == expected, "expected: #{expected} but got: #{actual.inspect}"
    end

  end
end
