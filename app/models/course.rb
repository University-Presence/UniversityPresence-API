class Course < ApplicationRecord
  has_many :students
  has_many :events

  validates :name, :periods, presence: true

    def self.ransackable_attributes(_auth_object = nil)
    %w[id name periods]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[students events]
  end
end
