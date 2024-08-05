package controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.NoticeService;
import service.NoticeServiceImpl;
import util.FactoryUtil;
import vo.NoticeVO;

/**
 * 공지사항 관련 요청 처리
 */
//@WebServlet("*.do")
public class NoticeControllerBackup extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    private NoticeService noticeService = new NoticeServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("NoticeController GET 요청");
        
        String requestURI = req.getRequestURI();        // 전체 요청 경로
        String contextPath = req.getContextPath();      // 프로젝트(context) 경로
        String command = requestURI.substring(contextPath.length());
        System.out.println("요청 : " + command);

        String nextPage = null;

        if (command.equals("/notice.do")) {
            // 공지사항 목록 페이지 요청
        	noticeService.noticeList(req);
            nextPage = "/board/notice/notice_list.jsp";
        } else if (command.equals("/noticeDetail.do")) {
            // 공지사항 상세 페이지 요청
            nextPage = "/board/notice/notice_detail.jsp";
        } else if (command.equals("/noticeWriteForm.do")) {
            // 공지사항 작성 폼 페이지 요청
            nextPage = "/board/notice/notice_write.jsp";
        } else if (command.equals("/noticeUpdateForm.do")) {
            // 공지사항 수정 폼 페이지 요청
            nextPage = "/board/notice/notice_update.jsp";
        } else if (command.equals("/noticeDelete.do")) {
            // 공지사항 삭제 요청
            // 여기서는 별도의 페이지로 이동하지 않으며, 삭제 후 목록으로 리디렉션
            noticeService.noticeDelete(req);
            resp.sendRedirect(contextPath + "/noticeList.do");
            return; // 리디렉션 후 처리 종료
        }

        if (nextPage != null) {
            RequestDispatcher rd = req.getRequestDispatcher(nextPage);
            rd.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("NoticeController POST 요청");

        String command = FactoryUtil.getCommand(req);
        String nextPage = null;

        if (command.equals("noticeWrite.do")) {
            // 공지사항 등록 요청 처리
            boolean isSuccess = noticeService.noticeWrite(req);
            if (isSuccess) {
                req.setAttribute("msg", "공지사항 등록 성공!");
                nextPage = "/board/notice/notice_success.jsp";
            } else {
                req.setAttribute("msg", "공지사항 등록 실패!");
                nextPage = "/board/notice/notice_fail.jsp";
            }
        } else if (command.equals("noticeUpdate.do")) {
            // 공지사항 수정 요청 처리
            boolean isSuccess = noticeService.noticeUpdate(req);
            if (isSuccess) {
                req.setAttribute("msg", "공지사항 수정 성공!");
                nextPage = "/board/notice/notice_success.jsp";
            } else {
                req.setAttribute("msg", "공지사항 수정 실패!");
                nextPage = "/board/notice/notice_fail.jsp";
            }
        } 

        if (nextPage != null) {
            req.getRequestDispatcher(nextPage).forward(req, resp);
        }
    }
}
