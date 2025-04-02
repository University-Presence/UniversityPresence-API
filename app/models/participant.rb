class Participant < ApplicationRecord
  belongs_to :event
  belongs_to :student
  
  def self.ransackable_attributes(_auth_object = nil)
    %w[id, present, location]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[event student]
  end
end
