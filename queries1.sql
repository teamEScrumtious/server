--search
SELECT name FROM Recipe WHERE Name LIKE “%UserInput%” ORDER BY name

--get search results
SELECT Recipe.name, Recipe.prepInstructions, Note.content, Ingredient.name, RI.unit, RI.quantity 
FROM Recipe, Ingredient, RI, Note 
WHERE Note.recipeID = Recipe.ID AND RI.recipeID = Recipe.ID AND Ingredient.ID = RI.ingredientID;

--get shopping list
SELECT Ingredient.name, Ingredient.type, RI.unit, RI.quantity 
FROM Ingredient, RI, Recipe
WHERE RI.recipeID = Recipe.ID AND RI.ingredientID = Ingredient.ID
ORDER BY Ingredient.type;