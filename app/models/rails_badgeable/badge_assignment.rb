module RailsBadgeable
  class BadgeAssignment < ApplicationRecord
    self.table_name = "rails_badgeable_assignments"

    belongs_to :badge, class_name: "RailsBadgeable::Badge"
    belongs_to :assignable, polymorphic: true

    validates :badge, presence: true
    validates :assignable, presence: true
    validates :badge_id, uniqueness: { scope: [:assignable_type, :assignable_id] }
  end
end
