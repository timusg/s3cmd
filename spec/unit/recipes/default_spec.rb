require 'spec_helper'

describe 's3cmd::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge('s3cmd::default') }

  context 'the .s3cfg' do
    let(:template) { chef_run.template('/root/.s3cfg') }

    it 'creates the template with values in attributes' do
      expect(chef_run).to create_file_with_content('/root/.s3cfg', 'attr_foo')
      expect(chef_run).to create_file_with_content('/root/.s3cfg', 'attr_bar')
    end

    it 'is owned by root:root' do
      expect(template.owner).to eq('root')
      expect(template.group).to eq('root')
    end

    it 'has 0400 permissions' do
      expect(template.mode).to eq('400')
    end

    it 'create file with data bag contentens when provided' do
      Chef::Recipe.any_instance.stub(:data_bag_item).with(:aws, 'credentials').and_return({"secret_key" => "s3cmd-access", "access_key" => "s3cmd-secret"})
      chef_run.node.set['s3cmd']['data_bag'] = 'aws'
      chef_run.converge 's3cmd::default'
      expect(chef_run).to create_file_with_content('/root/.s3cfg', 's3cmd-access')
      expect(chef_run).to create_file_with_content('/root/.s3cfg', 's3cmd-secret')
    end

  end
end
