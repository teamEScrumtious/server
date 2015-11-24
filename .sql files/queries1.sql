--get list of all recipes 
SELECT name, ID
FROM Recipe 

--get list of recent recipes
SELECT name, Recipe.ID
FROM Recipe, Dish
WHERE Dish.date  <= (current_date + interval '21 days') AND Dish.recipeID = Recipe.ID

--get list of favorite recipes
SELECT name, ID
FROM Recipe
WHERE bookmarked = true

--search
SELECT name, ID 
FROM Recipe 
WHERE name LIKE “%UserInput%” 
ORDER BY name

--get search results
SELECT Recipe.name, Recipe.prepInstructions, Note.content, Ingredient.name, RI.unit, RI.quantity 
FROM Recipe, Ingredient, RI, Note 
WHERE Note.recipeID = Recipe.ID AND RI.recipeID = Recipe.ID AND 
  Ingredient.ID = RI.ingredientID AND Recipe.ID = 3 --Recipe will be determined by user selection

--get shopping list
SELECT  RI.quantity, RI.unit, Ingredient.name, Ingredient.type
FROM Ingredient, RI, Recipe, Dish
WHERE RI.recipeID = Recipe.ID AND RI.ingredientID = Ingredient.ID AND Dish.recipeID = Recipe.ID 
  AND (Dish.date <= (current_date + interval '7 days')) AND (Dish.date >= (current_date))
ORDER BY Ingredient.type;
