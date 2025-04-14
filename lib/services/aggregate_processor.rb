# frozen_string_literal: true

# Aggregates the transaction amounts and the amounts in events
class AggregateProcessor
  def initialize(transactions:, events:)
    @transactions = transactions
    @events = events
  end

  def process
    total_events_amount = events_amount
    total_transactions_amount = transactions_amount
    if total_events_amount == total_transactions_amount
      [true, total_transactions_amount]
    else
      [false, total_transactions_amount]
    end
  end

  private

  attr_reader :transactions, :events

  def events_amount
    events.reduce(0) do |sum, (_event_id, event)|
      if event.type == 'deposit'
        sum + event.amount
      else
        sum - event.amount
      end
    end
  end

  def transactions_amount
    transactions.reduce(0) do |sum, (_transaction_id, transaction)|
      if transaction.type == 'deposit'
        sum + transaction.amount
      else
        sum - transaction.amount
      end
    end
  end
end
