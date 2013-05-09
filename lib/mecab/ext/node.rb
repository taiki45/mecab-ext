module Mecab
  module Ext
    class Node

      delegate *Enumerable.instance_methods, :each, to: :__enum__
      attr_reader :__enum__

      def initialize(generator)
        @generator = generator
        @__enum__ = to_enum
      end

      def to_enum
        Enumerator.new do |y|
          node = @generator.call
          while node
            node = node.next
            y << node if node.respond_to?(:surface) && !node.surface.empty?
          end
          self
        end
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
