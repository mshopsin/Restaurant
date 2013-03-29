class Review
  def initialize(options)
    @id, @reviewer_id, @restaurant_id, @text_review, @score,
    @date_of_review =
    options.values_at("id","reviewer_id","restaurant_id",
    "text_review","score","date_of_review")
  end
end