# frozen_string_literal: true

class CreateRailsBadgeableTables < ActiveRecord::Migration[6.0]
  def change
    # Create badges table
    # To add custom fields to badges, add columns here, e.g.:
    #   t.string :color, default: '#007bff'
    #   t.string :icon
    create_table :rails_badgeable_badges do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :rails_badgeable_badges, :name, unique: true

    # Create join table for polymorphic associations
    # To add custom fields to assignments, add columns here, e.g.:
    #   t.string :reason
    #   t.references :granted_by, foreign_key: { to_table: :users }
    create_table :rails_badgeable_assignments do |t|
      t.references :badge, null: false, foreign_key: { to_table: :rails_badgeable_badges }
      t.references :assignable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :rails_badgeable_assignments,
              [:badge_id, :assignable_type, :assignable_id],
              unique: true,
              name: "index_rails_badgeable_assignments_on_badge_and_assignable"
  end
end
