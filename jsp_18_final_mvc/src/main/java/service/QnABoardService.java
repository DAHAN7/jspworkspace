package service;

import dao.QnABoardDAO;
import jakarta.servlet.http.HttpServletRequest;

public class QnABoardService {
	
	private QnABoardDAO dao = new QnABoardDAO();
	
	/**
	 * @param request - qna_board table 등록할 파라미터 정보
	 * @return boolean - 게시글 등록 성공 여부를 boolean type으로 반환 
	 */
	public boolean boardWrite(HttpServletRequest request) {
		String num = request.getParameter("qna_writer_num");
		String qna_title = request.getParameter("qna_title");
		String qna_content = request.getParameter("qna_content");
		
		int qna_writer_num = Integer.parseInt(num);
		return dao.boardWrite(qna_title, qna_content, qna_writer_num);
	}
	
}












