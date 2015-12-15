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
Insert Into Ingredient Values (1, 'Salt', 'Spice');
Insert Into Ingredient Values (15, 'Chicken Breast', 'Meat');
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
Insert Into Ingredient Values (26, 'Flour', 'Baking');
Insert Into Ingredient Values (27, 'Water', 'Baking');
Insert Into Ingredient Values (28, 'Butternut Squash', 'Produce');
Insert Into Ingredient Values (29, 'Leeks', 'Produce');
Insert Into Ingredient Values (30, 'Yellow Onion', 'Produce');
Insert Into Ingredient Values (31, 'Carrots', 'Produce');
Insert Into Ingredient Values (32, 'Potatoes', 'Produce');
Insert Into Ingredient Values (33, 'Spare Ribs', 'Meat');
Insert Into Ingredient Values (34, 'Yeast', 'Baking');
Insert Into Ingredient Values (35, 'Olive Oil', 'Baking');
Insert Into Ingredient Values (36, 'Bacon', 'Meat');
Insert Into Ingredient Values (37, 'Split Green Peas', 'Produce');
Insert Into Ingredient Values (38, 'Thyme', 'Spice' );
Insert Into Ingredient Values (39, 'Oregano', 'Spice');
Insert Into Ingredient Values (40, 'Red Bell Pepper', 'Produce');
Insert Into Ingredient Values (41, 'Sweet Potato', 'Produce');
Insert Into Ingredient Values (42, 'Portobello Mushrooms', 'Produce');
Insert Into Ingredient Values (43, 'Sun-dried Tomatoes', 'Produce');
Insert Into Ingredient Values (44, 'Spinach', 'Produce');
Insert Into Ingredient Values (45, 'Marsala Wine', 'Alcohol');
Insert Into Ingredient Values (46, 'Balsamic Vinegar', 'Baking');
Insert Into Ingredient Values (47, 'Red Onion', 'Produce');
Insert Into Ingredient Values (48, 'Rosemary', 'Spice' );
Insert Into Ingredient Values (49, 'Lean Ground Beef', 'Meat');
Insert Into Ingredient Values (50, 'Dry Enchilada Sauce Mix', 'Spice');
Insert Into Ingredient Values (51, 'Cheddar Cheese', 'Dairy');
Insert Into Ingredient Values (52, 'Black Olives', 'Produce');
Insert Into Ingredient Values (53, 'Blueberries', 'Produce');
Insert Into Ingredient Values (54, 'Black Olives', 'Produce');
Insert Into Ingredient Values (55, 'Brown Sugar', 'Baking');
Insert Into Ingredient Values (56, 'White Sugar', 'Baking');
Insert Into Ingredient Values (57, 'Shortening', 'Baking');
Insert Into Ingredient Values (58, 'Lime', 'Produce');
Insert Into Ingredient Values (59, 'Lemon', 'Produce');
Insert Into Ingredient Values (60, 'Double pie crust', 'Baking');
Insert Into Ingredient Values (61, 'Cinnamon', 'Spice');
Insert Into Ingredient Values (62, 'Molasses', 'Baking');
Insert Into Ingredient Values (63, 'Ginger', 'Spice');
Insert Into Ingredient Values (64, 'Canola Oil', 'Baking');
Insert Into Ingredient Values (65, 'Vanilla Pudding Mix', 'Miscellaneous');
Insert Into Ingredient Values (66, 'Vanilla Extract', 'Spice');
Insert Into Ingredient Values (67, 'Semi-Sweet Chocolate Chips', 'Baking');
Insert Into Ingredient Values (68, 'Chopped Walnuts', 'Baking');
Insert Into Ingredient Values (69, 'Almond Extract', 'Spice');
Insert Into Ingredient Values (70, 'Powdered Sugar', 'Baking');
Insert Into Ingredient Values (71, 'Cream of Tartar', 'Spice');


Insert Into Recipe Values (1, 'Nathans Tacos', '1. Brown the Beef. \n2. Pour a the water and the taco seasoning into the pan with the beef and cook until water mostly boils off. \n3. Warm other ingredients to desired temperature. \n4. Mix as desired. \n5. Enjoy.', TRUE, 5);
Insert Into RI Values (16, 1, 16, 'lb' , 0.5);
Insert Into RI Values (17, 1, 17, 'tbsp', 1);
Insert Into RI Values (18, 1, 18, 'cup', 1);
Insert Into RI Values (19, 1, 19, ' ', 5);
Insert Into RI Values (20, 1, 20, ' ', 6);
Insert Into Note Values(1,1, NULL);

