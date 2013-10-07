require 'spec_helper'

describe 's3cmd::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge('s3cmd::default') }

  context 'the .s3cfg' do
    let(:template) { chef_run.template('/root/.s3cfg') }

    it 'creates the template' do
      expect(chef_run).to create_file('/root/.s3cfg')
    end

    it 'is owned by root:root' do
      expect(template.owner).to eq('root')
      expect(template.group).to eq('root')
    end

    it 'has 0400 permissions' do
      expect(template.mode).to eq('400')
    end
  end
end
