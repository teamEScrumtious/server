package example;

import com.sun.jersey.api.container.httpserver.HttpServerFactory;
import com.sun.net.httpserver.HttpServer;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

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
                        result += "& \n" + resultSet.getInt(1) + "\n" + resultSet.getInt(2) +"\n"+ resultSet.getTimestamp(3) + "\n" + resultSet.getInt(4) + "\n" + resultSet.getString(5)
                                + "\n" + resultSet.getInt(6) + "\n" + resultSet.getString(7) + "\n" + resultSet.getString(8) + "\n" + resultSet.getBoolean(9)
                                + "\n" + resultSet.getInt(10)+ "\n"+ resultSet.getString(11) + "\n" + resultSet.getString(12) + "\n" + resultSet.getInt(13) + "\n" + resultSet.getString(14) + "\n"
                                + resultSet.getInt(15) + "\n";
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
