# frozen_string_literal: true

require 'csv'

class ParserService
  PARSERS = {
    dollar_format: { col_sep: '$', date_format: '%d-%m-%Y' },
    percent_format: { col_sep: '%', date_format: '%Y-%m-%d' }
  }.freeze

  def self.parse_people(sources)
    return [] if sources.nil?

    sources.map do |format, content|
      next unless format =~ /_format/

      parser_settings = PARSERS[format]
      rows = ParserService.new(parser_settings).parse(content)
      rows.map { |r| Person.new(r) }
    end.compact.flatten
  end

  def initialize(col_sep:, date_format:)
    @col_sep = col_sep
    @date_format = date_format
  end

  def parse(str)
    CSV.parse(str,
              col_sep: col_sep,
              headers: :first_row, header_converters: :symbol,
              converters: [lambda { |v|
                             s = v.strip; begin
                                          Date.strptime(s, date_format)
                                          rescue StandardError
                                            s
                                        end
                           }]).map(&:to_h)
  end

  private

  attr_reader :col_sep, :date_format
end
