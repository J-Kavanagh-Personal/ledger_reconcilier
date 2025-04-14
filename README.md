# Ledger Reconcilier

This is my solution for the Ledger Reconciler.

### Prerequisites

Ruby `3.3.0` Though due to the nature of the code it should work with more modern versions too, but gem file will need to bundle correctly.

### Instructions to run:

The run script is located in the lib folder, it can be run from root via lib/run.rb

- Clone the repo: `git clone https://github.com/J-Kavanagh-Personal/ledger_reconcilier.git`
- Install the gems: `bundle install`
- To run `ruby lib/run.rb -event_file -bank_txn_file`
- e.g. Example using the two files provided
`ruby lib/run.rb spec/support/events_with_withdrawals.json spec/support/bank_txns_with_withdrawals.json`

### Output

The output will display as large hash containing:

    duplicates:
    missing_bank_txns:
    orphaned_bank_txns:
    balance_ok:
    final_reconciled_balance:

### Running specs:

- `rspec`

### Some idea I was thinking but felt it was too much to add in the scope of the problem

- Async or concurrency to speed up the processing of the files
- Creating structs rather than classes for Transaction and Event to be more performant

