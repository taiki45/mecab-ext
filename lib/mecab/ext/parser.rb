module Mecab
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
  end
end
