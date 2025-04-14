# frozen_string_literal: true

require 'rspec'
require './lib/reconciler'

RSpec.describe Reconciler do

  subject(:reconciler) { described_class.new(events: event_file, bank_txns: bank_txn_file) }

  context 'when both files are provided' do

    let(:bank_txn_file) { './spec/support/bank_txns_for_testing.json' }
    let(:event_file) { './spec/support/events_for_testing.json' }



    let(:result) do
      {
        duplicates: ['evt_1d7065ee'],
        missing_bank_txns: ['evt_0b55cbdc'],
        orphaned_bank_txns: %w[txn_d0d600b8 txn_60d90614],
        balance_ok: true,
        final_reconciled_balance: 4936
      }
    end

    it 'succeeds' do
      expect(reconciler.run_report).to eq(result)
    end
  end
end
