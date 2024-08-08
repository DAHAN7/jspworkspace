package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBCPUtil;
import vo.BoardVO;

public class QnABoardDAO {
    
    private Connection conn;
    private PreparedStatement pstmt;
    private CallableStatement cstmt;
    private ResultSet rs;
    
    /**
     * 게시글을 새로 작성합니다.
     * 
     * @param qna_title - 게시글 제목
     * @param qna_content - 게시글 내용
     * @param qna_writer_num - 게시글 작성자 번호
     * @return boolean - 게시글 작성 성공 여부
     */
    public boolean boardWrite(String qna_title, String qna_content, int qna_writer_num) {
        
        conn = DBCPUtil.getConnection(); // 데이터베이스 연결
        String sql = "INSERT INTO v_qna_board(qnaTitle, qnaContent, qnaWriterNum) VALUES(?, ?, ?)";
        
        try {
            conn.setAutoCommit(false); // 트랜잭션 시작
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, qna_title);
            pstmt.setString(2, qna_content);
            pstmt.setInt(3, qna_writer_num);
            
            int result = pstmt.executeUpdate(); // 게시글 삽입
            
            if(result == 1) {
                // 삽입된 게시글의 ID를 가져와서 해당 게시글의 qnaReRef를 업데이트
                sql = "UPDATE v_qna_board SET qnaReRef = LAST_INSERT_ID() WHERE qnaNum = LAST_INSERT_ID()";
                pstmt = conn.prepareStatement(sql);
                result = pstmt.executeUpdate();
                
                if(result == 1) {
                    conn.commit(); // 트랜잭션 커밋
                    return true;
                }
            }
            
            conn.rollback(); // 트랜잭션 롤백
            
        } catch (SQLException e) {
            try {
                conn.rollback(); // 예외 발생 시 롤백
            } catch (SQLException e1) {}
        } finally {
            DBCPUtil.close(pstmt, conn); // 자원 해제
            try {
                conn.setAutoCommit(true); // 트랜잭션 모드 복구
            } catch (SQLException e) {}
        }
        return false;
    } // end boardWrite method

    /**
     * 모든 게시글 목록을 조회하여 반환합니다.
     * 
     * @return ArrayList<BoardVO> - 게시글 목록
     */
    public ArrayList<BoardVO> getBoardAllList() {
        ArrayList<BoardVO> list = new ArrayList<>();
        
        conn = DBCPUtil.getConnection(); // 데이터베이스 연결
        
        String sql = "SELECT * FROM v_qna_board ORDER BY qnaReRef DESC, qnaReSeq ASC";
        
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery(); // 쿼리 실행
            
            while(rs.next()) {
                BoardVO board = getBoardVO(rs); // ResultSet에서 BoardVO 객체 생성
                list.add(board);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(rs, pstmt, conn); // 자원 해제
        }
        
        return list;
    } // end getBoardAllList method

    /**
     * 게시글 번호를 통해 해당 게시글 정보를 조회합니다.
     * 
     * @param qnaNum - 검색할 게시글 번호
     * @return BoardVO - 검색된 게시글 정보
     */
    public BoardVO getBoardVO(int qnaNum) {
        BoardVO board = null;
        
        conn = DBCPUtil.getConnection(); // 데이터베이스 연결
        String sql = "SELECT * FROM v_qna_board WHERE qnaNum = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, qnaNum);
            rs = pstmt.executeQuery(); // 쿼리 실행
            if(rs.next()) {
                board = getBoardVO(rs); // ResultSet에서 BoardVO 객체 생성
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(rs, pstmt, conn); // 자원 해제
        }
        return board;
    }

    /**
     * ResultSet에서 BoardVO 객체를 생성합니다.
     * 
     * @param rs - ResultSet 객체
     * @return BoardVO - 생성된 BoardVO 객체
     * @throws SQLException - SQL 예외
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
        board.setQnaReRef(rs.getInt("qnaReRef")); // 원본 글 번호
        board.setQnaReSeq(rs.getInt("qnaReSeq")); // 답변 글 정렬 번호
        return board;
    }

    /**
     * 게시글 정보를 업데이트합니다.
     * 
     * @param board - 수정할 게시글 정보를 담고 있는 BoardVO 객체
     * @return boolean - 게시글 수정 성공 여부
     */
    public boolean boardUpdate(BoardVO board) {
        
        conn = DBCPUtil.getConnection(); // 데이터베이스 연결
        
        String sql = "UPDATE v_qna_board SET qnaTitle = ?, qnaContent = ? WHERE qnaNum = ? AND qnaWriterNum = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, board.getQnaTitle());
            pstmt.setString(2, board.getQnaContent());
            pstmt.setInt(3, board.getQnaNum());
            pstmt.setInt(4, board.getQnaWriterNum());
            
            if(pstmt.executeUpdate() == 1) return true; // 업데이트 성공 여부 반환
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(pstmt, conn); // 자원 해제
        }
        
        return false;
    }

    /**
     * 게시글을 삭제합니다.
     * 
     * @param qnaNum - 삭제할 게시글 번호
     * @return boolean - 게시글 삭제 성공 여부
     */
    public boolean boardDelete(int qnaNum) {
        conn = DBCPUtil.getConnection(); // 데이터베이스 연결
        
        String sql = "CALL deleteBoard(?)"; // 저장 프로시저 호출
        
        try {
            cstmt = conn.prepareCall(sql);
            cstmt.setInt(1, qnaNum);
            
            if(cstmt.executeUpdate() == 1) {
                return true; // 삭제 성공 여부 반환
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBCPUtil.close(cstmt, conn); // 자원 해제
        }
        
        return false;
    }

    /**
     * 게시글에 대한 답변을 등록합니다.
     * 
     * @param vo - 답변글 등록에 필요한 파라미터 정보가 담긴 BoardVO 객체
     */
    public void boardReply(BoardVO vo) {
        
        conn = DBCPUtil.getConnection(); // 데이터베이스 연결
        
        try {
            // 답변글의 정렬 번호를 업데이트
            String seqSql = "UPDATE v_qna_board SET qnaReSeq = qnaReSeq + 1 WHERE qnaReRef = ? AND qnaReSeq > ?";
            conn.setAutoCommit(false); // 트랜잭션 시작
            
            pstmt = conn.prepareStatement(seqSql);
            pstmt.setInt(1, vo.getQnaReRef());
            pstmt.setInt(2, vo.getQnaReSeq());
            
            pstmt.executeUpdate();
            
            // 답변글을 새로 삽입
            String sql = "INSERT INTO v_qna_board(qnaTitle, qnaContent, qnaWriterNum, qnaReRef, qnaReSeq) VALUES(?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getQnaTitle());
            pstmt.setString(2, vo.getQnaContent());
            pstmt.setInt(3, vo.getQnaWriterNum());
            pstmt.setInt(4, vo.getQnaReRef());
            pstmt.setInt(5, vo.getQnaReSeq() + 1);
            
            pstmt.executeUpdate();
            
            conn.commit(); // 트랜잭션 커밋
        } catch (SQLException e) {
            try {
                conn.rollback(); // 예외 발생 시 롤백
            } catch (SQLException e1) {}
        } finally {
            try {
                conn.setAutoCommit(true); // 트랜잭션 모드 복구
            } catch (SQLException e) {}
            DBCPUtil.close(pstmt, conn); // 자원 해제
        }
    }
}
