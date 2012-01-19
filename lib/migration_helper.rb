module Sherpa
  module UserstampBasic
    module MigrationHelper
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def userstamps(include_deleted_by = false)
          puts "creating userstamps"
          column(:creator_id, :integer)
          column(:updater_id, :integer)
          column(:deleter_id, :integer) if include_deleted_by
        end
      end
    end
  end
end
ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Sherpa::UserstampBasic::MigrationHelper)