Insert Into Recipe Values (2, 'Baked Oatmeal', '1. Preheat oven to 325^F \n2. Mix all ingredients together. \n3. Pour into 9in cake pan \n4. Bake for 40 minutes. Can also be made ahead a few days and baked in the morning.', TRUE, 4);
Insert Into RI Values (21, 2, 21, 'cup' , 2);
Insert Into RI Values (22, 2, 22, 'cup', 0.5);
Insert Into RI Values (23, 2, 23, 'tsp', 1);
Insert Into RI Values (24, 2, 24, 'cup', 1);
Insert Into RI Values (25, 2, 1, 'tsp', 1);
Insert Into RI Values (26, 2, 25, ' ', 2);
Insert Into RI Values (68, 2, 55, 'cup', .5);
Insert Into Note Values(2, 2, NULL);

Insert Into Recipe Values (3, 'Pizza Dough', '1. Mix yeast and warm water. \n2. add 1.5 cups flour. \n3. Add oil and 1-1.5 cups more flour. \n4. knead until smooth and elastic. \n5. Let rise until doubled. \n6. Punch and shape into pizza crust or pretzels!', TRUE, 4);
Insert Into RI Values (27, 3, 27, 'cup' , 2);
Insert Into RI Values (28, 3, 34, 'tbsp', 1);
Insert Into RI Values (29, 3, 26, 'cup', 3);
Insert Into RI Values (30, 3, 35, 'tbsp', 3);
Insert Into Note Values(3,3, 'Make sure water is warm, but not hot so it does not kill the yeast.');

Insert Into Recipe Values (4, 'Pie Crust', '1. Mix flour and salt. \n2. Cut cold butter into mixture with pastry cutter. \n3. Add 2-3 tablespoons cold water until dough holds together. Do not let it get too sticky.', TRUE, 8);
Insert Into RI Values (33, 4, 22, 'cup' , .5);
Insert Into RI Values (34, 4, 26, 'cup', 1.5);
Insert Into RI Values (35, 4, 1, 'tsp', 1);
Insert Into RI Values (36, 4, 27, 'tbsp', 3);
Insert Into Note Values(4, 4, NULL);

Insert Into Recipe Values (5, 'Pea Soup', '1. Add split green peas, spareribs, bacon and water and simmer for approximatle 1.5 hours. \n2. Add chopped leeks, celeriac, onion, carrots and potato and cook for another hour until the soup becomes thick. \n3. Take the meat out and remove bones. \n4. Puree the soup and add the meat back in', FALSE, 8);
Insert Into RI Values (37, 5, 28, 'cup' , 3.5);
Insert Into RI Values (38, 5, 33, 'lb', 1);
Insert Into RI Values (39, 5, 36, 'lb', .5);
Insert Into RI Values (40, 5, 27, 'cup', 13);
Insert Into RI Values (41, 5, 29, ' ', 2);
Insert Into RI Values (42, 5, 37, ' ', 1);
Insert Into RI Values (43, 5, 30, ' ', 1);
Insert Into RI Values (44, 5, 31, ' ', 1);
Insert Into RI Values (45, 5, 32, ' ', 1);
Insert Into Note Values(5, 5, NULL);

Insert Into Recipe Values (6, 'Chicken Marsala', '1. Place chicken breasts between 2 pieces of wax paper and pound into 1/4 inch thick wtih a meat mallet. Dust chicken with flour, salt, pepper and oregano. \n2. In a skillet, fry chicken in olive oil over medium heat. Cook until done, turning to cook evenly. Set aside and keep warm. \n3. In the same pan, melt the butter over medium heat; add mushrooms, sun-dried tomatoes, and Marsala wine. Cook for approximately 10 minutes, stirring occasionally. Mix in spinach and cook for about 2 minutes. Serve over chicken', FALSE, 4);
Insert Into RI Values (46, 6, 15, ' ', 4);
Insert Into RI Values (47, 6, 26, 'cup', .25);
Insert Into RI Values (48, 6, 39, 'tbsp', 1);
Insert Into RI Values (49, 6 , 35, 'tbsp', 2);
Insert Into RI Values (50, 6, 22, 'cup', .75);
Insert Into RI Values (51, 6, 42, 'cup', 3);
Insert Into RI Values (52, 6, 43,'cup', .75);
Insert Into RI Values (53, 6, 44, 'cup', .5);
Insert Into RI Values (54, 6, 45, 'cup', 1);
Insert Into Note Values(6, 6, NULL);

