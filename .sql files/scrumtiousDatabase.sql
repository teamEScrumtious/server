﻿--
-- This SQL Script will build a recipe book database.
--
--
--@author njk28
--@version October 30, 2015
--
-- Drop previous versions of the tables if they exist, in reverse order of foreign keys
DROP TABLE IF EXISTS Dish;
DROP TABLE IF EXISTS RI;
Drop Table if Exists Note;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Recipe;

-- Create the Schema.
Create Table Recipe (
	ID integer Primary Key,
	name varchar(50),
	prepInstructions varchar(3000),
	bookmarked boolean,
	servings integer
	);

Create Table Ingredient (
	ID integer Primary Key,
	name varchar(50),
	type varchar(20)
	);

Create Table Note (
	ID integer Primary Key,
	recipeID integer References Recipe(ID),
	content varchar(3000)
	);
Create Table RI (
	ID integer Primary Key,
	RecipeID integer References Recipe(ID),
	IngredientID integer References Ingredient(ID),
	unit varchar(12),
	quantity decimal(5,2)
	);

Create Table Dish(
	ID integer Primary Key,
	recipeID integer References Recipe(ID),
	servings integer,
	date timestamp
	);

-- Enables queries from the outside
Grant Select On Recipe To Public;
Grant Select On Ingredient To Public;
Grant Select On Note To Public;
Grant Select On RI To Public;
Grant Select On Dish To Public;


-- Inserts Data
Insert Into Ingredient Values (1, 'Salt', 'Spice');
Insert Into Ingredient Values (2, 'Human Souls', 'Spice');
Insert Into Ingredient Values (3, 'Eye of Newt', 'Meat');
Insert Into Ingredient Values (4, 'Fluxweed', 'Spice');
Insert Into Ingredient Values (5, 'Knotgrass', 'Produce');
Insert Into Ingredient Values (6, 'Lacewing Flies', 'Meat');
Insert Into Ingredient Values (7, 'Leeches', 'Meat');
Insert Into Ingredient Values (8, 'Horn of Bicorn', 'Dairy');
Insert Into Ingredient Values (9, 'Boomslang Skin', 'Meat');
Insert Into Ingredient Values (10, 'Human Hair', 'Spice');
Insert Into Ingredient Values (11, 'Bezoar', 'Spice');
Insert Into Ingredient Values (12, 'Mistletoe Berries', 'Spice');
Insert Into Ingredient Values (13, 'Unicorn Horn', 'Spice');
Insert Into Ingredient Values (14, 'Standard Ingredient', 'Spice');
Insert Into Ingredient Values (15, 'Chicken', 'Meat');
Insert Into Ingredient Values (16, 'Ground Beef', 'Meat');
Insert Into Ingredient Values (17, 'Taco Seasoning', 'Spice');
Insert Into Ingredient Values (18, 'Lettuce', 'Produce');
Insert Into Ingredient Values (19, 'Cheese', 'Dairy');
Insert Into Ingredient Values (20, 'Tortilla', 'Bread');
Insert Into Ingredient Values (21, 'Oats', 'Baking');
Insert Into Ingredient Values (22, 'Butter', 'Dairy');
Insert Into Ingredient Values (23, 'Baking Soda', 'Baking');
Insert Into Ingredient Values (24, 'Milk', 'Dairy');
Insert Into Ingredient Values (25, 'Eggs', 'Dairy');
Insert Into Ingredient Values (28, 'Split Green Peas', 'Produce')
Insert Into Ingredient Values (29, 'Leeks', 'Produce')
Insert Into Ingredient Values (30, 'Onions', 'Produce')
Insert Into Ingredient Values (31, 'Carrots', 'Produce')
Insert Into Ingredient Values (32, 'Potatoes', 'Produce')
Insert Into Ingredient Values (33, 'Spare ribs', 'Meat')
Insert Into Ingredient Values (36, 'Bacon', 'Meat')
Insert Into Ingredient Values (37, 'Celeriac', 'Produce')


Insert Into Recipe Values (1, 'Immortality', 'Throw it into a pot add some black magic and boom... Literally', TRUE, 2);
Insert Into RI Values (1, 1, 1, 'tbsp', 3);
Insert Into RI Values (2, 1, 2, NULL, 5);
Insert Into RI Values (3, 1, 3, 'cup', 1);
Insert Into RI Values (11, 1, 10, 'tsp', 1);
Insert Into Note Values (1, 1, 'Add in a pinch of sugar and human hair to  get a real zing out of it. Also, wait until the moon is full');

