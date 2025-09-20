module ContentFlagging
  module Flaggable
    module ClassMethods
      def acts_as_flaggable(options = {})
        threshold = options[:threshold] || ContentFlagging.config.flag_threshold
        
        has_many :flags, as: :flaggable, class_name: 'ContentFlagging::Flag', dependent: :destroy
        
        scope :not_flagged, -> { where('COALESCE(flagged_count, 0) < ?', threshold) }
        scope :flagged, -> { where('flagged_count >= ?', threshold) }
        scope :with_flagged, -> { unscoped }
        
        default_scope { not_flagged }
        
        include ContentFlagging::Flaggable::InstanceMethods
        
        class_attribute :flag_threshold
        self.flag_threshold = threshold
      end
    end
    
    module InstanceMethods
      def flag!(flagged_by: nil)
        flags.create!(flagged_by: flagged_by)
      end
      
      def unflag!(flagged_by: nil)
        flag_record = flagged_by ? flags.where(flagged_by: flagged_by).first : flags.first
        flag_record&.destroy
      end
      
      def flagged?
        (flagged_count || 0) >= self.class.flag_threshold
      end
      
      def flag_count
        flagged_count || 0
      end
      
      def flagged_at
        return nil unless flagged?
        read_attribute(:flagged_at) || flags.minimum(:flagged_at)
      end
    end
  end
end