package test;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import dao.NoticeDAO;
import dao.NoticeDAOImplement;
import vo.NoticeVO;

/**
 * DAO 계층의 메서드를 테스트하기 위한 JUnit 테스트 클래스입니다.
 * 이 클래스는 공지사항 관련 DAO 메서드를 테스트하는 여러 메서드를 포함합니다.
 */
public class TestDAO {
	
	NoticeDAO dao; // NoticeDAO 인터페이스를 구현한 객체

	/**
	 * 테스트 메서드 실행 전에 실행되는 설정 메서드입니다.
	 * 테스트를 수행하기 전에 DAO 객체를 초기화합니다.
	 */
	@Before
	public void before() {
		dao = new NoticeDAOImplement(); // DAO 구현 객체 생성
		System.out.println("test 수행 전"); // 테스트 준비 완료 메시지
	}
	
	/**
	 * 검색 조건에 맞는 총 게시물 개수를 테스트합니다.
	 * 이 메서드는 제목에서 '동하'라는 문자열을 검색하여, 총 개수를 출력합니다.
	 */
	@Test
	public void getSearchTotalCount() {
		int totalCount = dao.getSearchListCount("title", "동하"); // 제목에서 '동하' 검색하여 총 개수 가져오기
		System.out.println("totalCount : " + totalCount); // 총 개수 출력
	}
	
	/**
	 * 전체 공지사항 리스트를 테스트합니다.
	 * 이 메서드는 모든 공지사항을 가져와서 리스트를 출력합니다.
	 */
	// @Test // 이 메서드는 테스트용으로 주석 처리되어 있습니다.
	public void getAllListTest() {
		List<NoticeVO> noticeList = dao.getAllList(); // 전체 공지사항 리스트 가져오기
		System.out.println(noticeList); // 공지사항 리스트 출력
	}
	
	/**
	 * 100개의 공지사항을 작성하는 테스트입니다.
	 * 이 메서드는 공지사항을 반복적으로 작성하여 성공 여부를 출력합니다.
	 */
	// @Test // 이 메서드는 테스트용으로 주석 처리되어 있습니다.
	public void noticeWriteTest() {
		for(int i = 0; i < 100; i++) {
			NoticeVO vo = new NoticeVO(); // 새로운 공지사항 객체 생성
			vo.setNotice_category("공지"); // 공지사항 카테고리 설정
			vo.setNotice_author("MASTER"); // 공지사항 작성자 설정
			vo.setNotice_title("서울에 사시는 김동하 바보 " +i); // 공지사항 제목 설정
			vo.setNotice_content("예?"); // 공지사항 내용 설정
			boolean isSuccess = dao.noticeWrite(vo); // 공지사항 작성 시도
			System.out.println("noticeWriteTest : " + isSuccess); // 작성 성공 여부 출력
		}
	}
	
	/**
	 * 특정 공지사항을 삭제하는 테스트입니다.
	 * 이 메서드는 ID가 1인 공지사항을 삭제하고, 성공 여부를 출력합니다.
	 */
	// @Test // 이 메서드는 테스트용으로 주석 처리되어 있습니다.
	public void deleteDongHaTest() {
		boolean isSuccess = dao.noticeDelete(1); // ID가 1인 공지사항 삭제 시도
		System.out.println("deleteDongHaTest : " + isSuccess); // 삭제 성공 여부 출력
	}
	
	/**
	 * 테스트 메서드 실행 후에 호출되는 정리 메서드입니다.
	 * 테스트 실행 후의 후처리를 담당합니다.
	 */
	@After
	public void after() {
		System.out.println("test 수행 완료 후"); // 테스트 완료 메시지
	}
}
