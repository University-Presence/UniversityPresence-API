class Event < ApplicationRecord
  belongs_to :course

  validates :name, :description, :event_start, :event_end, :location, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id, name, description, event_start, event_end, location]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[course]
  end
end
