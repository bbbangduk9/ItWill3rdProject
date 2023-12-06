<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/getQnaList.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
<title>전체목록</title>
</head>
<body>
<div id="topframe"></div><br><br><br><br><br>
<div id="titleSearchTable" style="margin-left: 20%; "></div>
<div id="videoSearchTable" style="margin-left: 20%; "></div>
<div id="container">
   <h1>문의사항 게시판</h1>
   <h3>${vo.memberId }님 환영합니다</h3>
   <h3><a href="logout.do">로그아웃</a></h3>
   
   <!-- 검색을 위한 폼 -->
   <form action="getPagedQnaList.do" method="get">
    <input type="hidden" name="nowPage" value="1">
      <table class="border-none">
         <tr>
            <td>
               <%-- 
               <select name="searchCondition">
                  <option value="TITLE">제목</option>
                  <option value="CONTENT">내용</option>
               </select>
               --%>
               <select name="searchCondition">
               <c:forEach var="option" items="${conditionMap }">
                  <option value="${option.value }">${option.key }</option>
               </c:forEach>
               </select>
               <input type="text" name="searchKeyword">
               <input type="submit" value="검색">
            </td>
         </tr>
      </table>
   </form>
   
   <!-- 데이터 표시 영역 -->
   <table>
      <thead>
         <tr>
            <th width="100">번호</th>
            <th width="200">제목</th>
            <th width="150">작성자</th>
            <th width="150">작성일</th>
            <th width="150">조회수</th>
         </tr>
      </thead>
      <tbody>
      <c:forEach var="qna" items="${qnaList }">
         <tr>
             <td>${qna.seq }</td>
        <td>
            <c:if test="${qna.secret eq 'Y'}">
            &#128274;
                <c:choose>
                    <c:when test="${qna.memberId eq vo.memberId || vo.status eq 0}">
                        <a href="getQna.do?seq=${qna.seq }"><i class="icofont-lock"></i>${qna.qtitle }</a>
                    </c:when>
                    <c:otherwise>
                        <i class="icofont-lock"></i>${qna.qtitle }
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${qna.secret eq 'N'}">
                <a href="getQna.do?seq=${qna.seq }">${qna.qtitle }</a>
            </c:if>
        </td>
        <td>${qna.memberId }</td>
        <td>${qna.qregdate }</td>
        <td>${qna.cnt }</td>
    </tr>
      </c:forEach>
      <c:if test="${empty qnaList }">
         <tr>
            <td colspan="5" class="center">데이터가 없습니다</td>
         </tr>
      </c:if>
      </tbody>
   </table>
   <!-- 페이징 -->
   <div class="pagination">
          <!-- 이전 페이지로 이동하는 버튼 -->
       <c:if test="${pageVO.nowBlock == 1}">
           <span>이전으로</span>
       </c:if>
       <c:if test="${pageVO.nowBlock != 1}">
         <a href="getPagedQnaList.do?nowPage=${pageVO.beginPage - 1}
         &searchCondition=${param.searchCondition}
         &searchKeyword=${param.searchKeyword}">이전으로</a>
      </c:if>
       <c:forEach var="i" begin="${pageVO.beginPage}" end="${pageVO.endPage}">
           <c:choose>
               <c:when test="${i eq pageVO.nowPage}">
                   <span>${i}</span>
               </c:when>
               <c:otherwise>
               <a href="getPagedQnaList.do?nowPage=${i}
               &searchCondition=${param.searchCondition}
               &searchKeyword=${param.searchKeyword}">
               ${i}</a>
               </c:otherwise>
           </c:choose>
       </c:forEach>
      
       <!-- 다음 페이지로 이동하는 버튼 -->
       <c:if test="${pageVO.nowBlock eq pageVO.totalBlock}">
           <span>다음으로</span>
       </c:if>
       <c:if test="${pageVO.nowBlock lt pageVO.totalBlock}">
         <a href="getPagedQnaList.do?nowPage=${pageVO.endPage + 1}
         &searchCondition=${param.searchCondition}
         &searchKeyword=${param.searchKeyword}">다음으로</a>
      </c:if>
   </div>
   </div>
   <p>
      <a href="insertQna.do">새글등록</a>
   </p> 
   

</body>
<script>
/* top frame ajax */

	$(document).ready(function() {
	  // topFrame.jsp를 불러와서 topFrameContainer에 삽입하는 함수
	  function loadTopFrame() {
	      $.ajax({
	          url: 'topFrame.do',
	          type: 'POST',
	          success: function (response) {
	              // topFrame.do의 응답 처리
	              $('#topframe').html(response);
	              document.getElementById('topframeajax').style.backgroundColor = '#f5f5f5';
	              $('#searchBtnFrame').click(function() {
	                  searchData();
	                 $('.container').html(''); // 화면 초기화
	              });
	          },
	          error: function (xhr, status, error) {
	              // 오류 처리
	              console.error('Error while fetching topFrame.do:', error);
	          }
	      });
	  }
	
	  // 페이지 로드 시 topFrame.jsp를 불러오기
	  loadTopFrame();
	});
</script>
</html>