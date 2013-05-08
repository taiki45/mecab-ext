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
          yield node
          node = node.next
        end
        self
      end

      def surfaces
        each {|node| yield node.surface }
      end

      def features
        each {|node| yield node.feature }
      end
    end
  end
end
