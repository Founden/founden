require 'spec_helper'

describe Location do
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:latitude) }

  context 'instance' do
    subject(:location) { Fabricate(:location) }

    its(:longitude) { should_not be_blank }
    its(:latitude) { should_not be_blank }
  end

end
