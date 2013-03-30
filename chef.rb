require_relative 'restaurant_database'
require_relative 'Review'

class Chef
  def initialize(options)
    @id, @fname, @lname, @mentor_id =
    options.values_at("id","fname","lname","mentor_id")
  end

  def proteges
    protege_data = RestaurantDatabase.execute(<<-SQL, @id)
      SELECT chefs.*
        FROM chefs
       WHERE chefs.mentor_id = ?
    SQL

    protege_data.map { |protege_datum| Chef.new(protege_datum) }
  end

  def num_proteges
    protege_data = RestaurantDatabase.execute(<<-SQL, @id)[0]["num"]
      SELECT COUNT(*) AS num
        FROM chefs
       WHERE chefs.mentor_id = ?
    SQL
  end

  def self.all_chefs
    chef_data = RestaurantDatabase.execute(<<-SQL)
      SELECT chefs.*
        FROM chefs
      SQL

    chef_data.map{ |chef_datum| Chef.new(chef_datum) }
  end

  def reviews
    reviews_data = RestaurantDatabase.execute(<<-SQL, @id)
      select restaurant_reviews.*
        from restaurant_reviews
        JOIN chef_tenures
          ON (restaurant_reviews.restaurant_id=chef_tenures.restaurant_id
              AND restaurant_reviews.date_of_review BETWEEN
              chef_tenures.start_date AND chef_tenures.end_date)
       WHERE chef_tenures.chef_id = ?
    SQL

    reviews_data.map { |reviews_datum| Review.new(reviews_datum) }
  end

  def co_workers
    coworker_data = RestaurantDatabase.execute(<<-SQL, @id,@id)
    SELECT DISTINCT c.*
      FROM chef_tenures a
      JOIN chef_tenures b
        ON ((a.start_date BETWEEN b.start_date AND b.end_date)
        OR (a.end_date BETWEEN b.start_date AND b.end_date))
      JOIN chefs c ON c.id=b.chef_id
     WHERE a.chef_id = ?
       AND b.chef_id <> ?
    SQL

    coworker_data.map { |coworker_datum| Chef.new(coworker_datum) }
  end

end