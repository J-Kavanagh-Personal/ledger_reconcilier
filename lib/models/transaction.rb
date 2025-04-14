# frozen_string_literal: true

# Object for holding transactions
class Transaction
  attr_reader :type, :amount
  def initialize(id:, type:, reference_id:, amount:)
    @id = id
    @type = type
    @reference_id = reference_id
    @amount = amount
  end
end
