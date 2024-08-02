package service;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import vo.NoticeVO;
import dao.NoticeDAO;
import dao.NoticeDAOImpl;
import util.Criteria;
import util.PageMaker;

public class NoticeServiceImpl implements NoticeService {

    private NoticeDAO noticeDAO = new NoticeDAOImpl();

    @Override
    public ArrayList<NoticeVO> noticeAllList() {
        // 데이터베이스에서 모든 공지사항을 조회하여 반환
        return noticeDAO.getAllList();
    }

    @Override
    public boolean noticeWrite(HttpServletRequest request) {
        // 요청 파라미터에서 공지사항 정보를 가져와 NoticeVO 객체를 생성하고 설정
        String noticeCategory = request.getParameter("noticeCategory");
        String noticeAuthor = request.getParameter("noticeAuthor");
        String noticeTitle = request.getParameter("noticeTitle");
        String noticeContent = request.getParameter("noticeContent");

        NoticeVO notice = new NoticeVO();
        notice.setNotice_category(noticeCategory);
        notice.setNotice_author(noticeAuthor);
        notice.setNotice_title(noticeTitle);
        notice.setNotice_content(noticeContent);
        notice.setNotice_date(new java.util.Date());

        // 데이터베이스에 공지사항 저장
        return noticeDAO.noticeWrite(notice);
    }

    @Override
    public ArrayList<NoticeVO> noticeList(HttpServletRequest request) {
        // 요청 파라미터에서 페이지 번호와 페이지당 게시물 수를 가져옴
    	String pageStr = request.getParameter("page");
        int page = 1 ;
        if(pageStr != null) {
        	page = Integer.parseInt(pageStr);
        }
        
        int perPageNum = 10;
        if(request.getParameter("perPageNum") != null) {
        	perPageNum = Integer.parseInt(request.getParameter("perPageNum"));
        }
        
        // Criteria와 PageMaker 객체를 생성하여 페이징 처리
        Criteria criteria = new Criteria(page, perPageNum);
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(criteria);
        pageMaker.setTotalCount(noticeDAO.getListCount());
        pageMaker.calcPaging();

        // 페이징 정보와 공지사항 목록을 request에 저장
        request.setAttribute("pm", pageMaker);

        int startRow = criteria.getPageStart();
        ArrayList<NoticeVO> noticeList = noticeDAO.getNoticeList(startRow, perPageNum);
        request.setAttribute("noticeList", noticeList);

        return noticeList;
    }

    @Override
    public NoticeVO noticeDetail(HttpServletRequest request) {
        // 요청 파라미터에서 게시글 번호를 가져와 해당 게시글의 상세 정보를 조회
        int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
        return noticeDAO.getNoticeVO(noticeNum);
    }

    @Override
    public boolean noticeUpdate(HttpServletRequest request) {
        // 요청 파라미터에서 공지사항 정보를 가져와 NoticeVO 객체를 생성하고 수정
        int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
        String noticeCategory = request.getParameter("noticeCategory");
        String noticeAuthor = request.getParameter("noticeAuthor");
        String noticeTitle = request.getParameter("noticeTitle");
        String noticeContent = request.getParameter("noticeContent");

        NoticeVO notice = new NoticeVO();
        notice.setNotice_num(noticeNum);
        notice.setNotice_category(noticeCategory);
        notice.setNotice_author(noticeAuthor);
        notice.setNotice_title(noticeTitle);
        notice.setNotice_content(noticeContent);
        notice.setNotice_date(new java.util.Date());

        // 데이터베이스에서 공지사항 수정
        return noticeDAO.noticeUpdate(notice);
    }

    @Override
    public boolean noticeDelete(HttpServletRequest request) {
        // 요청 파라미터에서 게시글 번호를 가져와 해당 게시글 삭제
        int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
        return noticeDAO.noticeDelete(noticeNum);
    }

    @Override
    public ArrayList<NoticeVO> search(HttpServletRequest request) {
        // 요청 파라미터에서 검색 조건과 페이지 정보를 가져옴
        String searchName = request.getParameter("searchName");
        String searchValue = request.getParameter("searchValue");
        int page = Integer.parseInt(request.getParameter("page"));
        int perPageNum = Integer.parseInt(request.getParameter("perPageNum"));

        // Criteria와 PageMaker 객체를 생성하여 페이징 처리
        Criteria criteria = new Criteria(page, perPageNum);
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(criteria);
        pageMaker.setTotalCount(noticeDAO.getSearchListCount(searchName, searchValue));
        pageMaker.calcPaging();

        // 페이징 정보와 검색된 공지사항 목록을 request에 저장
        request.setAttribute("pm", pageMaker);

        return noticeDAO.getSearchNoticeList(pageMaker);
    }
}
