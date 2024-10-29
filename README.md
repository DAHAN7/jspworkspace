JSP 웹 애플리케이션 개발 학습 내용 정리 (jspworkspace)
1. 개요
이 저장소는 JSP (JavaServer Pages) 웹 애플리케이션 개발 학습 내용을 정리한 jspworkspace 입니다.
Eclipse IDE 환경에서 개발되었으며, 서블릿, JSP, JDBC, JSTL, MVC 패턴 등 다양한 웹 개발 기술을 사용한 프로젝트와 예제 코드들을 포함합니다.

3. 주요 학습 내용
서블릿 기초: jsp_02_servlet, jsp_03_servlet_life_cycle, jsp_03_servlet_lift_cycle (오타 추정) 등에서 서블릿의 개념, 생명 주기, 요청 처리 방법 등을 학습했습니다.
JSP 기초: jsp_01_first, jsp_04_script_tag, jsp_05_page_directive_tag, jsp_06_include 등에서 JSP 기본 문법, 스크립트릿 태그, 지시어 태그, include 지시어 등을 학습했습니다.
세션 관리: jsp_08_session_cookie, jsp_10_session_application에서 세션, 쿠키를 사용한 사용자 정보 관리 방법을 익혔습니다.
페이지 이동: jsp_09_redirect_forward에서 redirect 방식과 forward 방식의 페이지 이동 방법을 학습했습니다.
데이터베이스 연동: jsp_11_database_mysql, jsp_12guest_book에서 JDBC를 사용하여 MySQL 데이터베이스에 연결하고 데이터를 CRUD (생성, 읽기, 업데이트, 삭제) 하는 방법을 익혔습니다.
액션 태그: jsp_13_action_tag에서 JSP 액션 태그 (useBean, setProperty, getProperty 등)를 사용하는 방법을 학습했습니다.
템플릿 페이지: jsp_14_template_page, jsp_16_model_1_template에서 템플릿 페이지를 사용하여 웹 페이지 레이아웃을 효율적으로 관리하는 방법을 익혔습니다.
EL과 JSTL: jsp_15_EL_JSTL에서 EL (Expression Language)과 JSTL (JSP Standard Tag Library)을 사용하여 JSP 코드를 간결하게 작성하는 방법을 학습했습니다.
MVC 패턴: jsp_18_final_mvc에서 MVC (Model-View-Controller) 패턴을 적용하여 웹 애플리케이션을 구조화하는 방법을 익혔습니다.
파일 업로드/다운로드: jsp_17_file_upload_download에서 파일 업로드 및 다운로드 기능을 구현했습니다.
회원 관리: ImplementInterfacetest, ImplementingAnInterface, ImplementingAnInterface_test 프로젝트에서 회원 가입, 로그인, 쿠키 처리 등 회원 관리 기능을 구현했습니다.
게시판: application_test, application_test_error 프로젝트에서 게시판 기능 (게시글 작성, 목록, 상세보기, 수정, 삭제)을 구현했습니다.
도서 관리: Test_Project 프로젝트에서 도서 등록, 검색, 목록, 업로드 등 도서 관리 기능을 구현했습니다.
그룹 프로젝트: group_project, group_project_dahan에서 팀 협업을 통해 웹 애플리케이션을 개발했습니다. (자세한 내용은 각 프로젝트 폴더 참조)

4. 폴더 구조 설명
.metadata: Eclipse workspace 설정, 플러그인 정보 등을 저장하는 폴더입니다.
.plugins: Eclipse 플러그인 관련 정보 및 설정 저장 폴더입니다.
ImplementInterfacetest ~ group_project_dahan: 각 프로젝트 폴더입니다.
Servers: Tomcat 서버 설정 파일들을 저장하는 폴더입니다.
jsp_01_first ~ jsp_18_final_mvc: JSP 학습 내용을 단계별로 정리한 폴더입니다.
test: 테스트 코드 또는 관련 파일이 포함된 폴더입니다.

5. 개발 환경
IDE: Eclipse
언어: Java, JSP, HTML, CSS, JavaScript
서버: Tomcat 10.1
데이터베이스: MySQL
기타: JSTL, Servlet, JDBC
