<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../common/header.jsp" />
<section>
    <table class="list">
        <tr>
            <th colspan="4">
                <h1>공지사항</h1>
            </th>
        </tr>
        <tr>
            <th colspan=4>
                <form action="noticeSearch.do" method="GET">
                    <select name="searchName">
                        <option value="author">작성자</option>
                        <option value="title">제목</option>    
                    </select>
                    <input type="text" name="searchValue"/>
                    <input type="submit" value="검색"/>
                </form>
                <c:if test="${member.id eq 'admin'}">
                    <a href="noticeWriteForm.do">공지글 작성</a>
                </c:if>
            </th>
        </tr>
        <tr>
            <td>글번호</td>
            <td>제목</td>
            <td>작성자</td>
            <td>작성일</td>
        </tr>
        <c:choose>
            <c:when test="${!empty noticeList}">
                <c:forEach var="n" items="${noticeList}">
                    <tr>
                        <td>${n.notice_num}</td>
                        <td>
                            <a href="noticeDetail.do?notice_num=${n.notice_num}">
                            [${n.notice_category}] ${n.notice_title}
                            </a>
                        </td>
                        <td>${n.notice_author}</td>
                        <td><fmt:formatDate value="${n.notice_date}" pattern="yyyy-MM-dd"/></td>    
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4">등록된 게시물이 없습니다.</td>
                </tr>
            </c:otherwise>            
        </c:choose>
        <tr>
            <td colspan=4>
                <div class="pageWrap">
                    <c:if test="${pageMaker.prev}">
                        <a href="list.do?page=${pageMaker.startPage - 1}">이전</a>
                    </c:if>
                    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="i">
                        <c:choose>
                            <c:when test="${i == pageMaker.page}">
                                <strong>${i}</strong>
                            </c:when>
                            <c:otherwise>
                                <a href="list.do?page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pageMaker.next}">
                        <a href="list.do?page=${pageMaker.endPage + 1}">다음</a>
                    </c:if>
                </div>
            </td>
        </tr>
    </table>
</section>
<jsp:include page="../../common/footer.jsp" />
