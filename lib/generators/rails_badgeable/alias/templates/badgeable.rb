# frozen_string_literal: true

# Short alias for RailsBadgeable models
# This allows you to use `Badge` instead of `RailsBadgeable::Badge`
#
# Usage:
#   Badge.find_or_create_by(name: "Important")
#   BadgeAssignment.all

Badge = RailsBadgeable::Badge unless defined?(Badge)
BadgeAssignment = RailsBadgeable::BadgeAssignment unless defined?(BadgeAssignment)
