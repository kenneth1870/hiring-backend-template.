# frozen_string_literal: true

require 'csv'

Dir.glob('./app/**/*.rb').sort.each do |file|
  require file
end
