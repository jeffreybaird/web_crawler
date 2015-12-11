module WebCrawler
  class PageTreeBuilder
    VISITED = []
    attr_reader :root, :node_collection

    def initialize(url)
      @root = Page.new(url)
      @visited = [url.to_s]
      @node_collection = get_all_nodes([Node.new(0, @root, nil)])
    end

    def visited
      @visited
    end

    def build
      build_the_tree(node_collection)
    end

    def get_all_nodes(nodes=node_collection)
      return nodes if (get_links_from_deepest_pages(nodes) - visited).empty?
      get_the_deepest_nodes(nodes).each do |node|
        node.page.local_links.each do |link|
          next if visited.include?(link.to_s)
          visited << link.to_s
          nodes << Node.new(node.depth + 1, Page.new(link),node.page.url.to_s)
        end
      end
      get_all_nodes(nodes)
    end

    def get_the_deepest_nodes(nodes)
      max_depth = nodes.max{|x| x.depth}.depth
      nodes.select{|node| node.depth == max_depth}
    end

    def get_links_from_deepest_pages(nodes)
      get_the_deepest_nodes(nodes).map{|node| node.page.local_links}.flatten.map(&:to_s)
    end

    def build_the_tree(nodes, trees=nil)
      return trees.first if nodes.empty?
      base = get_the_deepest_nodes(nodes)
      if trees
        new_trees = base.map{|n| Tree.new(n.page, get_children(n,trees), n.parent_link) }
      else
        new_trees = base.map{|n| Tree.new(n.page, [], n.parent_link) }
      end
      #binding.pry
      build_the_tree(nodes - base,new_trees)
    end

    def get_children(node,trees)
      trees.select{|t| t.parent == node.page.url.to_s}
    end

    Node = Struct.new(:depth, :page ,:parent_link)
  end
end
