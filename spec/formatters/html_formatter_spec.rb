require 'spec_helper'
require 'erb'

describe TableBeet::Formatters::HTMLFormatter do
  before do
    mock_load
    scopes = TableBeet::World.scopes
    directory = OUTPUT_PATH
    formatter = TableBeet::Formatters::HTMLFormatter.new(scopes, directory)
    formatter.flush
  end

  let(:file) do
    File.readlines(OUTPUT_PATH + '/index.html').join
  end

  context 'not loaded steps', :before_load => true do
    let(:mock_load) { nil }

    describe '.flush' do
      it 'should make html that has no scopes and steps' do
        expect(file).not_to include('<a href="' + ERB::Util.h('#turnip') + '">' + ERB::Util.h('turnip') + '</a>')
        expect(file).not_to include('<a href="' + ERB::Util.h('#test')   + '">' + ERB::Util.h('test')   + '</a>')
        expect(file).not_to include(ERB::Util.h("Are you talking about :name !!!!!"))
        expect(file).not_to include(ERB::Util.h("the test is insufficient"))
        expect(file).not_to include(ERB::Util.h("To run the test:"))
        expect(file).not_to include(ERB::Util.h("When you give up, that's when the game is over."))
      end
    end
  end

  context 'not loaded steps' do
    let(:mock_load) { TableBeet::Loader.new(path: FIXTURES_PATH).load }

    describe '.flush' do
      it 'should make html that has scopes and steps' do
        expect(file).to include('<a href="' + ERB::Util.h('#turnip') + '">' + ERB::Util.h('turnip') + '</a>')
        expect(file).to include('<a href="' + ERB::Util.h('#test')   + '">' + ERB::Util.h('test')   + '</a>')
        expect(file).to include('<th class="step_name">' + ERB::Util.h("Are you talking about :name !!!!!") + '</th>')
        expect(file).to include('<th class="step_name">' + ERB::Util.h("the test is insufficient") + '</th>')
        expect(file).to include('<th class="step_name">' + ERB::Util.h("To run the test:") + '</th>')
        expect(file).to include('<th class="step_name">' + ERB::Util.h("When you give up, that's when the game is over.") + '</th>')
      end
    end
  end
end
