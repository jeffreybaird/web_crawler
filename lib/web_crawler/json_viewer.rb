module WebCrawler
  class JsonViewer

    attr_reader :root_tree

    def initialize(root_tree)
      @root_tree = root_tree
    end

    def to_h(tree=root_tree)
      page = tree.value
      {
      resource: page.to_s,
      assets: {
          stylesheets: page.stylesheets,
          images: page.images,
          scripts: page.scripts
        },
      children: tree.children.empty? ? [] : tree.children.map{|child| to_h(child)}}
    end

  end
end
