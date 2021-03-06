require 'bumbleworks'

describe Bumbleworks::Ruote do
  before :each do
    Bumbleworks::Sequel::Adapter.auto_register = false
  end

  it 'does not support Sequel storage before adapter is added' do
    storage = Sequel.connect('mock://ninja/turtles')
    Bumbleworks.storage = storage
    expect {
      described_class.send(:storage)
    }.to raise_error(Bumbleworks::UndefinedSetting)
  end

  it 'supports Sequel storage after adapter is added' do
    Bumbleworks.configuration.add_storage_adapter(Bumbleworks::Sequel::Adapter)
    storage = Sequel.connect('mock://ninja/turtles')
    Bumbleworks.storage = storage
    expect(Ruote::Sequel::Storage).to receive(:new).with(storage, {'sequel_table_name' => 'bumbleworks_documents'})
    described_class.send(:storage)
  end

  it 'adds itself to error message for unsupported storages' do
    Bumbleworks.configuration.add_storage_adapter(Bumbleworks::Sequel::Adapter)
    Bumbleworks.storage = :a_frog
    expect {
      described_class.send(:storage)
    }.to raise_error(Bumbleworks::UndefinedSetting, /Sequel/)
  end
end