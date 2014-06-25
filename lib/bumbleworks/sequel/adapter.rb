require "bumbleworks/storage_adapter"
require "rufus-json/automatic"
require "ruote-sequel"

module Bumbleworks
  module Sequel
    class Adapter < Bumbleworks::StorageAdapter
      class << self
        def wrap_storage_with_driver(storage, options = {})
          options['sequel_table_name'] ||=
            options.delete(:sequel_table_name) || 'bumbleworks_documents'
          ::Ruote::Sequel.create_table(storage, false, options['sequel_table_name'])

          # overriding because base method ignores options
          driver.new(storage, options)
        end

        def driver
          ::Ruote::Sequel::Storage
        end

        def storage_class
          ::Sequel
        end

        def use?(storage)
          storage.class.name =~ /^#{storage_class}/
        end
      end
    end
  end
end