require 'spec_helper'

describe MeCab::Ext::Parser do
  let(:tagger) { double("tagger") }

  %w(parse parseToNode parseString parseNBestInit).each do |name|
    it "shoud delegate #{name} to MeCab::Tagger instance" do
      tagger.should_receive(name.to_sym)
      subject.instance_variable_set(:@__tagger__, tagger)
      subject.send(name)
    end
  end
end
