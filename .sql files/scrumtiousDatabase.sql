--
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
Insert Into Ingredient Values (1, 'Salt', 'Spices');
Insert Into Ingredient Values (2, 'Human Souls', 'Spices');
Insert Into Ingredient Values (3, 'Eye of Newt', 'Meats');
Insert Into Ingredient Values (4, 'Fluxweed', 'Spices');
Insert Into Ingredient Values (5, 'Knotgrass', 'Produce');
Insert Into Ingredient Values (6, 'Lacewing Flies', 'Meats');
Insert Into Ingredient Values (7, 'Leeches', 'Meats');
Insert Into Ingredient Values (8, 'Horn of Bicorn', 'Dairy');
Insert Into Ingredient Values (9, 'Boomslang Skin', 'Meats');
Insert Into Ingredient Values (10, 'Human Hair', 'Spices');
Insert Into Ingredient Values (11, 'Bezoar', 'Spices');
Insert Into Ingredient Values (12, 'Mistletoe Berries', 'Spices');
Insert Into Ingredient Values (13, 'Unicorn Horn', 'Spices');
Insert Into Ingredient Values (14, 'Standard Ingredient', 'Spices');

Insert Into Recipe Values (1, 'Immortality', 'Throw it into a pot add some black magic and boom... Literally', TRUE, 2);
Insert Into Recipe Values (2, 'Polyjuice Potion', '1. Add the fluxweed to the cauldron 2. Add the knto grass 3. Stir 3 times clockwise 4. Wave your wand then let the potion brew for 80 minutes 5. Add the leeches, 6. Crush two cups of lacewing flies in a mortar then add, 7. Heat for 30 seconds on low heat',FALSE, 3);
Insert Into Recipe Values (3, 'Antidote to Common Poisons', '1. Add 1 Bezoar to the mortar. 2. Crush into a very fine powder using the pestle. 3. Add crushed bezoar to your cauldron. 4. Add Standard Ingredient. 5. Heat to medium temperature for 5 seconds. 6. Wave your wand. 7. Leave to brew for 30 minutes. 8. Add Unicorn Horn. 9. Stir twice, clockwise. 10. Add Mistletoe Berries. 11. Stir twice, counterclockwise. 12. Wave wand to complete.', TRUE, 6);


Insert Into RI Values (1, 1, 1, 'tbsp', 3);
Insert Into RI Values (2, 1, 2, NULL, 5);
Insert Into RI Values (3, 1, 3, 'cup', 1);
Insert Into RI Values (4, 2, 4, 'measures', 3);
Insert Into RI Values (5, 2, 5, 'bundles', 2);
Insert Into RI Values (6, 2, 6, 'cups', 3);
Insert Into RI Values (7, 2, 7, NULL, 4);
Insert Into RI Values (8, 2, 8, 'measures', 1);
Insert Into RI Values (9, 2, 9, 'measures', 3);
Insert Into RI Values (10, 2, 10, 'tsp', 1);
Insert Into RI Values (11, 1, 10, 'tsp', 1);
Insert Into RI Values (12, 3, 11, NULL, 1);
Insert Into RI Values (13, 3, 12, NULL, 2);
Insert Into RI Values (14, 3, 13, 'pinch', 1);
Insert Into RI Values (15, 3, 14, 'measure', 2);


Insert Into Note Values (1, 1, 'Add in a pinch of sugar and human hair to  get a real zing out of it. Also, wait until the moon is full');
Insert Into Note Values(2,2,NULL);
Insert Into Note Values(3,3,NULL);

Insert Into Dish Values (1, 1, 4, '2015-10-31 23:59:59');
Insert Into Dish Values (2, 2, 3, '2015-11-10 23:00:00');

