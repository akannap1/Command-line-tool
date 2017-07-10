require 'spec_helper'

RSpec.describe Search do
  let(:user_data) { File.open(File.join('spec', 'stubs', 'users.json')).read }
  let(:list_all_fields) { @search_users.list_all_fields }
  let(:data_obtained) { @search_users.find_all('_id', '1').first }

  before(:each) do
    @users_data = JSON.parse user_data
    @search_users = Search.new(@users_data)
  end

  context 'while validating keys' do
    it { expect(@search_users.has_key?('_id')).to eq(true) }
    it { expect(@search_users.has_key?('alias')).to eq(true) }
    it { expect(@search_users.has_key?('signature')).to eq(true) }
    it { expect(@search_users.has_key?('phone')).to eq(true) }
    it { expect(@search_users.has_key?('test')).to eq(false) }
    it { expect(@search_users.has_key?('locale')).to eq(true) }
    it { expect(@search_users.has_key?('active')).to eq(true) }
  end

  context 'list of fields' do
    it { expect(list_all_fields).to include('shared') }
    it { expect(list_all_fields).to include('verified') }
    it { expect(list_all_fields).to include('timezone') }
    it { expect(list_all_fields).to include('tags') }
    it { expect(list_all_fields).to include('email') }
    it { expect(list_all_fields).not_to include('last-login') }
    it { expect(list_all_fields).to include('last_login_at') }
  end

  context 'User data key pairs' do
    it { expect(data_obtained['name']).to eq('Francisca Rasmussen') }
    it { expect(data_obtained['alias']).to eq('Miss Coffey') }
    it { expect(data_obtained['timezone']).to eq('Sri Lanka') }
    it { expect(data_obtained['phone']).to eq('8335-422-718') }
    it { expect(data_obtained['shared']).to eq(false) }
    it { expect(data_obtained['active']).to eq(true) }
  end

  context 'validating find_all' do
    it { expect(@search_users.find_all('tags', 'Springville')).not_to be_empty }
    it { expect(@search_users.find_all('tags', 'uuu')).to be_empty }
    it { expect(@search_users.find_all('locale', 'uuu')).to be_empty }
  end
end
