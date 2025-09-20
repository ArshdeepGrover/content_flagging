#!/usr/bin/env ruby
require_relative 'spec/spec_helper'

# Manual testing script
puts "Testing ContentFlagging gem..."

# Create test data
post = Post.create(title: "Test Post")
user = User.create(name: "Test User")

puts "\n1. Initial state:"
puts "Post flagged?: #{post.flagged?}"
puts "Flag count: #{post.flag_count}"
puts "Posts in default scope: #{Post.count}"

puts "\n2. Flag the post twice:"
post.flag!(flagged_by: user)
post.flag!
puts "Post flagged?: #{post.flagged?}"
puts "Flag count: #{post.flag_count}"
puts "Posts in default scope: #{Post.count}"

puts "\n3. Flag once more (hits threshold):"
post.flag!
puts "Post flagged?: #{post.flagged?}"
puts "Flag count: #{post.flag_count}"
puts "Posts in default scope: #{Post.count}"
puts "Posts with flagged: #{Post.with_flagged.count}"

puts "\n4. Unflag once:"
post.unflag!(flagged_by: user)
puts "Post flagged?: #{post.flagged?}"
puts "Flag count: #{post.flag_count}"
puts "Posts in default scope: #{Post.count}"

puts "\nTest completed!"