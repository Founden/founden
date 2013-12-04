require 'spec_helper'

describe Timestamp do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:network) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:timestamp) }

  context 'instance' do
    subject(:timestamp) { Fabricate(:timestamp) }

    its(:timestamp) { should_not be_blank }

    context '#timestamp' do
      let(:invalid_timestamp) { 'String' }

      before { timestamp.timestamp = invalid_timestamp }

      it { should_not be_valid }
    end
  end

end
