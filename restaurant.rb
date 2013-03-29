require_relative 'review'
require_relative 'restaurant_reviewer'
require_relative 'restaurant_database'

class Restaurant
  attr_reader :id
  def initialize(options)
    @id, @name, @neighborhood, @cuisine =
    options.values_at("id", "name", "neighborhood", "cuisine")
  end

  def self.by_neighborhood(neighborhood)
    restuarant_data = RestaurantDatabase.execute(<<-SQL, neighborhood)
      SELECT restaurants.*
        FROM restaurants
       WHERE restaurants.neighborhood = ?
      SQL

      restuarant_data.map do |restuarant_info|
         Restaurant.new(restuarant_info)
      end
  end

  def reviews
    RestaurantReviewer.reviews(@id)
  end

  def average_review_score
    RestaurantReviewer.average_review_score(@id)
  end

end