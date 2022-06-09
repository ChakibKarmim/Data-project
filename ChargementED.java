import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ChargementED {

    public static void main( String args[] ) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet result = null;
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:comptoire.db");
            String sql = "SELECT * FROM Produits";
            stmt = conn.prepareStatement(sql);
            result = stmt.executeQuery();
            while(result.next())
            {
                int RefProduit = result.getInt("RefProduit");
                String  NomDuProduit = result.getString("NomDuProduit");
                int CodeCatégorie  = result.getInt("CodeCatégorie");
                String  QuantiteParUnite = result.getString("QuantiteParUnite");
                int PrixUnitaire = result.getInt("salary");
                int UniteEnStock = result.getInt("UniteEnStock");
                int NiveauDeRapprovisionnement = result.getInt("NiveauDeRapprovisionnement");
                int i = 1 ;
                System.out.println(" " + i +  " |" + RefProduit + " |" +  NomDuProduit + " |" + CodeCatégorie + " |" + QuantiteParUnite + " |" + PrixUnitaire + " |" + UniteEnStock + " |" + NiveauDeRapprovisionnement);
                i++ ;
            }
        } catch ( Exception e ) {
            System.err.println( e.getClass().getName() + ": " + e.getMessage() );
            System.exit(0);
        }
        System.out.println("Opened database successfully");
    }

}
