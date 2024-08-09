package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.Criteria;
import util.DBCPUtil;
import vo.BoardVO;

public class QnABoardDAO {
    
    // 데이터베이스와의 연결을 관리하는 객체
    private Connection conn;
    
    // 미리 컴파일된 SQL 문을 실행하는 객체
    private PreparedStatement pstmt;
    
    // 저장 프로시저를 호출하는 객체
    private CallableStatement cstmt;
    
    // SQL 쿼리 결과를 저장하고 처리하는 객체
    private ResultSet rs;
    
    /**
     * 게시글 작성 메서드
     * 
     * @param qna_title  게시글 제목
     * @param qna_content  게시글 내용
     * @param qna_writer_num  작성자 번호
     * @return boolean  게시글 작성 성공 여부
     */
    public boolean boardWrite(String qna_title, String qna_content, int qna_writer_num) {
        
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // 게시글을 삽입하는 SQL 쿼리
        String sql = " INSERT INTO v_qna_board(qnaTitle,qnaContent,qnaWriterNum) "
                    + " VALUES(?,?,?)";
        
        try {
            // 트랜잭션 시작
            conn.setAutoCommit(false);            
            
            // PreparedStatement에 SQL 할당 및 파라미터 설정
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, qna_title);
            pstmt.setString(2, qna_content);
            pstmt.setInt(3, qna_writer_num);
            
            // 게시글 삽입 실행
            int result = pstmt.executeUpdate();
            
            if(result == 1) {
                // 삽입된 게시글의 qnaReRef 필드를 LAST_INSERT_ID()로 업데이트
                sql = " UPDATE v_qna_board SET qnaReRef = LAST_INSERT_ID() "
                    + " WHERE qnaNum = LAST_INSERT_ID() ";
                pstmt = conn.prepareStatement(sql);
                result = pstmt.executeUpdate();
                if(result == 1) {
                    // 모든 작업이 성공했을 경우 커밋
                    conn.commit();
                    return true;
                }
            }
            
            // 작업 실패 시 롤백
            conn.rollback();
            
        } catch (SQLException e) {
            try {
                // 예외 발생 시 롤백
                conn.rollback();
            } catch (SQLException e1) {}
        } finally {
            // 리소스 해제 및 자동 커밋 복구
            DBCPUtil.close(pstmt, conn);
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {}
        }
        return false;
    }

    /**
     * 모든 게시글 목록을 가져오는 메서드
     * 
     * @return ArrayList<BoardVO>  게시글 목록
     */
    public ArrayList<BoardVO> getBoardAllList() {
        ArrayList<BoardVO> list = new ArrayList<>();
        
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // 게시글들을 qnaReRef 기준 내림차순, qnaReSeq 기준 오름차순으로 정렬하는 SQL 쿼리
        String sql = "SELECT * FROM v_qna_board ORDER BY qnaReRef DESC, qnaReSeq ASC";
        
        try {
            // PreparedStatement에 SQL 할당
            pstmt = conn.prepareStatement(sql);
            
            // SQL 쿼리 실행
            rs = pstmt.executeQuery();
            
            // ResultSet에서 데이터를 가져와 BoardVO 객체로 변환 후 리스트에 추가
            while(rs.next()) {
                BoardVO board = getBoardVO(rs);
                list.add(board);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            // 리소스 해제
            DBCPUtil.close(rs, pstmt, conn);
        }
        
        return list;
    } 

    /**
     * 특정 게시글 번호로 게시글을 가져오는 메서드
     * 
     * @param qnaNum  게시글 번호
     * @return BoardVO  게시글 정보
     */
    public BoardVO getBoardVO(int qnaNum) {
        BoardVO board = null;
        
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // 특정 게시글 번호로 데이터를 조회하는 SQL 쿼리
        String sql = "SELECT * FROM v_qna_board WHERE qnaNum = ?";
        
        try {
            // PreparedStatement에 SQL 할당 및 파라미터 설정
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, qnaNum);
            
            // SQL 쿼리 실행
            rs = pstmt.executeQuery();
            if(rs.next()) {
                // 조회된 데이터로 BoardVO 객체 생성
                board = getBoardVO(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            DBCPUtil.close(rs, pstmt, conn);
        }
        return board;
    }
    
    /**
     * ResultSet으로부터 BoardVO 객체를 생성하는 메서드
     * 
     * @param rs  SQL 쿼리 결과
     * @return BoardVO  게시글 정보 객체
     * @throws SQLException  SQL 오류 발생 시 예외 처리
     */
    private BoardVO getBoardVO(ResultSet rs) throws SQLException {
        BoardVO board = new BoardVO();
        board.setQnaNum(rs.getInt("qnaNum"));
        board.setQnaName(rs.getString("qnaName"));
        board.setQnaTitle(rs.getString("qnaTitle"));
        board.setQnaContent(rs.getString("qnaContent"));
        board.setQnaWriterNum(rs.getInt("qnaWriterNum"));
        board.setQnaReadCount(rs.getInt("qnaReadCount"));
        board.setQnaDate(rs.getTimestamp("qnaDate"));
        board.setQnaReRef(rs.getInt("qnaReRef")); // 원본 글 번호 추가
        board.setQnaReSeq(rs.getInt("qnaReSeq")); // 답변 글 정렬 번호 추가
        board.setQnaReLev(rs.getInt("qnaReLev")); // 답변 글 view level 번호 추가
        board.setQnaDelete(rs.getString("qnaDelete")); // 게시글 삭제 여부 추가
        return board;
    }

    /**
     * 게시글 수정 메서드
     * 
     * @param board  수정할 게시글 정보를 담고 있는 BoardVO 객체
     * @return boolean  게시글 수정 성공 여부
     */
    public boolean boardUpdate(BoardVO board) {
        
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // 게시글 제목과 내용을 수정하는 SQL 쿼리
        String sql = "UPDATE v_qna_board SET "
                    + " qnaTitle = ? , "
                    + " qnaContent = ? "
                    + " WHERE qnaNum = ? AND qnaWriterNum = ?";
        
        try {
            // PreparedStatement에 SQL 할당 및 파라미터 설정
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, board.getQnaTitle());
            pstmt.setString(2, board.getQnaContent());
            pstmt.setInt(3, board.getQnaNum());
            pstmt.setInt(4, board.getQnaWriterNum());
            
            // SQL 실행 후 결과가 1이면 수정 성공
            if(pstmt.executeUpdate() == 1) return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            DBCPUtil.close(pstmt, conn);
        }
        
        return false;
    }

    /**
     * 게시글 삭제 메서드
     * 
     * @param qnaNum  삭제할 게시글 번호
     * @return boolean  게시글 삭제 성공 여부
     */
    public boolean boardDelete(int qnaNum) {
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // DELETE 대신 저장 프로시저를 호출하여 게시글 삭제
        String sql = "CALL deleteBoard(?)";
        
        try {
            // CallableStatement에 SQL 할당 및 파라미터 설정
            cstmt = conn.prepareCall(sql);
            cstmt.setInt(1, qnaNum);
            
            // 저장 프로시저 실행 후 결과가 1이면 삭제 성공
            if(cstmt.executeUpdate() == 1) {
                return true;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            DBCPUtil.close(cstmt, conn);
        }
        
        return false;
    }

    /**
     * 답변 글 작성 메서드
     * 
     * @param vo  답변 글 정보를 담고 있는 BoardVO 객체
     */
    public void boardReply(BoardVO vo) {
        
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        try {
            // 기존 답변 글 순서 조정 SQL
            String seqSql = "UPDATE v_qna_board SET qnaReSeq = qnaReSeq + 1 "
                        + " WHERE qnaReRef = ? AND qnaReSeq > ?";
            
            // 트랜잭션 시작
            conn.setAutoCommit(false);
            
            // PreparedStatement에 SQL 할당 및 파라미터 설정
            pstmt = conn.prepareStatement(seqSql);
            pstmt.setInt(1, vo.getQnaReRef());
            pstmt.setInt(2, vo.getQnaReSeq());
            
            // 기존 답변 글 순서 업데이트 실행
            pstmt.executeUpdate();
            
            // 새로운 답변 글 삽입 SQL
            String sql = "INSERT INTO v_qna_board("
                    + "qnaTitle, qnaContent, qnaWriterNum, qnaReRef, qnaReSeq, qnaReLev) "
                        + " VALUES(?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getQnaTitle());
            pstmt.setString(2, vo.getQnaContent());
            pstmt.setInt(3, vo.getQnaWriterNum());
            pstmt.setInt(4, vo.getQnaReRef());
            pstmt.setInt(5, vo.getQnaReSeq() + 1);
            pstmt.setInt(6, vo.getQnaReLev() + 1);
            
            // 새로운 답변 글 삽입 실행
            pstmt.executeUpdate();
            
            // 트랜잭션 커밋
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // 예외 발생 시 롤백
                conn.rollback();
            } catch (SQLException e1) {}
        } finally {
            try {
                // 자동 커밋 복구
                conn.setAutoCommit(true);
            } catch (SQLException e) {}
            
            // 리소스 해제
            DBCPUtil.close(pstmt, conn);
        }
    }

    /**
     * 페이지네이션을 적용하여 게시글 목록을 가져오는 메서드
     * 
     * @param cri  페이지네이션 정보가 담긴 Criteria 객체
     * @return ArrayList<BoardVO>  게시글 목록
     */
    public ArrayList<BoardVO> getBoardList(Criteria cri) {
        ArrayList<BoardVO> boardList = new ArrayList<>();
        
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // 페이지네이션 적용하여 게시글 목록을 조회하는 SQL 쿼리
        String sql = "SELECT * FROM v_qna_board "
                    + "ORDER BY qnaReRef DESC, qnaReSeq ASC limit ?, ?";
        
        try {
            // PreparedStatement에 SQL 할당 및 파라미터 설정
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, cri.getPageStart());            // 검색 시작 인덱스 번호
            pstmt.setInt(2, cri.getPerPageNum());           // 검색할 게시글 개수
            
            // SQL 쿼리 실행
            rs = pstmt.executeQuery();
            
            // ResultSet에서 데이터를 가져와 BoardVO 객체로 변환 후 리스트에 추가
            while(rs.next()) {
                BoardVO board = getBoardVO(rs);
                boardList.add(board);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            DBCPUtil.close(rs, pstmt, conn);
        }
        
        return boardList;
    }

    /**
     * 게시글 총 개수를 가져오는 메서드
     * 
     * @return int  게시글 총 개수
     */
    public int getListCount() {
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // 전체 게시글 수를 조회하는 SQL 쿼리
        String sql = "SELECT count(*) FROM v_qna_Board";
        
        try {
            // PreparedStatement에 SQL 할당
            pstmt = conn.prepareStatement(sql);
            
            // SQL 쿼리 실행
            rs = pstmt.executeQuery();
            
            // 결과 값이 있을 경우, 해당 값을 반환
            if(rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            DBCPUtil.close(rs, pstmt, conn);
        }
        
        return 0;
    }

    /**
     * 특정 게시글의 조회수를 1 증가시키는 메서드
     * 
     * @param qnaNum  조회수를 증가시킬 게시글 번호
     */
    public void updateReadCount(int qnaNum) {
        // 데이터베이스 연결 가져오기
        conn = DBCPUtil.getConnection();
        
        // 특정 게시글의 조회수를 1 증가시키는 SQL 쿼리
        String sql = "UPDATE v_qna_board SET qnaReadCount = qnaReadCount + 1 "
                    + " WHERE qnaNum = ?";
        
        try {
            // PreparedStatement에 SQL 할당 및 파라미터 설정
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, qnaNum);
            
            // SQL 실행
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            DBCPUtil.close(pstmt, conn);
        }
    }
}
