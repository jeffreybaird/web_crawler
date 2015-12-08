module WebCrawler
  class Tree
    attr_accessor :name, :children

   def initialize(name, children = [])
     @name = name
     @children = children
   end

   def traverse(&block)
     yield self
     @children.each { |child| child.traverse(&block) }
   end

  end
end
