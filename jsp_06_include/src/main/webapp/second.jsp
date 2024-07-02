<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!-- second.jsp -->
<!-- include file 의 절대경로는 webapp -->
<%@ include file="/common/header.jsp" %><!-- /common/header.jsp파일을 포함하며 헤더를 삽입 -->
<section>
	<h2>SECOND JSP</h2><!-- 섹션 제목 -->
	<article>
		<textarea>Hello World!</textarea><!-- "Hello World!"텍스트를 포함한 텍스트 영역 -->
	</article>
</section>


<%@ include file="/common/footer.jsp" %><!-- /common/footer.jsp파일을 포함하여 푸터를 삽입 -->