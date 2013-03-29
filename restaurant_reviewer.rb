require_relative 'restaurant'
require_relative 'restaurant_database'
require_relative 'Review'

class RestaurantReviewer
  def self.reviews(restaurant_id)
    review_data = RestaurantDatabase.execute(<<-SQL, restaurant_id)
      SELECT restaurant_reviews.*
        FROM restaurant_reviews
       WHERE restaurant_reviews.restaurant_id = ?
      SQL

      review_data.map{ |review_datum| Review.new(review_datum) }
  end

  def self.average_review_score(restaurant_id)
    avg_score = RestaurantDatabase.execute(<<-SQL, restaurant_id)[0]["avg_score"]
      SELECT AVG(restaurant_reviews.score) AS avg_score
        FROM restaurant_reviews
       WHERE restaurant_reviews.restaurant_id = ?
      SQL

  end

end