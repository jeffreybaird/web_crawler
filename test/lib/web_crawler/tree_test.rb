require_relative '../../test_helper'
module WebCrawler
  class TreeTest < Minitest::Test
    def test_tree_with_single_branch
      a3 = Tree.new("end")
      a2 = Tree.new("middle", [a3])
      a1 = Tree.new("root",[a2])
      expected = ["root", "middle", "end"]
      nodes = []
      a1.traverse{|x| nodes << x.value }
      actual = nodes
      assert actual == expected, "expected: #{expected.inspect} but got: #{actual.inspect}"
    end

    def test_tree_with_multiple_branches
      a3a = Tree.new("end-a3")
      b3b = Tree.new("end-b3b")
      b3a = Tree.new("end-b3a")
      a2 = Tree.new("middle-a", [a3a])
      b2 = Tree.new("middle-b", [b3a, b3b])
      a1 = Tree.new("root",[a2, b2])
      expected = ["root", "middle-a", "end-a3", "middle-b", "end-b3a", "end-b3b"]
      nodes =  []
      a1.traverse{|x| nodes << x.value }
      actual = nodes
      assert actual == expected, "expected: #{expected.inspect} but got: #{actual.inspect}"
    end

  end
end
