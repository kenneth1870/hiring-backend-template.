# frozen_string_literal: true

class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    people = ParserService.parse_people(params)
    people.sort_by(&params[:order]).map(&:to_s)
  end

  private

  attr_reader :params
end
