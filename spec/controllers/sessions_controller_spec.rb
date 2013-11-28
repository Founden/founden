require 'spec_helper'

describe SessionsController do

  describe '#after_successful_sign_in_url' do
    it 'returns after redirect location' do
      controller.send(:after_successful_sign_in_url).should eq(root_path)
    end
  end

  describe '#index' do
    before do
      get(:index)
    end

    it { should render_template(:index) }
  end

end
