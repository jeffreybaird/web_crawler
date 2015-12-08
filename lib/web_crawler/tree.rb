module WebCrawler
  class Tree
    attr_accessor :value, :children

   def initialize(value, children = [])
     @value = value
     @children = children
   end

   def add_child(child)
     children << child
     self
   end
   def traverse(&block)
     yield self
     @children.each { |child| child.traverse(&block) }
   end

  end
end
