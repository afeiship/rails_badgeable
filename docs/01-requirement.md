# requirement
> 需求清单。

### 📌 项目名称（Project Name）
`rails_badgeable`

### 🎯 核心目标（Goal）
Create a **lightweight, reusable Rails Engine** named `rails_badgeable` that enables any ActiveRecord model (e.g., `Post`, `WorkLog`) to associate with a **finite set of predefined badges** via **polymorphic many-to-many relationships**.

---

### 🔧 功能需求（Functional Requirements）

#### 1. **数据模型（Data Model）**
- A `Badge` model under the `RailsBadgeable` namespace:
    - Table name: `rails_badgeable_badges`
    - Attributes:
        - `name` (string, unique, required)
        - `description` (text, optional)
- A join model `BadgeAssignment` under `RailsBadgeable`:
    - Table name: `rails_badgeable_assignments`
    - Polymorphic association:
        - `badge_id` → references `rails_badgeable_badges`
        - `assignable_type` + `assignable_id` → polymorphic
- Enforce uniqueness at DB level:
    - Unique index on `[badge_id, assignable_type, assignable_id]`

#### 2. **模型关系（Associations）**
- `RailsBadgeable::Badge`:
    - `has_many :assignments, class_name: "RailsBadgeable::BadgeAssignment"`
    - Instance method: `assigned_to(klass)` → returns all associated records of given class
    - Class method (optional): `for_model(klass)` → returns all badges used by that model
- Host models (e.g., `Post`, `WorkLog`) include a concern:
    - `include RailsBadgeable::HasBadges`
    - Automatically gains:
        - `has_many :rails_badgeable_assignments, as: :assignable, dependent: :destroy`
        - `has_many :badges, through: :rails_badgeable_assignments, class_name: "RailsBadgeable::Badge"`

#### 3. **使用方式（Usage in Host Application）**
```ruby
# Gemfile
gem 'rails_badgeable', path: '../rails_badgeable'

# Models
class Post < ApplicationRecord
  include RailsBadgeable::HasBadges
end

class WorkLog < ApplicationRecord
  include RailsBadgeable::HasBadges
end

# Usage examples
post = Post.create(title: "Hello")
badge = RailsBadgeable::Badge.find_or_create_by(name: "Important")

post.badges << badge
post.badges # => [badge]

# Query all posts with this badge
badge.assigned_to(Post)

# Query all badges ever used on WorkLog
RailsBadgeable::Badge.for_model(WorkLog)
```

#### 4. **工程结构（Engine Structure）**
- **Not mountable** (no routes, controllers, or views)
- Module name: `RailsBadgeable`
- File structure:
  ```
  lib/rails_badgeable.rb
  lib/rails_badgeable/engine.rb
  app/models/rails_badgeable/badge.rb
  app/models/rails_badgeable/badge_assignment.rb
  app/models/concerns/rails_badgeable/has_badges.rb
  db/migrate/xxx_create_rails_badgeable_tables.rb
  ```
- Explicit table names in models:
  ```ruby
  self.table_name = "rails_badgeable_badges"
  ```
- Main require file: `lib/rails_badgeable.rb`
- Gemspec:
    - `spec.name = "rails_badgeable"`
    - `spec.summary = "A Rails engine for polymorphic, reusable badges on any model."`
    - `spec.description = spec.summary`

#### 5. **约束与最佳实践（Constraints & Best Practices）**
- No frontend assets (CSS/JS/images)
- No automatic top-level constant alias (e.g., do **not** define `Badge = RailsBadgeable::Badge` automatically)
- Support Rails 7.0+
- Use explicit `table_name` (do not rely on auto-inflection)
- Include database unique index to prevent duplicate assignments
- Keep the engine stateless and side-effect-free on load

---

### 🚫 非功能需求（Out of Scope）
- Web UI or admin dashboard
- User permissions or audit logs
- Badge metadata beyond `name` and `description`
- Integration with tagging systems

---

### ✅ 交付物（Deliverables）
1. Complete Rails Engine project in current directory (`/Users/feizheng/github/rails_badgeable`)
2. Working migrations and namespaced models
3. Reusable concern `RailsBadgeable::HasBadges`
4. Valid `rails_badgeable.gemspec`
5. Minimal `README.md` (English, ~8 lines)

---

### 💡 实现提示（Implementation Tips）
- Run:
  ```bash
  rails plugin new rails_badgeable --skip-mountable
  ```
  (or without `--mountable`; you can delete generated routes if present)
- Manually ensure all models are under `RailsBadgeable` module
- Set `self.table_name` explicitly in each model
- In `engine.rb`, no need for `isolate_namespace` (since not mountable)
- Use `rails_badgeable:install:migrations` to copy migrations to host app
