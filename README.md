# rails_badgeable

A lightweight, reusable Rails Engine for adding badges to any ActiveRecord model via polymorphic many-to-many relationships.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_badgeable'
```

Then run:
```bash
rails rails_badgeable:install:migrations
rails db:migrate
```

## Usage

Include the concern in any model:

```ruby
class Post < ApplicationRecord
  include RailsBadgeable::HasBadges
end

post = Post.create(title: "Hello")
# Create or find a badge named "Important"
badge = RailsBadgeable::Badge.find_or_create_by(name: "Important")

# Assign the badge to post
post.badges << badge

# Query: Which posts have this badge assigned?
# Returns all Post records with the "Important" badge
# !!! Note, badge.posts syntax is not supported.
badge.assigned_to(Post)  # => [post]

# Query: Which badges have been used on the Post model?
# Returns all badges that have ever been assigned to a Post (excluding unused ones)
RailsBadgeable::Badge.for_model(Post)  # => [badge]
```

## Using Short Alias (Optional)

If you prefer using `Badge` instead of `RailsBadgeable::Badge`, use the generator to create an alias initializer:

```bash
rails generate rails_badgeable:alias
```

This creates `config/initializers/badgeable.rb` with the following:

```ruby
Badge = RailsBadgeable::Badge unless defined?(Badge)
BadgeAssignment = RailsBadgeable::BadgeAssignment unless defined?(BadgeAssignment)
```

Then you can use the short form:

```ruby
# Instead of RailsBadgeable::Badge
Badge.find_or_create_by(name: "Important")

# Instead of RailsBadgeable::BadgeAssignment
BadgeAssignment.all
```

## Available Methods

### Instance Methods (on a Badge object)

- `badge.assigned_to(klass)` - Returns all records of the given class that have this badge

### Class Methods (on Badge class)

- `RailsBadgeable::Badge.for_model(klass)` - Returns all badges ever used on the given model class

### Model Methods (on models with HasBadges)

- `post.badges` - Returns all badges assigned to this post
- `post.badges << badge` - Assign a badge to this post
- `post.badges.destroy(badge)` - Remove a badge from this post
