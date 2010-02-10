module Sherpa
  module UserstampBasic
    module MigrationHelper
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def userstamps
          puts "creating userstamps"
          column(:created_by_id, :integer)
          column(:updated_by_id, :integer)
        end
      end
    end
  end
end
ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Sherpa::UserstampBasic::MigrationHelper)
