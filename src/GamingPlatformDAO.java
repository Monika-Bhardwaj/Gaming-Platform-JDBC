//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;

public class GamingPlatformDAO {

    // 1. Player skill progression and ranking changes over time
    public void getPlayerSkillProgression(Connection conn) {
        String sql = """
            SELECT p.PlayerId, p.Username, ps.Ranking AS CurrentRanking, 
                   prh.Ranking AS PreviousRanking, prh.RecordedAt AS ChangeDate
            FROM Player p
            JOIN PlayerRankingHistory prh ON p.PlayerId = prh.PlayerId
            JOIN PlayerStats ps ON p.PlayerId = ps.PlayerId
            ORDER BY p.PlayerId, prh.RecordedAt DESC;
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("\n--- Player Skill Progression ---");
            while (rs.next()) {
                System.out.printf("Player: %s | Current Rank: %d | Previous Rank: %d | Date: %s\n",
                        rs.getString("Username"), rs.getInt("CurrentRanking"),
                        rs.getInt("PreviousRanking"), rs.getTimestamp("ChangeDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 2. Most popular games and match types by region
    public void getPopularGamesByRegion(Connection conn) {
        String sql = """
            SELECT r.RegionName, g.Title AS GameTitle, mt.MatchTypeName, COUNT(m.MatchId) AS MatchCount
            FROM Matches m
            JOIN Game g ON m.GameId = g.GameId
            JOIN MatchType mt ON m.MatchTypeId = mt.MatchTypeId
            JOIN Region r ON m.RegionId = r.RegionId
            GROUP BY r.RegionName, g.Title, mt.MatchTypeName
            ORDER BY r.RegionName, MatchCount DESC;
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("\n--- Most Popular Games by Region ---");
            while (rs.next()) {
                System.out.printf("Region: %s | Game: %s | Match Type: %s | Matches: %d\n",
                        rs.getString("RegionName"), rs.getString("GameTitle"),
                        rs.getString("MatchTypeName"), rs.getInt("MatchCount"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 3. Tournament participation rates and prize pool distribution
    public void getTournamentStats(Connection conn) {
        String sql = """
            SELECT t.Name AS TournamentName, COUNT(tr.PlayerId) AS Participants, t.PrizePool
            FROM Tournament t
            LEFT JOIN TournamentRegistration tr ON t.TournamentId = tr.TournamentId
            GROUP BY t.TournamentId
            ORDER BY Participants DESC;
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("\n--- Tournament Participation & Prize Pools ---");
            while (rs.next()) {
                System.out.printf("Tournament: %s | Participants: %d | Prize Pool: %.2f\n",
                        rs.getString("TournamentName"), rs.getInt("Participants"), rs.getDouble("PrizePool"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 4. Virtual economy transaction volumes and item valuations
    public void getVirtualEconomyStats(Connection conn) {
        String sql = """
            SELECT i.Name AS ItemName, SUM(vt.Quantity) AS TotalQuantity, AVG(i.BaseValue) AS AvgValue
            FROM VirtualTransaction vt
            JOIN Item i ON vt.ItemBought = i.ItemId
            GROUP BY i.ItemId
            ORDER BY TotalQuantity DESC;
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("\n--- Virtual Economy Stats ---");
            while (rs.next()) {
                System.out.printf("Item: %s | Total Transactions: %d | Avg Value: %.2f\n",
                        rs.getString("ItemName"), rs.getInt("TotalQuantity"), rs.getDouble("AvgValue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 5. Player retention and engagement metrics
    public void getPlayerEngagementStats(Connection conn) {
        String sql = """
            SELECT p.Username, COUNT(ps.SessionId) AS Sessions, 
                   DATEDIFF(MAX(ps.LogoutTime), MIN(ps.LoginTime)) AS ActiveDays
            FROM Player p
            JOIN PlayerSession ps ON p.PlayerId = ps.PlayerId
            GROUP BY p.PlayerId
            ORDER BY Sessions DESC;
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("\n--- Player Retention & Engagement ---");
            while (rs.next()) {
                System.out.printf("Player: %s | Sessions: %d | Active Days: %d\n",
                        rs.getString("Username"), rs.getInt("Sessions"), rs.getInt("ActiveDays"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 6. Cheating detection and account moderation activities
    public void getModerationActivities(Connection conn) {
        String sql = """
            SELECT ma.Id, reporter.Username AS Reporter, player.Username AS Offender,
                   a.ActionName, ma.Reason, ma.Timestamp
            FROM ModerationAction ma
            JOIN Player reporter ON ma.ReporterId = reporter.PlayerId
            JOIN Player player ON ma.PlayerId = player.PlayerId
            JOIN Actions a ON ma.ActionId = a.ActionId
            ORDER BY ma.Timestamp DESC;
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("\n--- Moderation Actions ---");
            while (rs.next()) {
                System.out.printf("Action ID: %d | Reporter: %s | Offender: %s | Action: %s | Reason: %s | Date: %s\n",
                        rs.getInt("Id"), rs.getString("Reporter"), rs.getString("Offender"),
                        rs.getString("ActionName"), rs.getString("Reason"), rs.getTimestamp("Timestamp"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 7. Revenue from virtual item sales and premium subscriptions
    public void getRevenueStats(Connection conn) {
        String sql = """
            SELECT 'Virtual Items' AS Source, SUM(vt.Quantity * i.BaseValue) AS Revenue
            FROM VirtualTransaction vt
            JOIN Item i ON vt.ItemBought = i.ItemId
            UNION ALL
            SELECT 'Subscriptions' AS Source, SUM(sp.Amount) AS Revenue
            FROM Subscription s
            JOIN SubscriptionPacks sp ON s.SubscriptionPackId = sp.SubscriptionPackId;
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("\n--- Revenue Stats ---");
            while (rs.next()) {
                System.out.printf("Source: %s | Revenue: %.2f\n",
                        rs.getString("Source"), rs.getDouble("Revenue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
