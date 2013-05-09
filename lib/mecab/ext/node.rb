module Mecab
  module Ext
    class Node
      include Enumerable

      def initialize(generator)
        @generator = generator
      end

      def each
        node = @generator.call
        while node
          node = node.next
          yield node if node.respond_to?(:surface) && !node.surface.empty?
        end
        self
      end

      def each_surface
        each {|node| yield node.surface }
      end

      def each_feature
        each {|node| yield node.feature }
      end
    end
  end
end
