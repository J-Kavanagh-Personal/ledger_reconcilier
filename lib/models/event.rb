# frozen_string_literal: true

# Event is representation of the model in memory of the event
class Event
  attr_accessor :id, :type, :user_id, :amount

  def initialize(id:, type:, user_id:, amount:)
    @id = id
    @type = type
    @user_id = user_id
    @amount = amount
  end
end
