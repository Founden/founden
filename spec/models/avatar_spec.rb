require 'spec_helper'

describe Avatar do
  include Paperclip::Shoulda::Matchers

  it { should have_attached_file(:attachment) }

  it { should validate_attachment_content_type(:attachment)
       .allowing(Avatar::IMAGE_TYPES)
       .rejecting('text/plain')
  }
  it { should validate_presence_of(:user) }
  it { should validate_attachment_presence(:attachment) }

  context 'instance' do
    subject(:avatar) { Fabricate(:avatar) }

    it { should be_valid }
    its(:attachment) { should be_a(Paperclip::Attachment) }
  end
end
