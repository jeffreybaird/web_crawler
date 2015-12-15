require_relative '../../test_helper'
module WebCrawler
  class PageTreeBuilderTest < Minitest::Test

    def test_that_a_tree_can_be_constructed
      builder = PageTreeBuilder.new("http://www.jeffreyleebaird.com/")


      expected = ["http://www.jeffreyleebaird.com/",
                  "http://www.jeffreyleebaird.com/blog",
                  "http://www.jeffreyleebaird.com/blog/posts/giving_up_booze",
                  "http://www.jeffreyleebaird.com/blog/posts/lifting_jiujitsu_and_depression",
                  "http://www.jeffreyleebaird.com/blog/posts/that_didnt_last_long",
                  "http://www.jeffreyleebaird.com/blog/posts/a_letter_a_day",
                  "http://www.jeffreyleebaird.com/blog/posts/first_post",
                  "http://www.jeffreyleebaird.com/public_key"]
      tree = builder.build
      links = []
      tree.traverse{|x| links << x.value.to_s}
      actual = links
      assert actual == expected,"expected: #{expected.inspect} but got: #{actual.inspect}"
    end

    def test_get_all_the_nodes
      builder = PageTreeBuilder.new("http://www.jeffreyleebaird.com/")
      expected = [
        ["http://www.jeffreyleebaird.com/", 0, nil],
        ["http://www.jeffreyleebaird.com/blog", 1, "http://www.jeffreyleebaird.com/"],
        ["http://www.jeffreyleebaird.com/public_key", 1, "http://www.jeffreyleebaird.com/"],
        ["http://www.jeffreyleebaird.com/blog/posts/giving_up_booze", 2, "http://www.jeffreyleebaird.com/blog"],
        ["http://www.jeffreyleebaird.com/blog/posts/lifting_jiujitsu_and_depression", 2, "http://www.jeffreyleebaird.com/blog"],
        ["http://www.jeffreyleebaird.com/blog/posts/that_didnt_last_long", 2, "http://www.jeffreyleebaird.com/blog"],
        ["http://www.jeffreyleebaird.com/blog/posts/a_letter_a_day", 2, "http://www.jeffreyleebaird.com/blog"],
        ["http://www.jeffreyleebaird.com/blog/posts/first_post", 2, "http://www.jeffreyleebaird.com/blog"]
      ]
      actual = builder.get_all_nodes().map{|x| [x.page.url.to_s, x.depth, x.parent_link]}
      assert actual == expected, "expected: #{expected.inspect} but got: #{actual.inspect}"
    end
  end
end
