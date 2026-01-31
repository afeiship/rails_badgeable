module RailsBadgeable
  class Badge < ApplicationRecord
    self.table_name = "rails_badgeable_badges"

    has_many :assignments, class_name: "RailsBadgeable::BadgeAssignment", dependent: :destroy

    validates :name, presence: true, uniqueness: true

    # Returns all associated records of the given class that have this badge
    def assigned_to(klass)
      assignable_ids = assignments.where(assignable_type: klass.base_class.name).pluck(:assignable_id)
      klass.where(id: assignable_ids)
    end

    # Class method: Returns all badges ever used on the given model class
    def self.for_model(klass)
      badge_ids = BadgeAssignment.where(assignable_type: klass.base_class.name).distinct.pluck(:badge_id)
      where(id: badge_ids)
    end
  end
end
