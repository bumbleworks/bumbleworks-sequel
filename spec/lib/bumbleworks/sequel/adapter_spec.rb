require 'bumbleworks'

describe Bumbleworks::Sequel::Adapter do
  describe 'when added to configuration' do
    it 'adds storage adapter to Bumbleworks' do
      allow(described_class).to receive(:auto_register?).and_return(false)
      expect(Bumbleworks.configuration.storage_adapters).not_to include(described_class)
      Bumbleworks.configuration.add_storage_adapter(described_class)
      expect(Bumbleworks.configuration.storage_adapters).to include(described_class)
    end
  end

  describe 'when auto_register is true' do
    it 'is already automatically added to configuration' do
      allow(described_class).to receive(:auto_register?).and_return(true)
      expect(Bumbleworks.configuration.storage_adapters).to include(described_class)
    end
  end

  describe '.auto_register?' do
    it 'returns true if auto_register is true' do
      described_class.auto_register = true
      expect(described_class.auto_register?).to be_truthy
    end

    it 'returns false if auto_register is not true' do
      described_class.auto_register = :ghosts
      expect(described_class.auto_register?).to be_falsy
    end

    it 'is true by default' do
      described_class.auto_register = nil
      expect(described_class.auto_register?).to be_truthy
    end
  end

  describe '.use?' do
    it 'returns true if given storage class matches Sequel' do
      expect(described_class.use?(Sequel.connect('mock://ninja/turtles'))).to be_truthy
    end

    it 'returns false if given storage class does not match Sequel' do
      expect(described_class.use?({})).to be_falsy
      expect(described_class.use?(nil)).to be_falsy
      expect(described_class.use?('Sequel')).to be_falsy
    end
  end

  describe '.driver' do
    it 'returns ::Ruote::Sequel::Storage' do
      expect(described_class.driver).to eq ::Ruote::Sequel::Storage
    end
  end

  describe '.wrap_storage_with_driver' do
    before :each do
      allow(described_class.driver).to receive(:new).with(:awesome_stuff, { 'sequel_table_name' => :furf }).and_return(:new_storage)
    end

    it 'instantiates driven storage with options' do
      allow(::Ruote::Sequel).to receive(:create_table)
      expect(described_class.wrap_storage_with_driver(:awesome_stuff, { 'sequel_table_name' => :furf })).to eq(:new_storage)
    end

    it 'creates Bumbleworks documents table' do
      expect(::Ruote::Sequel).to receive(:create_table).with(:awesome_stuff, false, :furf)
      described_class.wrap_storage_with_driver(:awesome_stuff, { :sequel_table_name => :furf })
    end

    it 'defaults Bumbleworks documents table to :bumbleworks_documents' do
      expect(::Ruote::Sequel).to receive(:create_table).with(:awesome_stuff, false, 'bumbleworks_documents')
      allow(described_class.driver).to receive(:new).with(:awesome_stuff, { 'sequel_table_name' => 'bumbleworks_documents' }).and_return(:new_storage)
      expect(described_class.wrap_storage_with_driver(:awesome_stuff)).to eq(:new_storage)
    end
  end

  describe '.allow_history_storage?' do
    it 'returns true' do
      expect(described_class.allow_history_storage?).to be_truthy
    end
  end
end