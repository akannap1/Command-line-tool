require 'spec_helper'

RSpec.describe UserPrompt do
  let(:file_paths) { UserPrompt::ENTITY_FILE_PATHS }
  let(:list_of_results) { { _id: 12, role: 'admin' } }

  context 'Welcome Message' do
    it { expect(UserPrompt::WELCOME_MESSAGE).to include('quit to exit') }
    it { expect(UserPrompt::WELCOME_MESSAGE).to include('Welcome To Zendesk Search') }
    it { expect(UserPrompt::WELCOME_MESSAGE).to include('Select Search Options') }
    it { expect(UserPrompt::WELCOME_MESSAGE).to include('Press 1 to search') }
    it { expect(UserPrompt::WELCOME_MESSAGE).to include('Press 2 to view') }
    it { expect(UserPrompt::WELCOME_MESSAGE).to include('a list of searchable fields') }
  end

  context 'Exit Message' do
    it { expect(UserPrompt::EXIT_MESSAGE).to include('See you later..') }
  end

  context 'Invalid Message' do
    it { expect(UserPrompt::INVALID_MESSAGE).to include('Invalid Option') }
    it { expect(UserPrompt::INVALID_MESSAGE).to include('Please choose') }
    it { expect(UserPrompt::INVALID_MESSAGE).to include('right option and try again') }
  end

  context 'Entity Not Found' do
    it { expect(UserPrompt::ENTITY_NOT_FOUND).to include('Please select a valid entity') }
  end

  context 'Field Not Found' do
    it { expect(UserPrompt::FIELD_NOT_FOUND).to include('Field Doesnt Exist') }
    it { expect(UserPrompt::FIELD_NOT_FOUND).to include('For The Entity') }
  end

  context 'Results Not Found' do 
    it { expect(UserPrompt::RESULTS_NOT_FOUND).to include('Results not Found') }
  end

  context 'Entity File Paths' do
    it 'should include .json' do
      file_paths.each do |path|
        expect(path).to include('.json')
        expect(path).to include('json_data')
      end
    end
  end

  context 'Print List Of Entities' do
    it { expect { UserPrompt.print_list_of_entities }.to output(/Select/).to_stdout }
    it { expect { UserPrompt.print_list_of_entities }.to output(/Organizations/).to_stdout }
    it { expect { UserPrompt.print_list_of_entities }.to output(/Tickets/).to_stdout }
    it { expect { UserPrompt.print_list_of_entities }.to output(/Users/).to_stdout }
  end

  context 'Pretty Print' do
    it { expect { UserPrompt.pretty_print([]) }.to raise_error(/Results not Found/) }
    it { expect { UserPrompt.pretty_print(list_of_results) }.to output(/12/).to_stdout }
    it { expect { UserPrompt.pretty_print(list_of_results) }.to output(/admin/).to_stdout }
    it { expect { UserPrompt.pretty_print(list_of_results) }.to output(/_id/).to_stdout }
    it { expect { UserPrompt.pretty_print(list_of_results) }.to output(/role/).to_stdout }
  end
end