Insert Into Recipe Values (2, 'Polyjuice Potion', '1. Add the fluxweed to the cauldron 2. Add the knto grass 3. Stir 3 times clockwise 4. Wave your wand then let the potion brew for 80 minutes 5. Add the leeches, 6. Crush two cups of lacewing flies in a mortar then add, 7. Heat for 30 seconds on low heat',FALSE, 3);
Insert Into RI Values (4, 2, 4, 'measures', 3);
Insert Into RI Values (5, 2, 5, 'bundles', 2);
Insert Into RI Values (6, 2, 6, 'cup', 3);
Insert Into RI Values (7, 2, 7, NULL, 4);
Insert Into RI Values (8, 2, 8, 'measures', 1);
Insert Into RI Values (9, 2, 9, 'measures', 3);
Insert Into RI Values (10, 2, 10, 'tsp', 1);
Insert Into Note Values(2,2,NULL);

Insert Into Recipe Values (3, 'Antidote to Common Poisons', '1. Add 1 Bezoar to the mortar. 2. Crush into a very fine powder using the pestle. 3. Add crushed bezoar to your cauldron. 4. Add Standard Ingredient. 5. Heat to medium temperature for 5 seconds. 6. Wave your wand. 7. Leave to brew for 30 minutes. 8. Add Unicorn Horn. 9. Stir twice, clockwise. 10. Add Mistletoe Berries. 11. Stir twice, counterclockwise. 12. Wave wand to complete.', TRUE, 6);
Insert Into RI Values (12, 3, 11, NULL, 1);
Insert Into RI Values (13, 3, 12, NULL, 2);
Insert Into RI Values (14, 3, 13, 'pinch', 1);
Insert Into RI Values (15, 3, 14, 'measure', 2);
Insert Into Note Values(3,3,NULL);

Insert Into Recipe Values (4, 'Nathans Tacos', '1. Brown the Beef. 2. Pour a the water and the taco seasoning into the pan with the beef and cook until water mostly boils off. 3. Warm other ingredients to desired temperature. 4. Mix as desired. 5. Enjoy.', TRUE, 5);
Insert Into RI Values (16, 4, 16, 'lb' , 0.5);
Insert Into RI Values (17, 4, 17, 'tbsp', 1);
Insert Into RI Values (18, 4, 18, 'cup', 1);
Insert Into RI Values (19, 4, 19, NULL, 5);
Insert Into RI Values (20, 4, 20, NULL, 6);
Insert Into Note Values(4,4, NULL);

Insert Into Recipe Values (5, 'Lias Baked Oatmeal', '1. Preheat oven to 325^F 2. Mix all ingredients together. 3. Pour into 9in cake pan 4. Bake for 40 minutes. Can also be made ahead a few days and baked in the morning.', TRUE, 4);
Insert Into RI Values (21, 5, 21, 'cup' , 2);
Insert Into RI Values (22, 5, 22, 'cup', 0.5);
Insert Into RI Values (23, 5, 23, 'tsp', 1);
Insert Into RI Values (24, 5, 24, 'cup', 1);
Insert Into RI Values (25, 5, 1, 'tsp', 1);
Insert Into RI Values (26, 5, 25, NULL, 2);
Insert Into Note Values(5,5, NULL);

Insert Into Recipe Values (8, 'Pea Soup', '1. Add split green peas, spareribs, bacon and water and simmer for approximatle 1.5 hours. 2. Add chopped leeks, celeriac, onion, carrots and potato and cook for another hour until the soup becomes thick. 3. Take the meat out and remove bones. 4. Puree the soup and add the meat back in', FALSE, 8);
Insert Into RI Values (37, 8, 28, 'cup' , 3.5);
Insert Into RI Values (38, 8, 33, 'lb', 1);
Insert Into RI Values (39, 8, 36, 'lb', .5);
Insert Into RI Values (40, 8, 27, 'cup', 13);
Insert Into RI Values (41, 8, 29, NULL, 2);
Insert Into RI Values (42, 8, 37, NULL, 1);
Insert Into RI Values (43, 8, 30, NULL, 1);
Insert Into RI Values (44, 8, 31, NULL, 1);
Insert Into RI Values (45, 8, 32, NULL, 1);
Insert Into Note Values(8, 8, NULL);

Insert Into Dish Values (1, 1, 4, '2015-10-31 23:59:59');
Insert Into Dish Values (2, 2, 3, '2015-11-10 23:00:00');
Insert Into Dish Values (3, 4, 4, '2015-12-06 18:00:00');
Insert Into Dish Values (4, 4, 3, '2015-12-02 12:00:00');
Insert Into Dish Values (5, 5, 4, '2015-12-06 08:00:00');
