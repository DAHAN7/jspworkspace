package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import util.DBCPUtil;
import util.PageMaker;
import util.SearchCriteria;
import vo.NoticeVO;

public class NoticeDAOImplement implements NoticeDAO {

    private Connection conn;
    private Statement stmt;
    private PreparedStatement pstmt;
    private ResultSet resultSet;

    /**
     * 모든 공지사항을 조회하여 반환합니다.
     * 
     * @return ArrayList<NoticeVO> - 공지사항 목록
     */
    @Override
    public ArrayList<NoticeVO> getAllList() {
        ArrayList<NoticeVO> noticeList = new ArrayList<>();
        
        String sql = "SELECT * FROM notice_board ORDER BY notice_num DESC";
        
        conn = DBCPUtil.getConnection();
        
        try {
            stmt = conn.createStatement();
            resultSet = stmt.executeQuery(sql);
            while(resultSet.next()) {
                // ResultSet에서 공지사항 정보를 읽어 NoticeVO 객체를 생성합니다.
                NoticeVO notice = new NoticeVO(
                        resultSet.getInt("notice_num"),
                        resultSet.getString("notice_category"),
                        resultSet.getString("notice_author"),
                        resultSet.getString("notice_title"),
                        resultSet.getString("notice_content"),
                        resultSet.getTimestamp("notice_date")
                );
                noticeList.add(notice); // 공지사항 목록에 추가
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(resultSet, stmt, conn); // 자원 해제
        }
        return noticeList;
    }

    /**
     * 새로운 공지사항을 작성합니다.
     * 
     * @param noticeVO - 작성할 공지사항 정보
     * @return boolean - 작성 성공 여부
     */
    @Override
    public boolean noticeWrite(NoticeVO noticeVO) {
        boolean isSuccess = false;
        
        conn = DBCPUtil.getConnection();
        
        String sql = "INSERT INTO notice_board VALUES(null,?,?,?,?,now())";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, noticeVO.getNotice_category());
            pstmt.setString(2, noticeVO.getNotice_author());
            pstmt.setString(3, noticeVO.getNotice_title());
            pstmt.setString(4, noticeVO.getNotice_content());
            
            int result = pstmt.executeUpdate(); // 삽입 작업 실행
            if(result == 1) {
                isSuccess = true; // 삽입 성공 여부 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(pstmt, conn); // 자원 해제
        }
        return isSuccess;
    }

    /**
     * 공지사항 번호를 통해 해당 공지사항 정보를 조회합니다.
     * 
     * @param notice_num - 조회할 공지사항 번호
     * @return NoticeVO - 공지사항 정보
     */
    @Override
    public NoticeVO getNoticeVO(int notice_num) {
        NoticeVO notice = null;
        
        conn = DBCPUtil.getConnection();
        
        String sql = "SELECT * FROM notice_board WHERE notice_num = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notice_num);
            resultSet = pstmt.executeQuery();
            
            if(resultSet.next()) {
                // ResultSet에서 공지사항 정보를 읽어 NoticeVO 객체를 생성합니다.
                notice = new NoticeVO(
                    resultSet.getInt("notice_num"),
                    resultSet.getString("notice_category"),
                    resultSet.getString("notice_author"),
                    resultSet.getString("notice_title"),
                    resultSet.getString("notice_content"),
                    resultSet.getTimestamp("notice_date")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(resultSet, pstmt, conn); // 자원 해제
        }
        return notice;
    }

    /**
     * 공지사항 정보를 수정합니다.
     * 
     * @param noticeVO - 수정할 공지사항 정보
     * @return boolean - 수정 성공 여부
     */
    @Override
    public boolean noticeUpdate(NoticeVO noticeVO) {
        
        String sql = "UPDATE notice_board SET notice_category = ?, "
                    + "notice_author = ?, "
                    + "notice_title = ?, "
                    + "notice_content = ? "
                    + "WHERE notice_num = ?";
        
        conn = DBCPUtil.getConnection();
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, noticeVO.getNotice_category());
            pstmt.setString(2, noticeVO.getNotice_author());
            pstmt.setString(3, noticeVO.getNotice_title());
            pstmt.setString(4, noticeVO.getNotice_content());
            pstmt.setInt(5, noticeVO.getNotice_num());
            
            int result = pstmt.executeUpdate(); // 업데이트 작업 실행
            if(result == 1) {
                return true; // 수정 성공 여부 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(pstmt, conn); // 자원 해제
        }
        return false;
    }

    /**
     * 공지사항을 삭제합니다.
     * 
     * @param notice_num - 삭제할 공지사항 번호
     * @return boolean - 삭제 성공 여부
     */
    @Override
    public boolean noticeDelete(int notice_num) {
        
        String sql = "DELETE FROM notice_board WHERE notice_num = ?";
        
        conn = DBCPUtil.getConnection();
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notice_num);
            
