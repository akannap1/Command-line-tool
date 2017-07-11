require_relative '../main.rb'
require_relative 'support/stub_constants.rb'

RSpec.describe Main do
  describe '.run' do
    context 'while inputting quit in the zendesk search' do
      let(:select_input_quit) { allow(Main).to receive(:gets).and_return('quit') }

      before(:each) do
        select_input_quit
      end

      it { expect { Main.run }.to raise_error(SystemExit) }
    end
  end

  describe '.execute_action' do
    context 'while selecting search on users key and values' do
      let(:select_search_input) { allow(Main).to receive(:gets).and_return('1', '3', 'role', 'admin') }
      let(:u_entity_file) { allow_any_instance_of(SearchClient).to receive(:get_entity_file).and_return(StubConstants::USERS_STUB_PATH) }

      before(:each) do
        select_search_input
        u_entity_file
        @data = Main.send(:execute_action).first
      end

      it { expect(@data['_id']).to eq(1) }
      it { expect(@data['name']).not_to eq('Anuraag') }
    end

    context 'while selecting search on fields' do
      let(:select_search_input) { allow(Main).to receive(:gets).and_return('2', '2') }
      let(:t_entity_file) { allow_any_instance_of(SearchClient).to receive(:get_entity_file).and_return(StubConstants::TICKET_STUB_PATH) }

      before(:each) do
        t_entity_file
        select_search_input
        @data = Main.send(:execute_action)
      end

      it { expect(@data).to include('submitter_id') }
      it { expect(@data).to include('assignee_id') }
      it { expect(@data).not_to include('name') }
    end

    context 'selecting wrong input after welcome message ' do 
      let(:select_wrong_input) { allow(Main).to receive(:gets).and_return('2', 'wrong_input') }
 
      before(:each) do
        select_wrong_input
      end

      it { expect { Main.send(:execute_action) }.to output(/valid entity/).to_stdout }
      

    end


    context 'while selecting a wrong input' do
      let(:select_invalid_option) { allow(Main).to receive(:gets).and_return('wrong input') }

      before(:each) do
        select_invalid_option
      end

      it { expect { Main.send(:execute_action) }.to output(/Invalid Option/).to_stdout }
      it { expect { Main.send(:execute_action) }.to output(/Please choose right option/).to_stdout }
    end
  end
end
