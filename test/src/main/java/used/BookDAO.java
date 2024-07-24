package used;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BookDAO {
    private DataSource dataSource;

    public BookDAO() throws NamingException {
        InitialContext ctx = new InitialContext();
        dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/MySQLDB");
    }

    // 도서 추가
    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO Books (title, author, price, image) VALUES (?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setDouble(3, book.getPrice());
            stmt.setString(4, book.getImage());
            stmt.executeUpdate();
        }
    }

    // 도서 조회
    public Book getBookById(int id) throws SQLException {
        String sql = "SELECT * FROM Books WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setPrice(rs.getDouble("price"));
                    book.setImage(rs.getString("image"));
                    return book;
                } else {
                    return null;
                }
            }
        }
    }

    // 도서 업데이트
    public void updateBook(Book book) throws SQLException {
        String sql = "UPDATE Books SET title = ?, author = ?, price = ?, image = ? WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setDouble(3, book.getPrice());
            stmt.setString(4, book.getImage());
            stmt.setInt(5, book.getId());
            stmt.executeUpdate();
        }
    }

    // 도서 삭제
    public void deleteBook(int id) throws SQLException {
        String sql = "DELETE FROM Books WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
