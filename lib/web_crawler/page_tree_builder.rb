module WebCrawler
  class PageTreeBuilder
    VISITED = []
    attr_reader :root
    
    def initialize(url)
      @root = Page.new(url)
      @visited = VISITED << url
    end

    def build
      return tree_node if all_child_links_have_been_visited? && children_of_children_visited?
      add_children
    end

    def visited
      VISITED.uniq
    end

    def tree_node
      @tree_node ||= Tree.new(root)
    end

    def add_children
      root.local_links.each do |link|
        next if visited.include?(link.to_s)
        builder = PageTreeBuilder.new(link.to_s)
        visited << link.to_s
        tree_node.add_child(builder.build)
      end
      build
    end

    def children_of_children_visited?
      return true if tree_node.children.empty?
      tree_node.children.map do |child|
        PageTreeBuilder.new(child.value.to_s).all_child_links_have_been_visited?
      end.all?
    end

    def all_child_links_have_been_visited?
      remaining = (root.local_links.map(&:to_s) - visited)
      remaining.empty?
    end

  end
end
