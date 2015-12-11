require 'awesome_print'
module WebCrawler
  class JsonViewer

    attr_reader :root_tree, :hash_collection

    def initialize(root_tree)
      @root_tree = root_tree
      @hash_collection = []
    end

    def to_h(tree)
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

    def to_json
      to_h(root_tree).to_json
    end

    def print
      ap to_h(root_tree)
    end

  end
end
