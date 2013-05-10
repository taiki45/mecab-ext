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
        gen_enumrator
      end

      def each_surface
        each {|node| yield node.surface }
      end

      def each_feature
        each {|node| yield node.feature }
      end

      %w(surfaces features lengths ids char_types isbests wcosts costs).each do |plural_name|
        define_method(plural_name) do
          gen_enumrator(plural_name.singularize)
        end
      end

      private

      def gen_enumrator(name = nil)
        Enumerator.new do |y|
          node = @generator.call
          while node
            node = node.next
            unless node.nil? || node.surface.empty?
              y << (name ? node.__send__(name) : node)
            end
          end
          self
        end
      end

    end
  end
end
