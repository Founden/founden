require 'spec_helper'

describe Api::V1::MiscController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#websocket' do
    it 'raises Tubesock error' do
      expect {
        get(:websocket)
      }.to raise_error(Tubesock::HijackNotAvailable)
    end
  end

  describe '#md5' do
    let(:query) { }

    before { get(:md5, :query => query) }

    subject(:api_hash) { json_to_ostruct(response.body) }

    context 'with a valid query' do
      let(:query) { Faker::Lorem.word }

      it { api_hash[:hash].should eq(Digest::MD5.hexdigest(query)) }
    end

    context 'with an invalid query' do
      let(:query) { nil }

      subject { response }

      its(:status) { should eq(400) }
      its(:body) { should include('We were expecting a different input') }
    end
  end
end
