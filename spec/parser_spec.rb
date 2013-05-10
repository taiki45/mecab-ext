require 'spec_helper'

describe Mecab::Ext::Parser do

  describe ".parse" do
    subject { described_class.parse("test string") }

    it "should return Node instance" do
      expect(subject).to be_instance_of Mecab::Ext::Node
    end

    it "should call Node.new" do
      Mecab::Ext::Node.stub(:new).and_return("called")
      expect(subject).to eq "called"
    end

    it "should pass proc to Node#initialize" do
      Mecab::Ext::Node.should_receive(:new) do |arg|
        expect(arg).to be_instance_of Proc
      end
      subject
    end

    it "should pass callable obj" do
      Mecab::Ext::Node.should_receive(:new) do |arg|
        expect(arg).to be_respond_to :call
      end
      subject
    end
  end

  describe ".parseToNode" do
    subject { described_class.method(:parseToNode) }
    it { should eq described_class.method(:parse) }
  end

  describe ".parse_to_node" do
    subject { described_class.method(:parse_to_node) }
    it { should eq described_class.method(:parse) }
  end

end
