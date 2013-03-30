require_relative 'restaurant'
require_relative 'restaurant_database'
require_relative 'Review'

class Critic

  def initialize(options)
    @id, @screen_name = options.values_at("id","screen_name")
  end

  def reviews
    review_data = RestaurantDatabase.execute(<<-SQL, @id)
      SELECT restaurant_reviews.*
        FROM restaurant_reviews
       WHERE restaurant_reviews.reviewer_id = ?
      SQL

    review_data.map{ |review_datum| p review_datum; Review.new(review_datum) }
  end

  def average_review_score
    avg_score = RestaurantDatabase.execute(<<-SQL, @id)[0]["avg_score"]
      SELECT AVG(restaurant_reviews.score) AS avg_score
        FROM restaurant_reviews
       WHERE restaurant_reviews.reviewer_id = ?
      SQL
  end

  def self.all_critics
    critic_data = RestaurantDatabase.execute(<<-SQL)
      SELECT critics.*
        FROM critics
      SQL

    critic_data.map{ |critic_datum| Critic.new(critic_datum) }
  end

  def unreviewed_restaurants
    restaurant_data = RestaurantDatabase.execute(<<-SQL, @id)
             SELECT restaurants.*
              FROM  restaurants
   LEFT OUTER JOIN  restaurant_reviews
                ON (restaurants.id=restaurant_reviews.restaurant_id
               AND  restaurant_reviews.reviewer_id = ?)
             WHERE restaurant_reviews.reviewer_id IS NULL;
    SQL

    restaurant_data.map{ |restaurant_datum| Restaurant.new(restaurant_datum) }
  end

end