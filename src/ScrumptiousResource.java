package example;

import com.sun.jersey.api.container.httpserver.HttpServerFactory;
import com.sun.net.httpserver.HttpServer;

import javax.ws.rs.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.StringTokenizer;

/**
 * Created by njk28 on 11/23/2015.
 */
@Path("/scrumptious")
public class ScrumptiousResource {

    /**
     * @return a simple hello-chef string
     */
    @SuppressWarnings("SameReturnValue")
    @GET
    @Path("/hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, chef!";
    }

    /**
     * Constants for a local Postgresql server with the scrum-tious
     */
    private static final String DB_URI = "jdbc:postgresql://localhost:5432/scrum-tious"; //name of server in pgadmin
    private static final String DB_LOGIN_ID = "postgres";
    private static final String DB_PASSWORD = "postgres";

    @GET
    @Path("/recipes")
    @Produces("text/plain")
    public String getRecipes() {
        String result = "";
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM RECIPE");
            while (resultSet.next()) {
                result += resultSet.getInt(1) + " " + resultSet.getString(2) + "\n";
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }

    @GET
    @Path("/recipes/alpha")
    @Produces("text/plain")
    public String getRecipesAlpha() {
        String result = "";
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT ID, name, prepInstructions, servings FROM RECIPE");
            while (resultSet.next()) {
                result += resultSet.getInt(1) + "\n" + resultSet.getString(2) + "\n" + resultSet.getString(3) + "\n" + resultSet.getString(4) + "\n";
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }


    /**
     * @return a string version of the recent recipe records
     */
    @GET
    @Path("/recipes/recents")
    @Produces("text/plain")
    public String getRecents() {
        String result = "";
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT Recipe.ID, name " +
                    "FROM Recipe, Dish " +
                    "WHERE Dish.date  >= (current_date - interval '21 days') AND Dish.date < (current_date) AND Dish.recipeID = Recipe.ID");
            while (resultSet.next()) {
                result += resultSet.getInt(1) + " " + resultSet.getString(2) + "\n";
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }

    /**
     * @return a string version of bookmarked recipe records
     */
    @GET
    @Path("/recipes/bookmarked")
    @Produces("text/plain")
    public String getBookmarked() {
        String result = "";
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT ID, name\n" +
                    "FROM Recipe\n" +
                    "WHERE bookmarked = true");
            while (resultSet.next()) {
                result += resultSet.getInt(1) + " " + resultSet.getString(2) + "\n";
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }

    /**
     * @return A list of all relevant data on dishes in the next 7 days
     * Here is a Key for how it lays it out in the server
     * Dish ID
     * Dish Servings
     * Dish Timestamp
     * Recipe ID
     * Recipe Name
     * Recipe Servings
     * Prep Instructions
     * Note
     * Recipe Bookmarked
     *
     * Ingredients are then listed as:
     * Ingredient ID
     * Ingredient name
     * Ingredient type
     * RI ID
     * RI Unit
     * RI Quantity
     *
     * After a recipe is finished there will be a '&' on a new line
     * then the next dish will begin in the same way.
     */
    @GET
    @Path("/recipes/weekplan")
    @Produces("text/plain")
    public String getDishes() {
        String result = "";
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(
                    "SELECT  Dish.ID, Dish.servings, Dish.date, Recipe.ID, Recipe.name, Recipe.servings, Recipe.prepInstructions, Note.content,"
                            +" Recipe.bookmarked, Ingredient.ID, Ingredient.name, Ingredient.type, RI.ID, RI.unit, RI.quantity \n"+
                    "FROM Recipe, Dish, Ingredient, RI, Note\n" +
                    "WHERE Note.recipeID = Recipe.ID AND RI.recipeID = Recipe.ID AND Dish.recipeID = Recipe.ID AND Ingredient.ID = RI.ingredientID AND\n"+
                            "(Dish.date <= (current_date + interval '7 days')) AND (Dish.date >= (current_date))\n" +
                    "ORDER BY Dish.date;"
            );
            while (resultSet.next()) {
                int RecipeID = resultSet.getInt(1);
                result += resultSet.getInt(1) + "\n" + resultSet.getInt(2) +"\n"+ resultSet.getTimestamp(3) + "\n" + resultSet.getInt(4) + "\n" + resultSet.getString(5)
                        + "\n" + resultSet.getInt(6) + "\n" + resultSet.getString(7) + "\n" + resultSet.getString(8) + "\n" + resultSet.getBoolean(9)
                        + "\n" + resultSet.getInt(10)+ "\n"+ resultSet.getString(11) + "\n" + resultSet.getString(12) + "\n" + resultSet.getInt(13) + "\n" + resultSet.getString(14) + "\n"
                        + resultSet.getInt(15) + "\n";
                while (resultSet.next()){
                    if(resultSet.getInt(1) == RecipeID) {
                        result += resultSet.getInt(10)+ "\n"+ resultSet.getString(11) + "\n" + resultSet.getString(12) + "\n" + resultSet.getInt(13) + "\n" + resultSet.getString(14) + "\n"
                                + resultSet.getInt(15) + "\n";
                }else {
                        result += "&\n";
                        break;
                    }
                }
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }

    /**
     * @param id a recipe id in the scrum-tious database
     * @return a string version of the recipe record, if any, with the given id
     */
    @GET
    @Path("/recipes/{id}")
    @Produces("text/plain")
    public String getRecipe(@PathParam("id") int id) {
        String result;
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(
                    "SELECT Recipe.ID, Recipe.name, Recipe.servings, Recipe.prepInstructions, Note.content, Recipe.bookmarked, Ingredient.name, Ingredient.type, RI.unit, RI.quantity \n" +
                    "FROM Recipe, Ingredient, RI, Note \n" +
                    "WHERE Note.recipeID = Recipe.ID AND RI.recipeID = Recipe.ID AND " +
                    "Ingredient.ID = RI.ingredientID AND Recipe.ID =" + id
                    );
           if (resultSet.next()) {
                result = resultSet.getInt(1)+ "\n" + resultSet.getString(2) + "\n" + resultSet.getInt(3) + "\n" + resultSet.getString(4) + "\n" + resultSet.getString(5)
                    + "\n" + resultSet.getBoolean(6) + "\n" + resultSet.getString(7) + "\n" + resultSet.getString(8) + "\n" + resultSet.getString(9) + "\n"
                    + resultSet.getInt(10) + "\n";
                while (resultSet.next()){
                        result += resultSet.getString(7) + "\n" + resultSet.getString(8) + "\n"
                                + resultSet.getString(9) + "\n" + resultSet.getInt(10) + "\n";
                }
                result += "& \n";
            } else {
                result = "nothing found...";
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }

    /**
     * @return a string version of the shopping list.
     */
    @GET
    @Path("/shoppinglist")
    @Produces("text/plain")
    public String getShoppingList() {
        String result = "";
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(
                    "SELECT  RI.quantity, RI.unit, Ingredient.name, Ingredient.type\n" +
                    "FROM Ingredient, RI, Recipe, Dish\n" +
                    "WHERE RI.recipeID = Recipe.ID AND RI.ingredientID = Ingredient.ID AND Dish.recipeID = Recipe.ID \n" +
                    "  AND (Dish.date <= (current_date + interval '7 days')) AND (Dish.date >= (current_date))\n" +
                    "ORDER BY Ingredient.type;");
            while (resultSet.next()) {
                result += resultSet.getString(3) + "\t\t" + resultSet.getInt(1) + " " + resultSet.getString(2) + " " + "\n";
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }
    /**
     * PUT method for creating an instance of Person with a given ID - If the
     * player already exists, replace them with the new player field values. We do this
     * because PUT is idempotent, meaning that running the same PUT several
     * times does not change the database.
     *
     * @param id         the ID for the new player, assumed to be unique
     * @param playerLine a string representation of the player in the format: emailAddress name
     * @return status message
     */
/**    @PUT
 *   @Path("/recipe/{id}")
 *   @Consumes("text/plain")
 *   @Produces("text/plain")
 *   public String putRecipe(@PathParam("id") int RecipeID, String RecipeName, int RecipeServings, String RecipePrepInstructions, String NoteContent, boolean RecipeBookmarked, String IngredientName, String IngredientType, String RIunit, int RIQuantity) {
 *       String result;
 *       StringTokenizer st = new StringTokenizer(playerLine);
 *       String emailAddress = st.nextToken(), name = st.nextToken();
 *       try {
 *           Class.forName("org.postgresql.Driver");
 *           Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
 *           Statement statement = connection.createStatement();
 *           ResultSet resultSet = statement.executeQuery("SELECT * FROM Player WHERE id=" + id);
 *           if (resultSet.next()) {
 *               statement.executeUpdate("UPDATE Player SET emailaddress='" + emailAddress + "' name='" + name + "' WHERE id=" + id);
 *               result = "Player " + id + " updated...";
 *           } else {
 *               statement.executeUpdate("INSERT INTO Player VALUES (" + id + ", '" + emailAddress + "', '" + name + "')");
 *               result = "Player " + id + " added...";
 *           }
 *           resultSet.close();
 *           statement.close();
 *           connection.close();
 *       } catch (Exception e) {
 *           result = e.getMessage();
 *       }
 *       return result;
 *   }
 */
    /**
     * POST method for creating an instance of Person with a new, unique ID
     * number. We do this because POST is not idempotent, meaning that running
     * the same POST several times creates multiple objects with unique IDs but
     * with the same values.
     * <p/>
     * The method creates a new, unique ID by querying the player table for the
     * largest ID and adding 1 to that. Using a sequence would be a better solution.
     *
     * @param DishLine a string representation of the player in the format: emailAddress name
     * @return status message
     */
    @POST
    @Path("/recipes/weekplan")
    @Consumes("text/plain")
    @Produces("text/plain")
    public String postDish(String DishLine) {
        String result;
        StringTokenizer st = new StringTokenizer(DishLine);
        int id = -1;
        String recipeID = st.nextToken(), servings = st.nextToken(), date = st.nextToken();
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT MAX(ID) FROM Dish");
            if (resultSet.next()) {
                id = resultSet.getInt(1) + 1;
            }
            statement.executeUpdate("INSERT INTO Dish VALUES (" + id + ", '" + recipeID + "', '" + servings + "', '" + date +"')");
            resultSet.close();
            statement.close();
            connection.close();
            result = "New Dish added for " + date + "...";
        } catch (Exception e) {
            result = e.getMessage();
        }
        return result;
    }

    /**
     * DELETE method for deleting and instance of player with the given ID. If
     * the player doesn't exist, then don't delete anything. DELETE is idempotent, so
     * sending the same command multiple times should result in the same side
     * effect, though the return value may be different.
     *
     * @param id the ID of the player to be returned
     * @return a simple text confirmation message
     */
    @DELETE
    @Path("/recipes/{id}")
    @Produces("text/plain")
    public String deleteRecipe(@PathParam("id") int id) {
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(DB_URI, DB_LOGIN_ID, DB_PASSWORD);
            Statement statement = connection.createStatement();
            statement.executeUpdate("DELETE FROM Recipe, RI, Note, Dish WHERE Recipe.id=" + id +" AND Recipe.ID = RI.RecipeID AND Note.RecipeID = Recipe.ID AND Dish.RecipeID = Recipe.ID");
            statement.close();
            connection.close();
        } catch (Exception e) {
            return e.getMessage();
        }
        return "Recipe " + id + " deleted...";
    }



    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServerFactory.create("http://localhost:9998/");
        server.start();

        System.out.println("Server running");
        System.out.println("Visit: http://localhost:9998/scrumptious");
        System.out.println("Hit return to stop...");
        System.in.read();
        System.out.println("Stopping server");
        server.stop(0);
        System.out.println("Server stopped");
    }
}
