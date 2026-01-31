module RailsBadgeable
  module HasBadges
    extend ActiveSupport::Concern

    included do
      has_many :rails_badgeable_assignments,
               as: :assignable,
               class_name: "RailsBadgeable::BadgeAssignment",
               dependent: :destroy

      has_many :badges,
               through: :rails_badgeable_assignments,
               class_name: "RailsBadgeable::Badge"
    end
  end
end
