require 'spec_helper'
require 'pathname'

describe TableBeet::World do
  let(:scopes) do
    mock_loader
    TableBeet::World.scopes
  end

  context 'before load steps', :before_load => true do
    let(:mock_loader) { nil }

    describe '.scopes' do
      it 'should return empty hash' do
        expect(scopes).to be_empty
      end
    end
  end

  context 'after load steps' do
    let(:mock_loader) { TableBeet::Loader.new(path: FIXTURES_PATH).load }

    describe '.scopes' do
      it 'should return hash of steps' do
        expect(scopes.keys.sort).to eq([:test, :turnip].sort)
      end
    end
  end
end
