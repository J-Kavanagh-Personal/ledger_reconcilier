# frozen_string_literal: true

require './lib/services/event_processor'
require './lib/services/transaction_processor'
require './lib/services/aggregate_processor'


# runs the script to reconcile the events and bank transactions
class Reconciler
  def initialize(events:, bank_txns:)
    @events = events
    @bank_txns = bank_txns
  end

  def run_report
    event_processor = event_process
    transaction_processor = transaction_process(event_processor.ids)
    missing_txn = event_processor.check_references(transaction_processor.references)
    balance = AggregateProcessor.new(transactions: transaction_processor.transactions,
                                     events: event_processor.events.except(*missing_txn)).process
    report(event_processor, transaction_processor, balance, missing_txn)
  end

  private

  attr_reader :events, :bank_txns

  def report(event_processor, transaction_processor, balance, missing_txn)
    {
      duplicates: event_processor.duplicates,
      missing_bank_txns: missing_txn.to_a,
      orphaned_bank_txns: transaction_processor.orphaned_transactions,
      balance_ok: balance[0],
      final_reconciled_balance: balance[1]
    }
  end

  def transaction_process(ids)
    transaction_processor = TransactionProcessor.new(file: bank_txns, event_ids: ids)
    transaction_processor.process
    transaction_processor
  end

  def event_process
    event_processor = EventProcessor.new(file: events)
    event_processor.process
    event_processor
  end
end
