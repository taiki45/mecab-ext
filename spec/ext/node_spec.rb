require "spec_helper"

describe Mecab::Ext::Node do
  let(:generator) { double("generator").tap {|o| o.should_receive(:call) } }
  subject { described_class.new(generator) }

  describe "#each" do
    it "should call generator#call" do
      subject.each {|e| }
    end
  end
end