Insert Into Recipe Values (7, 'Roasted Vegetables', '1. Preheat oven to 475 degrees F (245 degrees C).\n2. In a large bowl, combine cubed squash, red bell peppers, sweet potato, pototoes, and sliced onions. \n3. In a small bowl, combine thyme, rosemary, olive oil, vinegar, salt and pepper. Toss wtih vegetables until they are coated. Spread evenly on a large roasting pan. \n3. Roast for 35 to 40 minutes, stirring every 10 minutes, or until vegetables are cooked through and browned.', FALSE, 12);
Insert Into RI Values (69, 7, 28, ' ', 1);
Insert Into RI Values (55, 7, 40, ' ', 2);
Insert Into RI Values (56, 7, 32, ' ', 3);
Insert Into RI Values (57, 7, 47, ' ', 1);
Insert Into RI Values (58, 7, 38, 'tbsp', 1);
Insert Into RI Values (59, 7, 48, 'tbsp', 1);
Insert Into RI Values (60, 7, 35, 'cup', .25);
Insert Into RI Values (61, 7, 46, 'tbsp', 2);
Insert Into Note Values(7, 7, NULL);

Insert Into Recipe Values (8, 'Easy Beef Enchiladas', '1. Preheat oven to 350 degrees F(175 degrees C) In a medium skillet, cook ground beef and chopped onion until beef is browned evenly and onion is tender. \n2. Prepare enchilada sauce according to package instructions. Pour 1/4 of the sauce into the bottom of a 9x13 inch baking dish. \n3. On each flour tortilla, place an equal portion of the ground beef mixture and about 1 ounce of shredded Cheddar cheese, reserving at least 1/2 cup of the cheese. Then tightly roll the tortillas and place seam side down in the baking dish. \n4. Pour the remaining sauce over the top of the enchiladas and sprinkle with the remaining shredded cheese and olives. \n5. Bake in a preheated oven for 20 minutes, or until the sauce is bubbly and cheese is thoroughly melted.', FALSE, 10);
Insert Into RI Values (62, 8, 49, 'lb', 1);
Insert Into RI Values (63, 8, 30, ' ', 1);
Insert Into RI Values (64, 8, 50, 'oz', 1.5);
Insert Into RI Values (65, 8, 20, ' ', 10);
Insert Into RI Values (66, 8, 30, 'cups', 2);
Insert Into RI Values (67, 8, 52, 'oz', 2.25);
Insert Into Note Values(8, 8, NULL);

Insert Into Recipe Values (9, 'Blueberry Pie','1. Zest lemon and lime and set aside. Squeeze juice from lemon and lime. \n2. In a large mixing bowl, combine sugar and 3 tbsp  of flour. Stir in berries, lemon & lime zest, and half of the juice.\n2. Pour mixture into pie crust and seal with the remaining crust. \n3. If desired, brush pastry with a little milk and sprinkle additional sugar. To prevent over browning, cover pie with aluminium foil \n4. Bake in a 375 degree F oven for 25 minutes. Remove foil and bake for another 25-30 minutes more, or until top is golden. \n5. Cool on wire rack', FALSE, 11);
Insert Into RI Values (76, 9, 53, 'cup', 5);
Insert Into RI Values (75, 9, 57, 'cup', .66 );
Insert Into RI Values (70, 9, 56, 'cup', .66);
Insert Into RI Values (71, 9, 26, 'tbsp', 3);
Insert Into RI Values (72, 9, 58, ' ', 1);
Insert Into RI Values (73, 9, 59, ' ', 1);
Insert Into RI Values (74, 9, 60, ' ', 1);
Insert Into Note Values(9, 9, NULL);

Insert Into Recipe Values (10, 'Ginger-Molasses Cookies','1. Preheat oven to 325^F. \n2. Cream sugar and oil. \n3. Add eggs, then molasses \n4. Stir in cinnamon, ginger, baking soda, and salt. \n 5. Add flour gradually. \n6. Spoon onto parchment-lined cookie sheet and bake for 10 minutes or less, until puffy. Do not over-bake! \n7. Enjoy!', True, 24);
Insert Into RI Values (77, 10, 56, 'cup', 2);
Insert Into RI Values (78, 10, 64, 'cup', 1.5 );
Insert Into RI Values (79, 10, 25, ' ', 2);
Insert Into RI Values (80, 10, 63, 'tbsp', 1);
Insert Into RI Values (81, 10, 62, 'tsp', 2);
Insert Into RI Values (82, 10, 1, 'tsp', 1);
Insert Into RI Values (83, 10, 23, 'tsp', 4);
Insert Into RI Values (84, 10, 26, 'cup', 4);
Insert Into Note Values(10, 10, NULL);

