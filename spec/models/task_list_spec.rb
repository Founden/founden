require 'spec_helper'

describe TaskList do
  it { should validate_presence_of(:tasks) }

  context 'instance' do
    subject(:task_list) { Fabricate(:task_list) }

    its(:tasks) { should_not be_empty }

    context '#tasks' do
      let(:label) { Faker::HTMLIpsum.body }
      let(:task) { {:label => label} }
      let(:tasks) { [task] }

      before{ task_list.update_attributes(:tasks => tasks) }

      subject { task_list.tasks }

      context 'on addition of an' do
        its(:size) { should eq(1) }
        its('first.keys.size') { should eq(2) }

        context 'task' do
          subject { OpenStruct.new(task_list.tasks.first) }

          its(:label) { should eq(Sanitize.clean(label)) }
          its(:checked) { should be_false }
        end
      end

      context 'when adding nothing' do
        let(:tasks) { '' }

        it { should be_empty }
      end

      context 'on adding an empty task' do
        let(:task) { '' }

        it { should be_empty }
      end

      context 'on adding a string' do
        let(:task) { Faker::HTMLIpsum.body }

        it { should be_empty }
      end
    end
  end

end
