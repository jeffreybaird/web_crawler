module WebCrawler
  class Tree
    attr_accessor :value, :children, :parent

   def initialize(value, children = [],parent=nil)
     @value = value
     @children = children
     @parent = parent
   end

   def add_child(child)
     children << child
     self
   end

   def to_h(hash_acc=value.to_h)
     root_hash = value.to_h
     root_hash[:children] = traverse.map{|child| child.to_h }
     root_hash
   end

   def traverse(&block)
     return enum_for(:traverse) unless block_given?
     yield self
     @children.each { |child| child.traverse(&block) }
   end

  end
end
