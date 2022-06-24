# frozen_string_literal: true

class Person
  CITIES = {
    'LA' => 'Los Angeles',
    'NYC' => 'New York City'
  }.freeze
  attr_reader :first_name, :last_name, :birthdate, :city

  def initialize(first_name:, last_name: nil, birthdate:, city:)
    @first_name = first_name
    @last_name = last_name
    @birthdate = birthdate
    @city = convert_city(city)
  end

  def convert_city(city)
    if CITIES.key? city
      CITIES[city]
    else
      city
    end
  end

  def to_s
    "#{first_name}, #{city}, #{birthdate.strftime('%-m/%-d/%Y')}"
  end
end
