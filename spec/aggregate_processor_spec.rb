# frozen_string_literal: true

require 'rspec'
require './lib/services/aggregate_processor'
require './lib/models/transaction'
require './lib/models/event'

RSpec.describe AggregateProcessor do

  subject(:aggregate_processor) { described_class.new(transactions: transactions, events: events) }
  context 'when events and transactions have been processed' do
    let(:transactions) do
      { 'txn_7928c0e2': Transaction.new(id: 'txn_7928c0e2',
                                        type: 'deposit',
                                        reference_id: 'evt_1d7065ee',
                                        amount: 4936) }
    end

    let(:events) do
      { 'evt_1d7065ee': Event.new(id: 'evt_1d7065ee',
                                  type: 'deposit',
                                  user_id: 'user_0003',
                                  amount: 4936) }
    end

    it 'process returns if the balance is balanced and the amount' do
      expect(aggregate_processor.process).to eq([true, 4936])
    end
  end
end
