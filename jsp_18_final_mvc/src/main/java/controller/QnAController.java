package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.QnABoardService;
import util.FactoryUtil;

// Question And Answer Board Controller
@WebServlet("*.qna")
public class QnAController extends HttpServlet{

	private static final long serialVersionUID = -1837555412460714904L;
	
	QnABoardService service = new QnABoardService();

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = FactoryUtil.getCommand(request);
		System.out.println("QnAController 요청 처리 : " + command);
		
		String nextPage = null;
		
		if(command.equals("boardList.qna")) {
			nextPage = "/board/qna/qna_list.jsp";
		}
		
		if(command.equals("boardWrite.qna")) {
			nextPage = "/board/qna/qna_write.jsp";
		}
		
		if(command.equals("boardWriteSubmit.qna")) {
			// 게시글 등록 요청 처리
			boolean isSuccess = service.boardWrite(request);
			if(isSuccess) {
				response.sendRedirect("boardList.qna");
				return;
			}else {
				request.setAttribute("msg", "게시글 등록 실패");
				nextPage="/board/qna/qna_write.jsp";
			}
		}
		
		if(nextPage != null) {
			request.getRequestDispatcher(nextPage).forward(request, response);
		}else {
			response.sendError(404, "처리 할 수 없는 요청 입니다.");
		}
	}
	
	

}