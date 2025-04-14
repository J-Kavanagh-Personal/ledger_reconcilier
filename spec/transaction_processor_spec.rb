# frozen_string_literal: true

require 'rspec'
require './lib/services/transaction_processor'
require './lib/models/transaction'

RSpec.describe TransactionProcessor do

  subject(:transaction_processor) { described_class.new(file: file, event_ids: event_ids) }

  context 'when file is provided' do

    let(:file) { './spec/support/bank_txns_for_testing.json' }
    let(:event_ids) { Set.new(%w[evt_1d7065ee evt_0b55cbdc]) }

    it 'processes the file for purpose of establishing orphaned transactions' do
      transaction_processor.process
      expect(transaction_processor.orphaned_transactions.count).to eq 2
    end

    it 'processes the file for purpose of matching transactions to events' do
      transaction_processor.process
      expect(transaction_processor.references.count).to eq 1
    end
  end
end
