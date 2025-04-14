# frozen_string_literal: true

require './lib/reconciler'


events = ARGV[0]
puts events
bank_txns = ARGV[1]
puts Reconciler.new(events: events, bank_txns: bank_txns).run_report
