package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.PageMaker;
import vo.NoticeVO;

public class NoticeDAOImpl implements NoticeDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 데이터베이스 연결 설정 메소드
    private void setConnection() {
        try {
            // MySQL JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 데이터베이스 연결
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/digital_jsp", // 데이터베이스 URL
                "digital",                               // 사용자명
                "1234"                                  // 비밀번호
            );
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 자원 해제 메소드
    private void closeResources() {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    public ArrayList<NoticeVO> getAllList() {
        ArrayList<NoticeVO> list = new ArrayList<>();
        String sql = "SELECT * FROM notice_board";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                NoticeVO notice = new NoticeVO();
                notice.setNotice_num(rs.getInt("notice_num"));
                notice.setNotice_category(rs.getString("notice_category"));
                notice.setNotice_author(rs.getString("notice_author"));
                notice.setNotice_title(rs.getString("notice_title"));
                notice.setNotice_content(rs.getString("notice_content"));
                notice.setNotice_date(rs.getDate("notice_date"));
                list.add(notice);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return list;
    }

    @Override
    public boolean noticeWrite(NoticeVO noticeVO) {
        boolean isSuccess = false;
        String sql = "INSERT INTO notice_board (notice_category, notice_author, notice_title, notice_content, notice_date) VALUES (?, ?, ?, ?, NOW())";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, noticeVO.getNotice_category());
            pstmt.setString(2, noticeVO.getNotice_author());
            pstmt.setString(3, noticeVO.getNotice_title());
            pstmt.setString(4, noticeVO.getNotice_content());
            isSuccess = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return isSuccess;
    }

    @Override
    public NoticeVO getNoticeVO(int notice_num) {
        NoticeVO notice = null;
        String sql = "SELECT * FROM notice_board WHERE notice_num = ?";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notice_num);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                notice = new NoticeVO();
                notice.setNotice_num(rs.getInt("notice_num"));
                notice.setNotice_category(rs.getString("notice_category"));
                notice.setNotice_author(rs.getString("notice_author"));
                notice.setNotice_title(rs.getString("notice_title"));
                notice.setNotice_content(rs.getString("notice_content"));
                notice.setNotice_date(rs.getDate("notice_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return notice;
    }

    @Override
    public boolean noticeUpdate(NoticeVO noticeVO) {
        boolean isSuccess = false;
        String sql = "UPDATE notice_board SET notice_category = ?, notice_author = ?, notice_title = ?, notice_content = ?, notice_date = NOW() WHERE notice_num = ?";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, noticeVO.getNotice_category());
            pstmt.setString(2, noticeVO.getNotice_author());
            pstmt.setString(3, noticeVO.getNotice_author());
            pstmt.setString(4, noticeVO.getNotice_content());
            pstmt.setInt(5, noticeVO.getNotice_num());
            isSuccess = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return isSuccess;
    }

    @Override
    public boolean noticeDelete(int notice_num) {
        boolean isSuccess = false;
        String sql = "DELETE FROM notice_board WHERE notice_num = ?";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notice_num);
            isSuccess = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return isSuccess;
    }

    @Override
    public ArrayList<NoticeVO> getNoticeList(int startRow, int perPageNum) {
        ArrayList<NoticeVO> list = new ArrayList<>();
        String sql = "SELECT * FROM notice_board LIMIT ?, ?";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, perPageNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                NoticeVO notice = new NoticeVO();
                notice.setNotice_num(rs.getInt("notice_num"));
                notice.setNotice_category(rs.getString("notice_category"));
                notice.setNotice_author(rs.getString("notice_author"));
                notice.setNotice_title(rs.getString("notice_title"));
                notice.setNotice_content(rs.getString("notice_content"));
                notice.setNotice_date(rs.getDate("notice_date"));
                list.add(notice);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return list;
    }

    @Override
    public int getListCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM notice_board";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return count;
    }

    @Override
    public int getSearchListCount(String searchName, String searchValue) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM notice_board WHERE " + searchName + " LIKE ?";
        setConnection(); // 연결 설정
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + searchValue + "%");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(); // 자원 해제
        }
        return count;
    }

	@Override
	public ArrayList<NoticeVO> getSearchNoticeList(PageMaker pm) {
		return null;
	}

}
