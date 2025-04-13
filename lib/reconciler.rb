# frozen_string_literal: true

class Reconciler
  def initialize(events:, bank_txns:)
    @events = events
    @bank_txns = bank_txns
  end

  def run_report
    {
      duplicates: [],                # <- implement detection
      missing_bank_txns: [],         # <- implement detection
      orphaned_bank_txns: [],        # <- implement detection
      balance_ok: nil,               # <- implement consistency check
      final_reconciled_balance: nil  # <- implement final net balance
    }
  end
end
