#!/usr/bin/env ruby
# Rails Console Test Script for ContentFlagging

puts "=== ContentFlagging Rails Console Test ==="
puts "Run: rails console"
puts "Then copy/paste these commands:"
puts

puts <<~RUBY
# 1. Create test data
post1 = Post.create(title: "Normal Post")
post2 = Post.create(title: "Controversial Post")
user = User.create(name: "Test User")

# 2. Check initial state
puts "Initial posts count: \#{Post.count}"
puts "Post2 flagged?: \#{post2.flagged?}"
puts "Post2 flag count: \#{post2.flag_count}"

# 3. Flag the post (below threshold)
post2.flag!(flagged_by: user)
post2.flag!
puts "After 2 flags - Post2 flagged?: \#{post2.flagged?}"
puts "Posts in default scope: \#{Post.count}"

# 4. Hit the threshold (3 flags)
post2.flag!
puts "After 3 flags - Post2 flagged?: \#{post2.flagged?}"
puts "Post2 flagged at: \#{post2.flagged_at}"
puts "Posts in default scope: \#{Post.count}"
puts "Posts with flagged: \#{Post.with_flagged.count}"

# 5. Test scopes
puts "Flagged posts: \#{Post.with_flagged.flagged.count}"
puts "Not flagged posts: \#{Post.not_flagged.count}"

# 6. Unflag
post2.unflag!(flagged_by: user)
puts "After unflagging - Post2 flagged?: \#{post2.flagged?}"
puts "Posts in default scope: \#{Post.count}"
RUBY

puts
puts "=== Quick Test Commands ==="
puts "Post.create(title: 'Test').tap { |p| 3.times { p.flag! } }.flagged?"
puts "Post.count vs Post.with_flagged.count"