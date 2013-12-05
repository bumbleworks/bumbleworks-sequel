require "bumbleworks/storage_adapter"
require "ruote-sequel"

module Bumbleworks
  module Sequel
    class Adapter < Bumbleworks::StorageAdapter
      class << self
        def driver
          ::Ruote::Sequel::Storage
        end

        def storage_class
          ::Sequel
        end

        def use?(storage)
          storage.class.name =~ /^#{storage_class}/
        end

        def wrap_storage_with_driver(storage, options = {})
          options['sequel_table_name'] ||= 'bumbleworks_documents'
          ::Ruote::Sequel.create_table(storage, false, options['sequel_table_name'])
          driver.new(storage, options)
        end
      end
    end
  end
end