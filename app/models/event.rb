# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :course
  belongs_to :course
  has_and_belongs_to_many :class_rooms

  validates :name, :description, :event_start, :event_end, :location, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id, name, description, event_start, event_end, location]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[course class_rooms]
  end
end
