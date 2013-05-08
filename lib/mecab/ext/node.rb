module MeCab
  module Ext
    class Node
      include Enumerable

      def initialize(original)
        @node = original
      end

      def each
        node = @node
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
