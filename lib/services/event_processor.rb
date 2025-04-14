# frozen_string_literal: true

require 'oj'
require './lib/models/event'
# Takes the event files and process the events to find duplicates
class EventProcessor
  attr_accessor :ids, :duplicates, :events

  def initialize(file:)
    @file = file
    @ids = Set.new
    @duplicates = []
    @events = {}
  end

  def process
    File.open(file) do |opened_file|
      read_file(opened_file)
    end
  end

  def check_references(references)
    ids - references
  end

  private

  attr_reader :file

  def read_file(opened_file)
    Oj.load(opened_file).each do |event|
      duplicate_check(event)
    end
  end

  def duplicate_check(event)
    if ids.intersect?(Set[event['id']])
      duplicates.append(event['id'])
    else
      add_event(event)
    end
  end

  def add_event(event)
    ids.add(event['id'])
    events[event['id']] = Event.new(id: event['id'],
                                    type: event['type'],
                                    user_id: event['user_id'],
                                    amount: event['amount'])
  end
end
