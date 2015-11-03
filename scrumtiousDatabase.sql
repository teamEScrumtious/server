--
-- This SQL Script will build a recipe book database.
--
--
--@author njk28
--@version October 30, 2015
--
-- Drop previous versions of the tables if they exist, in reverse order of foreign keys
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS Ingredient;
Drop Table if Exists Note;
DROP TABLE IF EXISTS RI;
DROP TABLE IF EXISTS Dish;

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
	recipeID References Recipe(ID),
	content varchar(3000);
	);
	
Create Table RI (
	ID integer Primary Key,
	RecipeID integer References Recipe(ID),
	IngredientID integer References Ingredient(ID)
	unit varchar(7);
	quantity decimal(5,2);
	);

Create Table Dish(
	ID integer Primary Key,
	recipeID integer References Recipe(ID),
	servings integer,
	date timestamp
	);

-- What does this do?
Grant Select On Recipe To Public;
Grant Select On Ingredient To Public;
Grant Select On Note To Public;
Grant Select On RI To Public;
Grant Select On Dish To Public;

-- Insert the data
Insert Into Ingredient Values (1, 'Salt', 'Spices');
Insert Into Ingredient Values (2, 'Human Souls', 'Spices');
Insert Into Ingredient Values (3, 'Eye of Newt', 'Meats');

Insert Into Recipes Values (1, 'Immortality', 'Throw it into a pot add some black magic and boom... Literally', TRUE, 2);

Insert Into RI Values (1, 1, 1, 'tbsp', 3);
Insert Into RI Values (2, 1, 2, NULL, 5);
Insert Into RI Values (3, 1, 3, 'cup', 1);

Insert Into Note Values (1, 1, "Add in a pinch of sugar and human hair to get a real zing out of it. Also, wait until the moon is full);

Insert Into Dish Values (1, 1, 4, '2015-10-31 23:59:59');
