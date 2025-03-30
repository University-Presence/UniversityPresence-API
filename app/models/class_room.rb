class ClassRoom < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :events

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[course events]
  end
end
