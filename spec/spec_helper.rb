require 'active_record'
require 'sqlite3'
require_relative '../lib/content_flagging'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :content_flags do |t|
    t.references :flaggable, polymorphic: true, null: false, index: true
    t.references :flagged_by, polymorphic: true, null: true, index: true
    t.datetime :flagged_at, null: false
    t.timestamps
  end
  
  create_table :posts do |t|
    t.string :title
    t.integer :flagged_count, default: 0
    t.timestamps
  end
  
  create_table :users do |t|
    t.string :name
    t.timestamps
  end
end

class Post < ActiveRecord::Base
  acts_as_flaggable
end

class User < ActiveRecord::Base
end