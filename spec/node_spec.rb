require "spec_helper"

describe Mecab::Ext::Node do

  shared_context %{with MeCab::Node like mock which given "test string"}, mecab: :nodes do
    let(:first_node) do
      n = mock("node").tap {|o| o.stub(:surface).and_return("") }
      n.stub(:feature).and_return("")
      n.tap {|o| o.stub(:next).and_return(second_node) }
    end
    let(:second_node) do
      n = mock("node").tap {|o| o.stub(:surface).and_return("test") }
      n.stub(:feature).and_return("test feature")
      n.tap {|o| o.stub(:next).and_return(third_node) }
    end
    let(:third_node) do
      n = mock("node").tap {|o| o.stub(:surface).and_return("string") }
      n.stub(:feature).and_return("string feature")
      n.tap {|o| o.stub(:next).and_return(fourth_node) }
    end
    let(:fourth_node) do
      n = mock("node").tap {|o| o.stub(:surface).and_return("") }
      n.stub(:feature).and_return("")
      n.tap {|o| o.stub(:next).and_return(nil) }
    end
    let(:generator) { double("generator", call: first_node) }
    let(:tests) { Array.new }

    subject { described_class.new(generator) }
  end


  describe "#each" do
    context "with generator mock" do
      let(:generator) do
        mock("generator").tap {|o| o.should_receive(:call).at_least(:once).and_return(nil) }
      end
      subject { described_class.new(generator) }

      it "calls given generator's :call" do
        subject.each {}
      end

      it "returns self" do
        expect(subject.each {}).to equal subject
      end

      it "returns enumerable" do
        Enumerable.instance_methods.each do |method_name|
          expect(subject.each {}).to be_respond_to method_name
        end
      end
    end

    context "with node mocks" do
      let(:node) do
        n = mock("node").tap {|o| o.stub(:next).and_return(nil) }
        n.tap {|o| o.should_receive(:surface).and_return("test") }
      end
      let(:parent_node) { mock("node").tap {|o| o.should_receive(:next).and_return(node) } }
      let(:generator) { double("generator").tap {|o| o.stub(:call).and_return(parent_node) } }
      subject { described_class.new(generator) }

      it "calls node#next" do
        subject.each {}
      end

      it "yields sub node" do
        subject.each {|test| expect(test).to equal node }
      end
    end

    context %(with mecab nodes which given "test string"), mecab: :nodes do
      it "yields nodes" do
        subject.each {|node| expect(node).to be_a RSpec::Mocks::Mock }
      end

      it "yields 2 nodes" do
        subject.each {|node| tests.push node }
        expect(tests).to have(2).nodes
      end

      it "yields nodes which respond to :surface" do
        subject.each {|node| expect(node).to be_respond_to :surface }
      end
    end
  end


  describe "#each_surface" do
    context %(with mecab nodes which given "test string"), mecab: :nodes do
      it "yields 2 surfaces" do
        subject.each_surface {|surface| tests.push surface }
        expect(tests).to have(2).surfaces
      end

      it "yields each surface" do
        subject.each_surface {|surface| tests.push surface }
        expect(tests).to be_include "test"
        expect(tests).to be_include "string"
      end
    end
  end

  describe "#each_feature" do
    context %(with mecab nodes which given "test string"), mecab: :nodes do
      it "yields 2 features" do
        subject.each_feature {|feature| tests.push feature }
        expect(tests).to have(2).features
      end

      it "yields each features" do
        subject.each_feature {|feature| tests.push feature }
        expect(tests).to be_include "test feature"
        expect(tests).to be_include "string feature"
      end
    end
  end

  describe "its plural methods" do
    context %(with mecab nodes which given "test string"), mecab: :nodes do

      describe "#surfaces" do
        it "returns enumerator" do
          expect(subject.surfaces).to be_a Enumerator
        end

        it "iterates nodes surfaces" do
          subject.surfaces.each {|surface| tests.push surface }
          expect(tests).to have(2).surfaces
          expect(tests).to be_include "test"
          expect(tests).to be_include "string"
        end

        it "can fold" do
          expect(subject.surfaces.reduce("", &:+)).to eq "teststring"
        end
      end

      %w(features lengths ids char_types isbests wcosts costs).each do |name|
        describe "##{name}" do
          it "iterates #{name}" do
            expect(subject.send(name)).to be_a Enumerator
          end

          it "iterates #{name.singularize} value" do
            second_node.stub(name.singularize).and_return(:test)
            subject.send(name) {|test| expect(test).to equal :test }
          end
        end
      end

    end
  end

end
