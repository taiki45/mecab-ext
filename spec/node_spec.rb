require "spec_helper"

describe Mecab::Ext::Node do
  let(:generator) { double("generator").tap {|o| o.should_receive(:call).and_return(nil) } }
  subject { described_class.new(generator) }

  describe "#each" do
    it "should call generator#call" do
      subject.each {}
    end

    it "should return self" do
      expect(subject.each {}).to equal subject
    end
  end
end
