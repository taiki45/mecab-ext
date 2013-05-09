require 'spec_helper'

describe Mecab::Ext::Parser do

  describe ".parse" do
    subject { described_class.parse("test string") }
    it "should return Node instance" do
      expect(subject).to be_instance_of Mecab::Ext::Node
    end
  end

end
