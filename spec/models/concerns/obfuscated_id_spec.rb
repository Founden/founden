require 'spec_helper'

describe ObfuscatedId do
  subject(:klass) do
    Class.new ActiveRecord::Base do
      self.table_name = User.table_name
      attr_accessor :slug

      include ObfuscatedId
    end
  end

  context 'instance' do
    subject(:klass_inst) { klass.new }

    its(:slug) { should be_blank }

    context '#friendly_id' do
      before { subject.valid? }

      its(:slug) { should_not be_blank }
      its(:slug) { should eq(klass_inst.friendly_id) }
    end

    context '#obfuscated_ids' do
      subject { klass_inst.obfuscated_ids }

      it { should be_an(Array) }
      its(:length) { should eq(3) }

      its(:first) { should be_a(String) }
      its('first.length') { should eq(10) }
      its('last.length') { should eq(40) }
    end
  end
end
