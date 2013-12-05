require 'bumbleworks'

describe Bumbleworks::Sequel::Adapter do
  before :each do
    Bumbleworks.reset!
  end

  describe 'when added to configuration' do
    it 'adds storage adapter to Bumbleworks' do
      described_class.stub(:auto_register?).and_return(false)
      Bumbleworks.configuration.storage_adapters.should_not include(described_class)
      Bumbleworks.configuration.add_storage_adapter(described_class)
      Bumbleworks.configuration.storage_adapters.should include(described_class)
    end
  end

  describe 'when auto_register is true' do
    it 'is already automatically added to configuration' do
      described_class.stub(:auto_register?).and_return(true)
      Bumbleworks.configuration.storage_adapters.should include(described_class)
    end
  end

  describe '.auto_register?' do
    it 'returns true if auto_register is true' do
      described_class.auto_register = true
      described_class.auto_register?.should be_true
    end

    it 'returns false if auto_register is not true' do
      described_class.auto_register = :ghosts
      described_class.auto_register?.should be_false
    end

    it 'is true by default' do
      described_class.auto_register = nil
      described_class.auto_register?.should be_true
    end
  end

  describe '.use?' do
    it 'returns true if given storage class matches Sequel' do
      described_class.use?(Sequel.connect('mock://ninja/turtles')).should be_true
    end

    it 'returns false if given storage class does not match Sequel' do
      described_class.use?({}).should be_false
      described_class.use?(nil).should be_false
      described_class.use?('Sequel').should be_false
    end
  end

  describe '.allow_history_storage?' do
    it 'returns true' do
      described_class.allow_history_storage?.should be_true
    end
  end

  describe '.wrap_storage_with_driver' do
    it 'creates the table and returns new ruote storage' do
      ::Ruote::Sequel.should_receive(:create_table).with(:storage, false, 'choofles').ordered
      described_class.driver.should_receive(:new).with(:storage, { 'sequel_table_name' => 'choofles' }).ordered
      described_class.wrap_storage_with_driver(:storage, 'sequel_table_name' => 'choofles')
    end

    it 'defaults the table name to bumbleworks_documents' do
      ::Ruote::Sequel.should_receive(:create_table).with(:storage, false, 'bumbleworks_documents').ordered
      described_class.driver.should_receive(:new).with(:storage, { 'sequel_table_name' => 'bumbleworks_documents' }).ordered
      described_class.wrap_storage_with_driver(:storage)
    end
  end
end