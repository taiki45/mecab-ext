module Mecab
  module Ext
    class Node
      include Enumerable

      def initialize(generator)
        @generator = generator
      end

      # TODO: don't yield empty string
      def each
        node = @generator.call
        while node
          node = node.next
          yield node if node && node != ""
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
