require 'spec_helper'
require 'pathname'

describe TableBeet::Loader do
  context 'when not specify in the constructor argument', :before_load => true do
    let(:loader) do
      TableBeet::Loader.new
    end

    describe '#display_pattern' do
      it 'should return default glob pattern' do
        expect(loader.display_pattern).to eq('./spec/**/*_steps.rb')
      end
    end
  end

  context 'when specify pattern that does not exist', :before_load => true do
    let(:loader) do
      TableBeet::Loader.new(suffix: '__hoge.rb', path: '/tmp')
    end

    describe '#display_pattern' do
      it 'should return glob pattern' do
        expect(loader.display_pattern).to eq('/tmp/**/*__hoge.rb')
      end
    end

    describe '#paths' do
      it 'should return empty array' do
        expect(loader.paths).to be_empty
      end
    end

    describe '#load' do
      it 'should return zero' do
        expect(loader.load).to be_zero
      end
    end
  end

  context 'when specify exist pattern' do
    let(:loader) do
      TableBeet::Loader.new(path: FIXTURES_PATH)
    end

    describe '#paths' do
      it 'should return load files' do
        files = Pathname.glob(FIXTURES_PATH + '/*_steps.rb')
        expect(loader.paths).to eq(files)
      end
    end

    describe '#load' do
      it 'should return number of steps file' do
        count = Pathname.glob(FIXTURES_PATH + '/*_steps.rb').size
        expect(loader.load).to eq(count)
      end
    end
  end
end
