require 'spec_helper'
require_relative '../support/stub_constants.rb'

RSpec.describe SearchClient do
  include SearchClient

  let(:setup_action_search) { allow(self).to receive(:gets).and_return('1') }
  let(:setup_action_fields) { allow(self).to receive(:gets).and_return('2') }
  let(:setup_action_wrong) { allow(self).to receive(:gets).and_return('wrong') }

  let(:u_entity_file) { allow_any_instance_of(SearchClient).to receive(:get_entity_file).and_return(StubConstants::USERS_STUB_PATH) }
  let(:o_entity_file) { allow_any_instance_of(SearchClient).to receive(:get_entity_file).and_return(StubConstants::ORG_STUB_PATH) }
  let(:t_entity_file) { allow_any_instance_of(SearchClient).to receive(:get_entity_file).and_return(StubConstants::TICKET_STUB_PATH) }
  

  describe '#setup_action' do
    context 'while initiating search object with user data' do
      before(:each) do
        setup_action_search
        u_entity_file
        @data = setup_action.data.first
      end

      it { expect(@data['_id']).to eq(1) }
      it { expect(@data['name']).to eq('Francisca Rasmussen') }
    end

    context 'while initiating search object with ticket data' do
      before(:each) do
        setup_action_fields
        t_entity_file
        @data = setup_action.data.first
      end

      it { expect(@data['_id']).to eq('436bf9b0-1147-4c0a-8439-6f79833bff5b') }
      it { expect(@data['type']).to eq('incident') }
      it { expect(@data['subject']).not_to eq('north') }
    end

    context 'while initiating a wrong choice' do
      before(:each) do
        setup_action_wrong
      end

      it { expect { setup_action }.to raise_error('Please select a valid entity') }
    end
  end

  describe '#view fields' do
    context 'while listing ticket fields' do
      before(:each) do
        setup_action_fields
        @fields = view_fields
      end

      it { expect(@fields).to include('url') }
      it { expect(@fields).to include('type') }
      it { expect(@fields).to include('priority') }
    end

    context 'while listing users fields' do
      let(:user_fields) { allow(self).to receive(:gets).and_return('3') }

      before(:each) do
        user_fields
        @fields = view_fields
      end

      it { expect(@fields).to include('tags') }
      it { expect(@fields).to include('suspended') }
      it { expect(@fields).to include('signature') }
    end

    context 'while inputting wrong input' do
      let(:wrong_input) { allow(self).to receive(:gets).and_return('66') }

      before(:each) do
        wrong_input
      end

      it { expect { view_fields }.to raise_error('Please select a valid entity') }
    end
  end

  describe '#search' do
    context 'while searching org data with user inputted key and value' do
      let(:stub_search_org_key_value) { allow(self).to receive(:gets).and_return('1', 'name', 'Enthaze') }

      before(:each) do
        o_entity_file
        stub_search_org_key_value
        @data_output = search.first
      end

      it { expect(@data_output['_id']).to eq(101) }
      it { expect(@data_output['name']).to eq('Enthaze') }
      it { expect(@data_output['domain_names']).to include('kage.com') }
      it { expect(@data_output['domain_names']).to include('zentix.com') }
    end

    context 'while searching user data with user inputted key and value' do
      let(:stub_search_tick_key_value) { allow(self).to receive(:gets).and_return('2', 'type', 'incident') }

      before(:each) do
        t_entity_file
        stub_search_tick_key_value
        @data_output = search.first
      end

      it { expect(@data_output['assignee_id']).to eq(24) }
      it { expect(@data_output['tags']).to include('Pennsylvania') }
      it { expect(@data_output['tags']).not_to include('Devon') }
      it { expect(@data_output['status']).not_to eq('notpending') }
    end

    context 'while inputting wrong key' do 
      let(:stub_wrong_key) { allow(self).to receive(:gets).and_return('1', 'wrong_key', 'value') }

      before(:each) do 
        t_entity_file
        stub_wrong_key
      end

      it { expect{search}.to raise_error('Field Doesnt Exist For The Entity') }
    end

    context 'while inputting wrong value' do 
      let(:stub_wrong_value) { allow(self).to receive(:gets).and_return('2', 'type', 'wrong_value') }

      before(:each) do 
        t_entity_file
        stub_wrong_value
      end

      it { expect{search}.to raise_error('Results not Found ...') }
    end
  end

  describe '#get_entity_file' do
    it 'should include users' do
      u_entity_file
      expect(get_entity_file(3)).to include('spec/stubs/users.json')
    end

    it 'should include org' do
      o_entity_file
      expect(get_entity_file(1)).to include('spec/stubs/organizations.json')
    end

    it 'should include tickets' do
      t_entity_file
      expect(get_entity_file(2)).to include('spec/stubs/tickets.json')
    end
  end
end
