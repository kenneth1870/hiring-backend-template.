# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ParserService do
  let(:parser) { described_class.new(col_sep: '$', date_format: '%d-%m-%Y') }

  describe '#parse' do
    it 'returns list of hashes' do
      str = "name $ date\njoe $ 02-01-1969\njane $ 30-4-1974"
      parsed_rows = parser.parse(str)
      expect(parsed_rows).to eq [
        { name: 'joe', date: Date.new(1969, 1, 2) },
        { name: 'jane', date: Date.new(1974, 4, 30) }
      ]
    end

    it 'parses dollar_format fixture' do
      parsed_rows = parser.parse(File.read('spec/fixtures/people_by_dollar.txt'))
      expect(parsed_rows.count).to eq(2)
    end

    it 'parses percent_format fixture' do
      parser = ParserService.new(col_sep: '%', date_format: '%Y-%m-%d')
      parsed_rows = parser.parse(File.read('spec/fixtures/people_by_percent.txt'))
      expect(parsed_rows.count).to eq(2)
    end
  end
end
