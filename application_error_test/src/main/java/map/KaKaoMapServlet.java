package map;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.FactoryUtil;

/**
 * Servlet implementation class KaKaoMapServlet
 */
@WebServlet("/KaKaoMap")
public class KaKaoMapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FactoryUtil.nextPage(request, response, "/map/kakaoMap.jsp");
	}


}
