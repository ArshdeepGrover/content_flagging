# 🚩 ContentFlagging

[![Gem Version](https://badge.fury.io/rb/content_flagging.svg)](https://rubygems.org/gems/content_flagging)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D%202.7.0-ruby.svg)](https://ruby-lang.org)
[![Rails](https://img.shields.io/badge/rails-%3E%3D%206.0-red.svg)](https://rubyonrails.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Website](https://img.shields.io/badge/website-content--flagging.netlify.app-blue)](https://content-flagging.netlify.app)

> **Smart community-driven content moderation**

A powerful Rails gem that lets your users moderate themselves. When content gets flagged enough times, it automatically disappears from your default scopes - keeping your platform clean without manual intervention.

## ⚡ Quick Start

```ruby
# Gemfile
gem 'content_flagging'

# Terminal
rails generate content_flagging:install
rails db:migrate

# Model
class Post < ApplicationRecord
  acts_as_flaggable  # 🎯 That's it!
end
```

## 🎯 The Magic

```ruby
post = Post.create(title: "Controversial Content")

# Users start flagging...
post.flag!(flagged_by: user1)
post.flag!(flagged_by: user2)
post.flag!  # Anonymous flag

# 💥 BOOM! Post disappears from default scope
Post.all.include?(post)  # => false (auto-hidden!)
post.flagged?            # => true
post.flagged_at          # => 2024-01-01 12:00:00 UTC

# But admins can still see everything
Post.with_flagged.count  # => All posts (including flagged)
Post.with_flagged.flagged # => Only flagged posts
```

## 🛠️ Setup

### 1. Add the Magic Method
```ruby
class Post < ApplicationRecord
  acts_as_flaggable                    # Default threshold: 3
end

class Comment < ApplicationRecord
  acts_as_flaggable threshold: 5       # Custom threshold
end

class Review < ApplicationRecord
  acts_as_flaggable threshold: 1       # Zero tolerance
end
```

### 2. Add Database Columns
```ruby
# Migration
add_column :posts, :flagged_count, :integer, default: 0
add_column :posts, :flagged_at, :datetime
```

## 🚀 Real-World Examples

### Community Moderation
```ruby
# Users can flag inappropriate content
def flag_post
  @post.flag!(flagged_by: current_user)
  redirect_to posts_path, notice: "Thanks for keeping our community safe! 🛡️"
end

# Content automatically disappears when threshold is hit
Post.all  # Only shows clean content ✨
```

### Admin Dashboard
```ruby
# See what's been flagged
@flagged_posts = Post.with_flagged.flagged.order(:flagged_at)
@recent_flags = Post.with_flagged.where('flagged_at > ?', 1.day.ago)

# Bulk operations
Post.with_flagged.flagged.pluck(:flagged_at)  # When were they flagged?
Post.with_flagged.where('flagged_count > 10') # Heavily flagged content
```

### Smart Queries
```ruby
# Different ways to slice and dice
Post.count                    # Clean content only
Post.with_flagged.count      # Everything
Post.not_flagged.count       # Explicitly clean
Post.with_flagged.flagged    # The naughty list 😈
```

## ⚙️ Configuration

```ruby
# config/initializers/content_flagging.rb
ContentFlagging.configure do |config|
  config.flag_threshold = 5  # Global default (can be overridden per model)
end
```

## 🎪 API Reference

| Method | Description | Example |
|--------|-------------|----------|
| `flag!(flagged_by: user)` | Flag content | `post.flag!(flagged_by: current_user)` |
| `unflag!(flagged_by: user)` | Remove flag | `post.unflag!(flagged_by: current_user)` |
| `flagged?` | Check if flagged | `post.flagged? # => true/false` |
| `flag_count` | Number of flags | `post.flag_count # => 3` |
| `flagged_at` | When first flagged | `post.flagged_at # => Time` |

| Scope | Description | Example |
|-------|-------------|----------|
| `Model.all` | Clean content (default) | `Post.all` |
| `Model.with_flagged` | Everything | `Post.with_flagged` |
| `Model.flagged` | Only flagged | `Post.with_flagged.flagged` |
| `Model.not_flagged` | Explicitly clean | `Post.not_flagged` |

## 🔥 Why This Rocks

- **🎯 Zero Config**: Works out of the box with sensible defaults
- **🔒 Thread-Safe**: Database-level counters prevent race conditions
- **🚀 Performance**: Efficient queries with proper indexing
- **🎨 Flexible**: Flag anything - posts, comments, users, you name it
- **👥 Community-Driven**: Let your users moderate themselves
- **🛡️ Admin-Friendly**: Easy oversight and management tools
- **🗄️ Database Agnostic**: Works with PostgreSQL, MySQL, SQLite

## 🤝 Contributing

Found a bug? Want a feature? PRs welcome!

## 🌐 Links

- **Website**: [content-flagging.netlify.app](https://content-flagging.netlify.app)
- **RubyGems**: [rubygems.org/gems/content_flagging](https://rubygems.org/gems/content_flagging)
- **GitHub**: [github.com/ArshdeepGrover/content_flagging](https://github.com/ArshdeepGrover/content_flagging)

### 🚀 Interactive Demo
Visit [content-flagging.netlify.app](https://content-flagging.netlify.app) for:
- 📖 Complete documentation
- 🎯 Live interactive demo
- 🎪 Real-world examples
- 💡 Best practices

## 📄 License

MIT License - go wild! 🎉