require 'spec_helper'

describe Location do

  context 'instance' do
    subject(:location) { Fabricate(:location) }

    its(:longitude) { should_not be_blank }
    its(:latitude) { should_not be_blank }
  end

end
