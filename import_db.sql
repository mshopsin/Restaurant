CREATE TABLE chefs (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  mentor_id INTEGER,

  FOREIGN KEY(mentor_id) REFERENCES chefs(id)

);

INSERT INTO chefs (fname, lname, mentor_d)
VALUES(Sidoine, Benoît, NULL);

INSERT INTO chefs (fname, lname, mentor_d)
     SELECT "Guillaume", "Tirel", chefs.mentor_id
       FROM chefs
      WHERE chefs.fname = "Sidoine" AND chefs.lname = "Benoît";
INSERT INTO chefs (fname, lname, mentor_d)
     SELECT "Martino", "da Como", chefs.mentor_id
       FROM chefs
      WHERE chefs.fname = "Sidoine" AND chefs.lname = "Benoît";
INSERT INTO chefs (fname, lname, mentor_d)
     SELECT "Lancelot", "de Lancelot", chefs.mentor_id
       FROM chefs
      WHERE chefs.fname = "Martino" AND chefs.lname = "da Como";
INSERT INTO chefs (fname, lname, mentor_d)
     SELECT "Richard", "Leblanc", chefs.mentor_id
       FROM chefs
      WHERE chefs.fname = "Guillaume" AND chefs.lname = "Tirel";

CREATE TABLE restaurants (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    neighborhood VARCHAR(255) NOT NULL,
    cuisine VARCHAR(255) NOT NULL
);

INSERT INTO restaurants (name, neighborhood, cuisine)
VALUES("Alemany Farmers Market","Bernal Heights","Farmer")
VALUES("Blue Plate","Bernal Heights","Hipster")
VALUES("Café Cole", "Cole Valley","Healthy")
VALUES("Boulange de Cole Valley", "Cole Valley","French")