Insert Into Recipe Values (11, 'Tammies Chocolate Chip Cookies', '1.Preheat oven to 350 degrees F (175 degrees C). \n2. Sift together the flour and baking soda, set aside. \n3. In a large bowl, cream together the butter, brown sugar, and white sugar. \n4. Beat in the instant pudding mix until blended. \n5.Stir in the eggs and vanilla. \n6. Blend in the flour mixture. \n7. Finally, stir in the chocolate chips and nuts. \n8. Drop cookies by rounded spoonfuls onto ungreased cookie sheets. \n9.Bake for 10 to 12 minutes in the preheated oven. Edges should be golden brown.', TRUE, 72);
Insert Into RI Values (85, 11, 26, 'cup', 4.5);
Insert Into RI Values (86, 11, 23, 'tsp', 2);
Insert Into RI Values (87, 11, 22, 'cup', 2);
Insert Into RI Values (88, 11, 25, 'cup', 1.5);
Insert Into RI Values (89, 11, 26, 'cup', .5);
Insert Into RI Values (90, 11, 65, 'oz', 6.8);
Insert Into RI Values (91, 11, 25, ' ', 4);
Insert Into RI Values (92, 11, 66, 'tsp', 2);
Insert Into RI Values (93, 11, 67, 'cup', 4);
Insert Into RI Values (94, 11, 68, 'cup', 2);
Insert Into Note Values (11, 11, NULL);

Insert Into Recipe Values (12, 'Lias Christmas Cookies', '1. Preheat oven to 375 ^F \n2. In a bowl, cream butter and sugar. Add egg and extracts. \n3. Combine flour, baking soda and cream of tartar; gradually add to the creamed mixture and mix well. \n4. Chill for 2-3 hours.\n5. On a lightly floured surface, roll dough to 1/8-in. thickness. Cut into desired shapes. Place on ungreased baking sheets. \n6.Bake at 375° for 7-8 minutes or until edges begin to brown. \n7.Cool on a wire rack.', TRUE, 30);
Insert Into RI Values (95, 12, 22, 'cup', 1);
Insert Into RI Values (96, 12, 70, 'cup', 1.5);
Insert Into RI Values (97, 12, 25, ' ', 1);
Insert Into RI Values (98, 12, 66, 'tsp', 1);
Insert Into RI Values (99, 12, 69, 'tsp', .5);
Insert Into RI Values (100, 12, 26, 'cup', 2.5);
Insert Into RI Values (101, 12, 23, 'tsp', 1);
Insert Into RI Values (102, 12, 71, 'tsp', 1);
Insert Into Note Values (12, 12, NULL);


Insert Into Recipe Values (13, 'Lias Buttercream Frosting', '1. Beat sugar and butter in a bowl. \n2. Add vanilla and almond', TRUE, 48);
Insert Into RI Values (103, 13, 22, 'cup', 1);
Insert Into RI Values (104, 13, 70, 'cup', 2);
Insert Into RI Values (105, 13, 66, 'tsp', .5);
Insert Into RI Values (106, 13, 69, 'tsp', .25);
Insert Into Note Values (13, 13, NULL);


Insert Into Dish Values (3, 4, 4, '2015-12-06 18:00:00');
Insert Into Dish Values (4, 4, 3, '2015-12-02 12:00:00');
Insert Into Dish Values (5, 5, 4, '2015-12-16 08:00:00');
Insert Into Dish Values (6, 10, 24, '2015-12-15 09:00:00');
Insert Into Dish Values (7, 11, 72, '2015-12-15 09:15:00');
Insert Into Dish Values (8, 12, 30, '2015-12-15 09:30:00');
Insert Into Dish Values (9, 13, 30, '2015-12-15 09:45:00');
Insert Into Dish Values (10, 5, 6, '2015-12-16 18:30:00');
Insert Into Dish Values (10, 7, 8, '2015-12-17 18:40:00');
Insert Into Dish Values (11, 6, 4, '2015-12-17 18:30:00');
Insert Into Dish Values (12, 1, 4, '2015-12-18 18:30:00');
Insert Into Dish Values (13, 3, 12, '2015-12-19 18:30:00');
Insert Into Dish Values (14, 2, 6, '2015-12-20 11:00:00');




