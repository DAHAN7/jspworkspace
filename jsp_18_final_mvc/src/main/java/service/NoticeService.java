package service;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import vo.NoticeVO;

/**
 * 게시글 관련 비즈니스 로직을 정의하는 서비스 인터페이스입니다.
 */
public interface NoticeService {
	
	/**
	 * 전체 게시글 목록을 반환합니다. (페이징 처리 없음)
	 * 
	 * @return - 전체 게시글 목록을 포함하는 ArrayList<NoticeVO> 객체
	 */
	ArrayList<NoticeVO> noticeAllList();

	/**
	 * 새 게시글을 등록합니다.
	 * 
	 * @param request - 게시글 작성에 필요한 데이터가 포함된 HttpServletRequest 객체
	 * @return boolean - 게시글 작성 성공 여부 (true: 성공, false: 실패)
	 */
	boolean noticeWrite(HttpServletRequest request);

	/**
	 * 게시글 목록을 반환합니다. (페이징 처리 포함)
	 * 
	 * @param request - 게시글 목록을 호출하기 위한 정보가 포함된 HttpServletRequest 객체
	 *                 - page: 목록 검색 후 request에 리스트 정보 저장 (key name: noticeList)
	 *                 - 페이징 처리를 위한 pageMaker 정보 저장 (key name: pm)
	 * @return ArrayList<NoticeVO> - 페이지에 맞는 게시글 목록
	 */
	ArrayList<NoticeVO> noticeList(HttpServletRequest request);

	/**
	 * 특정 게시글의 상세 정보를 반환합니다.
	 * 
	 * @param request - 한 개의 게시글 상세 보기에 필요한 정보가 포함된 HttpServletRequest 객체
	 *                 - 게시물 번호로 해당 게시글 정보를 조회
	 *                 - 목록 검색 후 request에 게시글 정보 저장 (key name: notice)
	 * @return NoticeVO - 요청된 게시글의 상세 정보
	 */
	NoticeVO noticeDetail(HttpServletRequest request);

	/**
	 * 특정 게시글을 수정합니다.
	 * 
	 * @param request - 게시글 수정에 필요한 데이터가 포함된 HttpServletRequest 객체
	 * @return boolean - 게시글 수정 성공 여부 (true: 성공, false: 실패)
	 */
	boolean noticeUpdate(HttpServletRequest request);

	/**
	 * 특정 게시글을 삭제합니다.
	 * 
	 * @param request - 게시글 삭제에 필요한 데이터가 포함된 HttpServletRequest 객체
	 *                 - 게시글 번호를 포함하여 삭제 요청
	 * @return boolean - 게시글 삭제 성공 여부 (true: 성공, false: 실패)
	 */
	boolean noticeDelete(HttpServletRequest request);
	
	/**
	 * 게시글을 검색하여 목록을 반환합니다.
	 * 
	 * @param request - 검색에 필요한 파라미터가 포함된 HttpServletRequest 객체
	 *                 - searchName: 검색할 필드명
	 *                 - searchValue: 검색할 값
	 *                 - page: 페이지 번호
	 *                 - perPageNum: 페이지당 게시글 수
	 * @return ArrayList<NoticeVO> - 검색 결과로 반환된 게시글 목록
	 */
	ArrayList<NoticeVO> search(HttpServletRequest request);
	
}
