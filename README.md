# ScrumptiousServer
1. Start local service postgresql x64
2. run pgAdmin III
3. Right click -> connect to main server, PW postgres
4. Right click Databses -> new db. name ScrumptiousServer, 
owner postgres
5. tools -> query tools or CTRL+E
6. Run run data through from our git server repo
SERVER NOW RUNNING
7. download my server client
-note that this line of code in ScrumptiousResource.java
private static final String DB_URI = "jdbc:postgresql://localhost:5432/ScrumptiousServer";
refferences the name of the server in pgadmin
8. right click run it
9. boot up lab09Client 
10. change this line in Main.java

    //private static String PEOPLE_URI = "http://10.0.2.2:9998/monopoly/players";

to this:

    private static String PEOPLE_URI = "http://10.0.2.2:9998/scrumptious/recipes";

yay!
