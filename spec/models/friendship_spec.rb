require 'spec_helper'

require 'membership'
require 'friendship'

describe Friendship do
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:user) }

  context 'instance' do
    subject(:friendship) do
      Fabricate(:membership, :type => Friendship.name)
    end

    it { should_not be_new_record }

    context 'requires no user duplicates' do
      subject(:duplicate) do
        Friendship.new(:creator => friendship.creator, :user => friendship.user)
      end

      it { should_not be_valid }
    end
  end
end
