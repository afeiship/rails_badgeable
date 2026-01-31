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
badge = RailsBadgeable::Badge.find_or_create_by(name: "Important")
post.badges << badge

badge.assigned_to(Post)  # => [post]
RailsBadgeable::Badge.for_model(Post)  # => [badge]
```
