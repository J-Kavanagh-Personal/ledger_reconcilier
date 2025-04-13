# frozen_string_literal: true

require 'rspec'
require './lib/services/event_processor'

RSpec.describe EventProcessor do

  subject(:event_processor) { described_class.new(file: file) }

  context 'when file is provided' do

    let(:file) { 'spec/support/events_for_testing.json' }

    it 'reads the file and creates a set of ids' do
      event_processor.process
      expect(event_processor.ids).to contain_exactly('evt_0b55cbdc', 'evt_1d7065ee')
    end

    it 'read the file and creates an array of duplicate events' do
      event_processor.process
      expect(event_processor.duplicates).to contain_exactly('evt_1d7065ee')
    end
  end
end
