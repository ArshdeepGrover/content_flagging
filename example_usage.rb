# Example usage in a Rails application

# 1. Model setup
class Post < ApplicationRecord
  acts_as_flaggable
  # Requires: flagged_count integer column (default: 0)
end

class Comment < ApplicationRecord
  acts_as_flaggable threshold: 5
end

class User < ApplicationRecord
  # Can flag content
end

# 2. Configuration (config/initializers/content_flagging.rb)
ContentFlagging.configure do |config|
  config.flag_threshold = 3
end

# 3. Usage examples
post = Post.create(title: "Controversial Post")
user1 = User.create(name: "User 1")
user2 = User.create(name: "User 2")

# Flag the post
post.flag!(flagged_by: user1)
post.flag!(flagged_by: user2)
post.flag_count # => 2
post.flagged? # => false

# Third flag triggers threshold
post.flag!
post.flagged? # => true

# Post is now excluded from default scope
Post.all # Won't include this post
Post.with_flagged.all # Will include this post
Post.with_flagged.flagged # Returns only flagged posts
Post.not_flagged # Returns only non-flagged posts

# Unflagging
post.unflag!(flagged_by: user1)
post.flag_count # => 2
post.flagged? # => false (back in default scope)