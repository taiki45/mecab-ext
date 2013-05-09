require "spec_helper"

describe Mecab::Ext::Node do

  describe "#each" do
    context "with generator mock" do
      let(:generator) { mock("generator").tap {|o| o.should_receive(:call).and_return(nil) } }
      subject { described_class.new(generator) }

      it "calls given generator's :call" do
        subject.each {}
      end

      it "returns self" do
        expect(subject.each {}).to equal subject
      end
    end

    context "with node mocks" do
      let(:node) { mock("node").tap {|o| o.stub(:next).and_return(nil) } }
      let(:parent_node) { mock("node").tap {|o| o.should_receive(:next).and_return(node) } }
      let(:generator) { double("generator").tap {|o| o.stub(:call).and_return(parent_node) } }
      subject { described_class.new(generator) }

      it "calls node#next" do
        subject.each {}
      end

      it " yields sub node" do
        subject.each {|test| expect(test).to equal node }
      end
    end
  end

end
