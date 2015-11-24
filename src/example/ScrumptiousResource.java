package example;
import com.sun.net.httpserver.HttpServer;
import com.sun.jersey.api.container.httpserver.HttpServerFactory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.ws.rs.*;

import javax.ws.rs.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.StringTokenizer;

/**
 * Created by jlm54 on 11/18/2015.
 */
// The Java class will be hosted at the URI path "/helloworld"
@Path("/scrumptious")
public class ScrumptiousResource {

    /**
     * @return a simple hello-world string
     */
    @SuppressWarnings("SameReturnValue")
    @GET
    @Path("/hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, chef!";
    }

    /**
     * Constants for a local Postgresql server with the monopoly database
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
            ResultSet resultSet = statement.executeQuery("SELECT * FROM Recipe WHERE id=" + id);
            if (resultSet.next()) {
                result = resultSet.getInt(1) + " " + resultSet.getString(2);
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
            ResultSet resultSet = statement.executeQuery("SELECT  RI.quantity, RI.unit, Ingredient.name, Ingredient.type\n" +
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
        System.out.println("Visit: http://localhost:9998/helloworld");
        System.out.println("Hit return to stop...");
        System.in.read();
        System.out.println("Stopping server");
        server.stop(0);
        System.out.println("Server stopped");
    }
}
