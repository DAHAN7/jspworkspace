package used;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookDAO {
    private DataSource dataSource;
    private static final Logger logger = Logger.getLogger(BookDAO.class.getName());

    public BookDAO() throws NamingException {
        InitialContext ctx = new InitialContext();
        // 데이터 소스 조회
        dataSource = (DataSource) ctx.lookup("jdbc/MySQLDB");
    }

    // 도서 추가
    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (title, author, publisher, price, description, category, stock, seller_id, image_path, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getPublisher());
            stmt.setInt(4, book.getPrice());
            stmt.setString(5, book.getDescription());
            stmt.setString(6, book.getCategory());
            stmt.setInt(7, book.getStock());
            stmt.setObject(8, book.getSellerId(), java.sql.Types.INTEGER); // Optional
            stmt.setString(9, book.getImagePath());
            stmt.setString(10, book.getStatus());
            stmt.executeUpdate();
            logger.log(Level.INFO, "Book added successfully: {0}", book);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding book: {0}", e.getMessage());
            throw e; 
        }
    }

    // 도서 조회
    public Book getBookById(int id) throws SQLException {
        String sql = "SELECT * FROM books WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setPublisher(rs.getString("publisher"));
                    book.setPrice(rs.getInt("price"));
                    book.setDescription(rs.getString("description"));
                    book.setCategory(rs.getString("category"));
                    book.setStock(rs.getInt("stock"));
                    book.setSellerId(rs.getObject("seller_id", Integer.class)); // Optional
                    book.setImagePath(rs.getString("image_path"));
                    book.setStatus(rs.getString("status"));
                    logger.log(Level.INFO, "Book retrieved successfully: {0}", book);
                    return book;
                } else {
                    logger.log(Level.INFO, "Book with ID {0} not found", id);
                    return null;
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving book: {0}", e.getMessage());
            throw e; 
        }
    }

    // 도서 업데이트
    public void updateBook(Book book) throws SQLException {
        String sql = "UPDATE books SET title = ?, author = ?, publisher = ?, price = ?, description = ?, category = ?, stock = ?, seller_id = ?, image_path = ?, status = ? WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getPublisher());
            stmt.setInt(4, book.getPrice());
            stmt.setString(5, book.getDescription());
            stmt.setString(6, book.getCategory());
            stmt.setInt(7, book.getStock());
            stmt.setObject(8, book.getSellerId(), java.sql.Types.INTEGER); // Optional
            stmt.setString(9, book.getImagePath());
            stmt.setString(10, book.getStatus());
            stmt.setInt(11, book.getId());
            stmt.executeUpdate();
            logger.log(Level.INFO, "Book updated successfully: {0}", book);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating book: {0}", e.getMessage());
            throw e; // Re-throw the exception for the caller to handle
        }
    }

    // 도서 삭제
    public void deleteBook(int id) throws SQLException {
        String sql = "DELETE FROM books WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            logger.log(Level.INFO, "Book deleted successfully with ID: {0}", id);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting book: {0}", e.getMessage());
            throw e; 
        }
    }
}
