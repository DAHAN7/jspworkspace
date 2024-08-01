package dao;

import dto.MemberDTO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAOImpl implements MemberDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/digital_jsp";
    private static final String JDBC_USER = "digital";
    private static final String JDBC_PASSWORD = "1234";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws Exception {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    @Override
    public boolean memberJoin(MemberDTO member) {
        String sql = "INSERT INTO tbl_member (id, pass, name, addr, phone) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPass());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getAddr());
            pstmt.setString(5, member.getPhone());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public MemberDTO memberLogin(String id, String pass) {
        String sql = "SELECT * FROM tbl_member WHERE id = ? AND pass = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);
            pstmt.setString(2, pass);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new MemberDTO(
                        rs.getInt("num"),
                        rs.getString("id"),
                        rs.getString("pass"),
                        rs.getString("name"),
                        rs.getString("addr"),
                        rs.getString("phone")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean memberUpdate(MemberDTO member) {
        String sql = "UPDATE tbl_member SET pass = ?, name = ?, addr = ?, phone = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, member.getPass());
            pstmt.setString(2, member.getName());
            pstmt.setString(3, member.getAddr());
            pstmt.setString(4, member.getPhone());
            pstmt.setString(5, member.getId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMember(int num) {
        String sql = "DELETE FROM tbl_member WHERE num = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, num);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public MemberDTO getMemberById(String id) {
        String sql = "SELECT * FROM tbl_member WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new MemberDTO(
                        rs.getInt("num"),
                        rs.getString("id"),
                        rs.getString("pass"),
                        rs.getString("name"),
                        rs.getString("addr"),
                        rs.getString("phone")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
