module ContentFlagging
  class Flag < ActiveRecord::Base
    self.table_name = 'content_flags'
    
    belongs_to :flaggable, polymorphic: true
    belongs_to :flagged_by, polymorphic: true, optional: true
    
    validates :flaggable, presence: true
    validates :flagged_at, presence: true
    
    before_validation :set_flagged_at, on: :create
    after_create :increment_flagged_count
    after_destroy :decrement_flagged_count
    
    private
    
    def set_flagged_at
      self.flagged_at ||= Time.current
    end
    
    def increment_flagged_count
      flaggable.class.where(id: flaggable.id).update_all(
        'flagged_count = COALESCE(flagged_count, 0) + 1, flagged_at = CASE WHEN COALESCE(flagged_count, 0) = 0 THEN ? ELSE flagged_at END',
        flagged_at
      )
      flaggable.reload
    end
    
    def decrement_flagged_count
      count_sql = 'flagged_count = GREATEST(COALESCE(flagged_count, 0) - 1, 0)'
      flagged_at_sql = 'flagged_at = CASE WHEN GREATEST(COALESCE(flagged_count, 0) - 1, 0) = 0 THEN NULL ELSE flagged_at END'
      flaggable.class.where(id: flaggable.id).update_all("#{count_sql}, #{flagged_at_sql}")
      flaggable.reload
    end
  end
end