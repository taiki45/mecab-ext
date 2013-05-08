require "active_support/core_ext/module/delegation"

module MeCab
  module Ext
    class Parser

      delegate :parse, :parseToNode, :parseString, :parseNBestInit, :to => :__tagger__

      def initialize(opt = {})
        @tagger = MeCab.Tagger.new
      end

      def __tagger__
        @tagger
      end
    end

    class Node
      include Enumurable

      def initialize(orginal)
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
