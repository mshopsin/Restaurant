CREATE TABLE chefs (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  mentor_id INTEGER,

  FOREIGN KEY(mentor_id) REFERENCES chefs(id)

);

INSERT INTO chefs (fname, lname, mentor_id)
VALUES('Sidoine', 'Benoît', NULL);

INSERT INTO chefs (fname, lname, mentor_id)
     SELECT "Guillaume", "Tirel", chefs.id
       FROM chefs
      WHERE chefs.fname = "Sidoine" AND chefs.lname = "Benoît";
INSERT INTO chefs (fname, lname, mentor_id)
     SELECT "Martino", "da Como", chefs.id
       FROM chefs
      WHERE chefs.fname = "Sidoine" AND chefs.lname = "Benoît";
INSERT INTO chefs (fname, lname, mentor_id)
     SELECT "Lancelot", "de Lancelot", chefs.id
       FROM chefs
      WHERE chefs.fname = "Martino" AND chefs.lname = "da Como";
INSERT INTO chefs (fname, lname, mentor_id)
     SELECT "Richard", "Leblanc", chefs.id
       FROM chefs
      WHERE chefs.fname = "Guillaume" AND chefs.lname = "Tirel";

CREATE TABLE restaurants (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    neighborhood VARCHAR(255) NOT NULL,
    cuisine VARCHAR(255) NOT NULL
);

INSERT INTO restaurants (name, neighborhood, cuisine)
     VALUES('Alemany Farmers Market','Bernal Heights','Farmer');
INSERT INTO restaurants (name, neighborhood, cuisine)
    VALUES("Blue Plate","Bernal Heights","Hipster");
INSERT INTO restaurants (name, neighborhood, cuisine)
     VALUES("Café Cole", "Cole Valley","Healthy");
INSERT INTO restaurants (name, neighborhood, cuisine)
     VALUES("Boulange de Cole Valley", "Cole Valley","French");

CREATE TABLE chef_tenures (
  id INTEGER PRIMARY KEY,
  chef_id INTEGER  NOT NULL,
  restaurant_id INTEGER NOT NULL,
  start_date DATE  NOT NULL,
  end_date DATE,
  FOREIGN KEY (chef_id) REFERENCES chefs(id),
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date)
      SELECT chefs.id, restaurants.id, '2010-12-15', '2012-12-13'
        FROM chefs
  CROSS JOIN restaurants
       WHERE chefs.fname = 'Guillaume'
         AND restaurants.name = 'Alemany Farmers Market';
INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date)
     SELECT chefs.id, restaurants.id, '2011-10-15', '2012-10-13'
       FROM chefs
 CROSS JOIN restaurants
      WHERE chefs.fname = 'Sidoine'
        AND restaurants.name = 'Alemany Farmers Market';
INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date)
     SELECT chefs.id, restaurants.id, '2008-12-15', '2012-06-10'
       FROM chefs
 CROSS JOIN restaurants
      WHERE chefs.fname = 'Martino'
        AND restaurants.name = 'Alemany Farmers Market';
INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date)
     SELECT chefs.id, restaurants.id, '2009-12-15', '2011-10-13'
       FROM chefs
 CROSS JOIN restaurants
      WHERE chefs.fname = 'Richard'
        AND restaurants.name = 'Café Cole';
INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date)
     SELECT chefs.id, restaurants.id, '2011-09-13', '2012-10-13'
       FROM chefs
 CROSS JOIN restaurants
      WHERE chefs.fname = 'Martino'
        AND restaurants.name = 'Café Cole';
INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date)
     SELECT chefs.id, restaurants.id, '2008-12-15', '2012-06-10'
       FROM chefs
 CROSS JOIN restaurants
      WHERE chefs.fname = 'Martino'
        AND restaurants.name = 'Blue Plate';

CREATE TABLE critics (
  id INTEGER PRIMARY KEY,
screen_name VARCHAR(255)
);

INSERT INTO critics (screen_name)
    VALUES  ('Kara');
INSERT INTO critics (screen_name)
    VALUES  ('Pico');
INSERT INTO critics (screen_name)
    VALUES  ('Shane');
INSERT INTO critics (screen_name)
    VALUES  ('Maddy');
INSERT INTO critics (screen_name)
    VALUES  ('Adam');

CREATE TABLE restaurant_reviews (
  id INTEGER PRIMARY KEY,
  reviewer_id INTEGER NOT NULL,
  restaurant_id INTEGER NOT NULL,
  text_review TEXT,
  score INTEGER,
  date_of_review DATE,
  FOREIGN KEY (reviewer_id) REFERENCES critics(id),
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

INSERT INTO  restaurant_reviews (reviewer_id,restaurant_id, text_review, score, date_of_review)
     SELECT  critics.id,restaurants.id, 'Id give it four stars if the prices were lower', 3, '2012-05-03'
       FROM  critics
 CROSS JOIN  restaurants
      WHERE  critics.screen_name = 'Kara' AND restaurants.name = 'Blue Plate';
INSERT INTO  restaurant_reviews (reviewer_id,restaurant_id, text_review, score, date_of_review)
     SELECT  critics.id,restaurants.id, "The food was that good and the portions were huge",
             4, '2013-01-07'
       FROM  critics
 CROSS JOIN  restaurants
      WHERE  critics.screen_name = 'Maddy' AND restaurants.name = 'Café Cole';
INSERT INTO  restaurant_reviews (reviewer_id,restaurant_id, text_review, score, date_of_review)
     SELECT  critics.id,restaurants.id ,'Think fancy comfort food', 2, '2013-01-08'
       FROM  critics
 CROSS JOIN  restaurants
      WHERE  critics.screen_name = 'Adam' AND restaurants.name = 'Boulange de Cole Valley';
INSERT INTO  restaurant_reviews (reviewer_id,restaurant_id, text_review, score, date_of_review)
     SELECT  critics.id,restaurants.id, 'Food Sucks', 1, '2013-02-08'
       FROM  critics
 CROSS JOIN  restaurants
      WHERE  critics.screen_name = 'Maddy' AND restaurants.name = 'Café Cole';
INSERT INTO  restaurant_reviews (reviewer_id,restaurant_id, text_review, score, date_of_review)
     SELECT  critics.id,restaurants.id, 'Food Poisening', 0, '2013-03-04'
       FROM  critics
 CROSS JOIN  restaurants
      WHERE  critics.screen_name = 'Kara' AND restaurants.name = 'Boulange de Cole Valley';
INSERT INTO  restaurant_reviews (reviewer_id,restaurant_id, text_review, score, date_of_review)
     SELECT  critics.id,restaurants.id, 'Woot', 5, '2010-03-04'
       FROM  critics
 CROSS JOIN  restaurants
      WHERE  critics.screen_name = 'Kara' AND restaurants.name = 'Alemany Farmers Market';




