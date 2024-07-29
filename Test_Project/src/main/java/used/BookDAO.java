package used;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BookDAO {
    private DataSource dataSource;
    private static final Logger logger = Logger.getLogger(BookDAO.class.getName());

    public BookDAO() throws NamingException {
        InitialContext ctx = new InitialContext();
        dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/MySQLDB"); 
    }

    // 도서 추가
    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (book_id, title, author, publisher, book_memo, new_old_ebook, price, stock, seller_id, category_overseas, category_age, category_all, book_fileName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getBook_id());
            stmt.setString(2, book.getTitle());
            stmt.setString(3, book.getAuthor());
            stmt.setString(4, book.getPublisher());
            stmt.setString(5, book.getBook_memo());
            stmt.setString(6, book.getNew_old_ebook());
            stmt.setInt(7, book.getPrice());
            stmt.setInt(8, book.getStock());
            stmt.setInt(9, book.getSeller_id());
            stmt.setString(10, book.getCategory_overseas());
            stmt.setString(11, book.getCategory_age());
            stmt.setString(12, book.getCategory_all());
            stmt.setString(13, book.getBook_fileName());
            stmt.executeUpdate();
            logger.log(Level.INFO, "Book added successfully: {0}", book);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding book: {0}", e.getMessage());
            throw e; 
        }
    }

    // 도서 조회
    public Book getBookById(String bookId) throws SQLException {
        String sql = "SELECT * FROM books WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setBook_no(rs.getInt("book_no"));
                    book.setBook_id(rs.getString("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setPublisher(rs.getString("publisher"));
                    book.setBook_memo(rs.getString("book_memo"));
                    book.setNew_old_ebook(rs.getString("new_old_ebook"));
                    book.setPrice(rs.getInt("price"));
                    book.setStock(rs.getInt("stock"));
                    book.setSeller_id(rs.getInt("seller_id"));
                    book.setCategory_overseas(rs.getString("category_overseas"));
                    book.setCategory_age(rs.getString("category_age"));
                    book.setCategory_all(rs.getString("category_all"));
                    book.setBook_fileName(rs.getString("book_fileName"));
                    book.setInsert_day(rs.getTimestamp("insert_day"));
                    logger.log(Level.INFO, "Book retrieved successfully: {0}", book);
                    return book;
                } else {
                    logger.log(Level.INFO, "Book with ID {0} not found", bookId);
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
        String sql = "UPDATE books SET title = ?, author = ?, publisher = ?, book_memo = ?, new_old_ebook = ?, price = ?, stock = ?, seller_id = ?, category_overseas = ?, category_age = ?, category_all = ?, book_fileName = ? WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getPublisher());
            stmt.setString(4, book.getBook_memo());
            stmt.setString(5, book.getNew_old_ebook());
            stmt.setInt(6, book.getPrice());
            stmt.setInt(7, book.getStock());
            stmt.setInt(8, book.getSeller_id());
            stmt.setString(9, book.getCategory_overseas());
            stmt.setString(10, book.getCategory_age());
            stmt.setString(11, book.getCategory_all());
            stmt.setString(12, book.getBook_fileName());
            stmt.setString(13, book.getBook_id());
            stmt.executeUpdate();
            logger.log(Level.INFO, "Book updated successfully: {0}", book);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating book: {0}", e.getMessage());
            throw e; 
        }
    }

    // 도서 삭제
    public void deleteBook(String bookId) throws SQLException {
        String sql = "DELETE FROM books WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bookId);
            stmt.executeUpdate();
            logger.log(Level.INFO, "Book deleted successfully with ID: {0}", bookId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting book: {0}", e.getMessage());
            throw e; 
        }
    }
}
