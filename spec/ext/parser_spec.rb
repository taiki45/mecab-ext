require 'spec_helper'

describe MeCab::Ext::Parser do
  let(:tagger) { double("tagger") }

  %w(parseString parseNBestInit).each do |name|
    it "shoud delegate #{name} to MeCab::Tagger instance" do
      tagger.should_receive(name.to_sym)
      subject.instance_variable_set(:@__tagger__, tagger)
      subject.send(name)
    end
  end

  shared_context "with tagger mock", tagger: :mock do
    let(:instance) { described_class.new }
    before do
      tagger.should_receive(:parseToNode)
      instance.instance_variable_set(:@__tagger__, tagger)
    end
  end

  describe "#parse", tagger: :mock do
    subject { instance }
    it "shoud call Tagger#parseToNode" do
      subject.parse("test string")
    end
  end

end
