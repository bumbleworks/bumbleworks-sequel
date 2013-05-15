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
      end
    end
  end
end