module Mecab
  module Ext
    module Parser
      class << self
        @@tagger = nil
        def parse(str)
          generator = lambda { (@@tagger ||= MeCab::Tagger.new).parseToNode(str) }
          Node.new(generator)
        end

        alias :parseToNode :parse
        alias :parse_to_node :parse
      end
    end
  end
end
