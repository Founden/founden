require 'spec_helper'

describe ObfuscatedId do
  subject(:klass) do
    Class.new do
      include ObfuscatedId
    end
  end

  context '#obfuscated_id' do
    subject { klass.new.obfuscated_id }

    it { should be_a(String) }
    its(:length) { should eq(10) }
  end
end