            int result = pstmt.executeUpdate(); // 삭제 작업 실행
            if(result == 1) {
                return true; // 삭제 성공 여부 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(pstmt, conn); // 자원 해제
        }
        return false;
    }

    /**
     * 공지사항 목록을 페이지 단위로 조회합니다.
     * 
     * @param startRow - 조회할 시작 인덱스
     * @param perPageNum - 한 페이지에 표시할 공지사항 개수
     * @return ArrayList<NoticeVO> - 공지사항 목록
     */
    @Override
    public ArrayList<NoticeVO> getNoticeList(int startRow, int perPageNum) {
        
        ArrayList<NoticeVO> noticeList = new ArrayList<>();
        
        String sql = "SELECT * FROM notice_board ORDER BY notice_num DESC limit ?, ?";
        
        conn = DBCPUtil.getConnection();
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRow);      // 검색할 시작 인덱스
            pstmt.setInt(2, perPageNum);   // 검색할 게시물 개수
            
            resultSet = pstmt.executeQuery();
            
            while(resultSet.next()) {
                // ResultSet에서 공지사항 정보를 읽어 NoticeVO 객체를 생성합니다.
                NoticeVO notice = new NoticeVO(
                    resultSet.getInt("notice_num"),
                    resultSet.getString("notice_category"),
                    resultSet.getString("notice_author"),
                    resultSet.getString("notice_title"),
                    resultSet.getString("notice_content"),
                    resultSet.getTimestamp("notice_date")
                );
                noticeList.add(notice); // 공지사항 목록에 추가
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(resultSet, pstmt, conn); // 자원 해제
        }
        return noticeList;
    }

    /**
     * 전체 공지사항 수를 조회합니다.
     * 
     * @return int - 전체 공지사항 개수
     */
    @Override
    public int getListCount() {
        int listCount = 0;
        
        String sql = "SELECT count(*) AS count FROM notice_board";
        
        conn = DBCPUtil.getConnection();
        
        try {
            stmt = conn.createStatement();
            resultSet = stmt.executeQuery(sql);
            if(resultSet.next()) {
                listCount = resultSet.getInt("count"); // 전체 공지사항 개수 조회
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(resultSet, stmt, conn); // 자원 해제
        }
        return listCount;
    }

    /**
     * 검색 조건에 맞는 공지사항 수를 조회합니다.
     * 
     * @param searchName - 검색 기준 (title 또는 author)
     * @param searchValue - 검색할 값
     * @return int - 검색된 공지사항 개수
     */
    @Override
    public int getSearchListCount(String searchName, String searchValue) {
        int listCount = 0;
        
        conn = DBCPUtil.getConnection();
        
        String sql = "SELECT count(*) FROM notice_board ";
        
        if(searchName.equals("title")){
            sql += "WHERE notice_title LIKE CONCAT('%',?,'%')";
        } else {
            // author
            sql += "WHERE notice_author LIKE CONCAT('%',?,'%')";
        }
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, searchValue);
            
            resultSet = pstmt.executeQuery();
            if(resultSet.next()) {
                listCount = resultSet.getInt(1); // 검색된 공지사항 개수 조회
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(resultSet, pstmt, conn); // 자원 해제
        }
        return listCount;
    }

    /**
     * 검색 조건에 맞는 공지사항 목록을 페이지 단위로 조회합니다.
     * 
     * @param pageMaker - 페이지 관련 정보 및 검색 조건
     * @return ArrayList<NoticeVO> - 검색된 공지사항 목록
     */
    @Override
    public ArrayList<NoticeVO> getSearchNoticeList(PageMaker pageMaker) {
        ArrayList<NoticeVO> noticeList = new ArrayList<>();
        SearchCriteria cri = (SearchCriteria) pageMaker.getCri();
        
        conn = DBCPUtil.getConnection();
        
        String sql = "SELECT * FROM notice_board ";
        
        if(cri.getSearchName().equals("title")) {
            sql += " WHERE notice_title LIKE ? ";
        } else {
            sql += " WHERE notice_author LIKE ? ";
        }
        
        sql += " ORDER BY notice_num DESC limit ?, ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + cri.getSearchValue() + "%"); // 검색 값에 '%'를 추가
            pstmt.setInt(2, cri.getPageStart()); // 페이지 시작 인덱스
            pstmt.setInt(3, cri.getPerPageNum()); // 페이지 당 공지사항 개수
            
            resultSet = pstmt.executeQuery();
            
            while(resultSet.next()) {
                // ResultSet에서 공지사항 정보를 읽어 NoticeVO 객체를 생성합니다.
                noticeList.add(new NoticeVO(
                    resultSet.getInt("notice_num"),
                    resultSet.getString("notice_category"),
                    resultSet.getString("notice_author"),
                    resultSet.getString("notice_title"),
                    resultSet.getString("notice_content"),
                    resultSet.getTimestamp("notice_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(resultSet, pstmt, conn); // 자원 해제
        }
        return noticeList;
    }

}
