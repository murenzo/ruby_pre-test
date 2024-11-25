# frozen_string_literal: true

class Rebalance
  attr_reader :current_portfolio, :desired_portfolio

  def initialize(current_portfolio:, desired_portfolio:)
    @current_portfolio = current_portfolio
    @desired_portfolio = desired_portfolio
  end

  def calculate
    if fetch_new_stock.any?
      result = []

      current_portfolio.map do |company|
        result << { FROM: company.first, TO: fetch_new_stock.first, AMOUNT: calculate_units_to_transfer }
      end

      return result
    end

    return 'No trade needed' if current_stock_has_same_unit?

    [{ FROM: fetch_from.first, TO: fetch_to.first, AMOUNT: calculate_units_to_transfer }]
  end

  private

  def amount_to_split
    fetch_from.last - fetch_to.last
  end

  def fetch_from
    current_portfolio.map do |company|
      return company if desired_portfolio[company.first] < company.last
    end
  end

  def fetch_to
    return fetch_new_stock if fetch_new_stock.any?

    current_portfolio.map do |company|
      return company if desired_portfolio[company.first] > company.last
    end
  end

  def calculate_units_to_transfer
    (desired_portfolio[fetch_from.first] - fetch_from.last).abs
  end

  def current_stock_has_same_unit?
    fetch_from.first == fetch_to.first
  end

  def fetch_new_stock
    new_stock = []

    desired_portfolio.map do |company|
      new_stock << company unless current_portfolio.keys.include?(company.first)
    end

    new_stock.flatten
  end
end