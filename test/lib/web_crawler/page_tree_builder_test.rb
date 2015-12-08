require_relative '../../test_helper'
module WebCrawler
  class PageTreeBuilderTest < Minitest::Test

    def test_that_a_tree_can_be_constructed
      builder = PageTreeBuilder.new("http://www.jeffreyleebaird.com/")
      tree = builder.build
      expected = [
        "http://www.jeffreyleebaird.com/",
        "http://www.jeffreyleebaird.com/blog",
        "http://www.jeffreyleebaird.com/blog/posts/giving_up_booze",
        "http://www.jeffreyleebaird.com/blog/posts/lifting_jiujitsu_and_depression",
        "http://www.jeffreyleebaird.com/public_key",
        "http://www.jeffreyleebaird.com/blog/posts/that_didnt_last_long",
        "http://www.jeffreyleebaird.com/blog/posts/a_letter_a_day",
        "http://www.jeffreyleebaird.com/blog/posts/first_post"
      ]
      nodes =  []
      tree.traverse{|x| nodes << x.value.to_s}
      actual = nodes
      assert actual == expected, "expected: #{expected.inspect} but got: #{actual.inspect}"
    end
  end
end
