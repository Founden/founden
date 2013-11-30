require 'spec_helper'

describe Upload do
  include Paperclip::Shoulda::Matchers

  it { should have_attached_file(:attachment) }
  it { should validate_attachment_presence(:attachment) }

  context 'instance' do
    subject(:upload) { Fabricate(:upload) }

    it { should be_valid }
    its(:attachment) { should be_a(Paperclip::Attachment) }
  end
end
