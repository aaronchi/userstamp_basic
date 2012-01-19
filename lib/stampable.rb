module Sherpa #:nodoc:
  module UserstampBasic
    module Stampable
      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
        base.class_eval do
          include InstanceMethods
          #self.stampable
        end
      end
    end
    module ClassMethods
      def stampable
        class_eval do
          before_validation :set_updated_by
          before_validation :set_created_by, :on => :create
          belongs_to :creator, :class_name => "User"
          belongs_to :updater, :class_name => "User"
        end
      end
    end
    
    module InstanceMethods
      def set_updated_by
        self.updater_id = User.current.id if self.respond_to?(:updater_id) && User.current
      end
      
      def set_created_by
        self.creator_id = User.current.id if self.respond_to?(:creator_id) && User.current
      end
    end
  end
end
ActiveRecord::Base.send(:include, Sherpa::UserstampBasic::Stampable) if defined?(ActiveRecord)