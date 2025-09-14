import java.sql.*;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            GamingPlatformDAO dao = new GamingPlatformDAO();
            Scanner sc = new Scanner(System.in);
            while (true) {
                System.out.println("\n--- Gaming Platform Reports ---");
                System.out.println("1. Player Skill Progression");
                System.out.println("2. Most Popular Games by Region");
                System.out.println("3. Tournament Stats");
                System.out.println("4. Virtual Economy Stats");
                System.out.println("5. Player Engagement");
                System.out.println("6. Moderation Activities");
                System.out.println("7. Revenue Stats");
                System.out.println("8. Exit");
                System.out.print("Choose an option: ");
                int choice = sc.nextInt();

                switch (choice) {
                    case 1 -> dao.getPlayerSkillProgression(conn);
                    case 2 -> dao.getPopularGamesByRegion(conn);
                    case 3 -> dao.getTournamentStats(conn);
                    case 4 -> dao.getVirtualEconomyStats(conn);
                    case 5 -> dao.getPlayerEngagementStats(conn);
                    case 6 -> dao.getModerationActivities(conn);
                    case 7 -> dao.getRevenueStats(conn);
                    case 8 -> { System.out.println("Exiting..."); return; }
                    default -> System.out.println("Invalid choice.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
