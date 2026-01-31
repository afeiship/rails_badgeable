# frozen_string_literal: true

module RailsBadgeable
  module Generators
    class AliasGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Creates a short alias initializer for RailsBadgeable models.'

      def create_alias_initializer
        template 'badgeable.rb', 'config/initializers/badgeable.rb'
      end
    end
  end
end
