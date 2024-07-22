package usedlist;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

// @WebServlet(urlPatterns = {"/loadBooksServlet"}, loadOnStartup = 1)
public class LoadBooksServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public LoadBooksServlet() {
		System.out.println("LoadBooksServlet 생성");
	}

	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bookstore";
	private static final String DB_USER = "your username";
	private static final String DB_PASSWORD = "your password";
	private static final int PAGE_COUNT = 5;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = Integer.parseInt(request.getParameter("page"));
		int startRow = (page - 1) * PAGE_COUNT;

		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
			int totalRecords = getTotalRecords(conn);
			int totalPages = (int) Math.ceil((double) totalRecords / PAGE_COUNT);
			List<Book> books = getBooks(conn, startRow, PAGE_COUNT);

			Gson gson = new Gson();
			JsonObject responseJson = new JsonObject();
			responseJson.add("books", gson.toJsonTree(books));
			responseJson.addProperty("totalPages", totalPages);
			out.print(responseJson.toString());
		} catch (SQLException e) {
			e.printStackTrace();
			out.print("{\"error\": \"데이터베이스 오류 발생: " + e.getMessage() + "\"}");
		} finally {
			out.close();
		}
	}

	private int getTotalRecords(Connection conn) throws SQLException {
		String countSQL = "SELECT COUNT(*) AS count FROM Used_Books WHERE status = '최상'";
		try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(countSQL)) {
			rs.next();
			return rs.getInt("count");
		}
	}

	private List<Book> getBooks(Connection conn, int startRow, int pageCount) throws SQLException {
		String selectSQL = "SELECT * FROM Used_Books WHERE status = '최상' LIMIT ?, ?";
		try (PreparedStatement pstmt = conn.prepareStatement(selectSQL)) {
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageCount);
			try (ResultSet rs = pstmt.executeQuery()) {
				List<Book> books = new ArrayList<>();
				while (rs.next()) {
					Book book = new Book();
					book.setUsedBookId(rs.getInt("used_book_id"));
					book.setDescription(rs.getString("description"));
					book.setPrice(rs.getInt("price"));
					book.setStatus(rs.getString("status"));
					book.setImage(rs.getString("image"));
					books.add(book);
				}
				return books;
			}
		}
	}
}
