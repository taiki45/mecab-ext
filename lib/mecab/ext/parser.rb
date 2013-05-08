require "active_support/core_ext/module/delegation"

module MeCab
  module Ext
    class Parser
      attr_reader :__tagger__
      delegate :parseString, :parseNBestInit, :to => :__tagger__

      def initialize(opt = {})
        @__tagger__ = MeCab::Tagger.new
      end

      def parse(str)
        Node.new(@__tagger__.parseToNode(str))
      end

      alias :parseToNode :parse
      alias :parse_to_node :parse
    end

    class Node
      include Enumerable

      def initialize(original)
        @nodes = original
      end

      def each
        while node = @nodes.next
          yield node
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
