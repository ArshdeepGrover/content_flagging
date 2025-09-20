require 'active_record'
require 'content_flagging/version'
require 'content_flagging/flaggable'
require 'content_flagging/flag'
require 'content_flagging/configuration'

module ContentFlagging
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.config
    self.configuration ||= Configuration.new
  end
end

ActiveRecord::Base.extend(ContentFlagging::Flaggable::ClassMethods)