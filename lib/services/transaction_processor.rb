# frozen_string_literal: true

require 'oj'
require './lib/models/transaction'

# Processes Transaction file to check transactions
class TransactionProcessor
  attr_reader :orphaned_transactions, :references, :transactions

  def initialize(file:, event_ids:)
    @file = file
    @event_ids = event_ids
    @references = Set.new
    @orphaned_transactions = []
    @transactions = {}
  end

  def process
    File.open(@file) do |file|
      read_file(file)
    end
  end

  private

  def orphan_check(transaction)
    if !@event_ids.intersect?(Set[transaction['reference_id']])
      @orphaned_transactions << transaction['id']
    else
      @references.add(transaction['reference_id'])
      @transactions[transaction['id']] = Transaction.new(id: transaction['id'],
                                                         type: transaction['type'],
                                                         reference_id: transaction['reference_id'],
                                                         amount: transaction['amount'])
    end
  end

  def read_file(file)
    Oj.load(file).each do |transaction|
      orphan_check(transaction)
    end
  end
end
