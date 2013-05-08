module Mecab
  module Ext
    module Parser
      class << self
        def parse(str)
          generator = lambda { ::MeCab::Tagger.new.parseToNode(str) }
          Node.new(generator)
        end

        alias :parseToNode :parse
        alias :parse_to_node :parse
      end
    end
  end
end
