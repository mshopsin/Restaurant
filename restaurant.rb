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

  def self.top_restaurants(n)
    restaurant_data = RestaurantDatabase.execute(<<-SQL,n)
      SELECT  restaurants.*
        FROM  restaurant_reviews
        JOIN  restaurants ON (restaurant_reviews.restaurant_id=restaurants.id) 
    GROUP BY  restaurant_id 
    ORDER BY  AVG(restaurant_reviews.score) 
  DESC LIMIT  ?;
    SQL

    restaurant_data.map { |restaurant_datum| Restaurant.new(restaurant_datum) }

  end

  def self.frequently_reviewed_restaurantsi(min_reviews)
    restaurant_data = RestaurantDatabase.execute(<<-SQL,min_reviews)
      SELECT  restaurants.* 
        FROM  restaurant_reviews 
        JOIN  restaurants ON (restaurant_reviews.restaurant_id=restaurants.id)  
    GROUP BY  restaurant_reviews.RESTAURANT_ID 
      HAVING  count(*) >= ? 
    SQL

    restaurant_data.map { |restaurant_datum| Restaurant.new(restaurant_datum) }

  end

  def reviews
    RestaurantReviewer.reviews(@id)
  end

  def average_review_score
    RestaurantReviewer.average_review_score(@id)
  end

end
