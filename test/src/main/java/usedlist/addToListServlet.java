package usedlist;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

@WebServlet("/addToListServlet")
public class addToListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String usedBookId = request.getParameter("usedBookId");

		if (usedBookId != null && !usedBookId.trim().isEmpty()) {
			HttpSession session = request.getSession();
			ArrayList<String> bookList = (ArrayList<String>) session.getAttribute("bookList");

			if (bookList == null) {
				bookList = new ArrayList<>();
			}

			bookList.add(usedBookId);
			session.setAttribute("bookList", bookList);

			response.setContentType("text/plain");
			response.getWriter().write("Book added to list successfully.");
		} else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("Invalid book ID.");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
