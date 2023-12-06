<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/icofont/1.0.1/css/icofont.css">
<link href="${pageContext.request.contextPath}/resources/css/getQna.css" rel="stylesheet">
<style>
   
</style>
</head>
<body>

<div id="container">
   <h1>글상세</h1>
   <p><a href="logout.do">로그아웃</a></p>
   
   <form action="updateQna.do" method="get">
      <input type="hidden" name="seq" value="${qna.seq }">
      <table>
         <tr>
            <th>제목</th>
            <td>
               <c:choose>
                   <c:when test="${qna.memberId eq sessionScope.members.memberId}">
                       <input type="text" name="qtitle" value="${qna.qtitle}">
                   </c:when>
               <c:otherwise>
                  ${qna.qtitle}
               </c:otherwise>
               </c:choose>
            </td>
         </tr>
         <tr>
            <th>작성자</th>
            <td>${qna.memberId }</td>
         </tr>
         <tr>
            <th>내용</th>
            <td>
               <c:choose>
                   <c:when test="${qna.memberId eq sessionScope.members.memberId}">
                       <textarea name="content" rows="10" cols="40">${qna.content}</textarea>
                   </c:when>
                   <c:otherwise>
                       ${qna.content}
                   </c:otherwise>
               </c:choose>
            </td>
         </tr>
         <tr>
            <th>작성일</th>
            <td>${qna.qregdate }</td>
         </tr>
         <tr>
            <th>조회수</th>
            <td>${qna.cnt }</td>
         </tr>
         <c:choose>
             <c:when test="${qna.memberId eq sessionScope.members.memberId}">
                 <input type="submit" value="글 수정">
             </c:when>
             <c:otherwise>
             </c:otherwise>
         </c:choose>
      </table>
   </form>
   <br>
   <tr>
      <td>
      <c:if test="${qna.memberId eq members.memberId || members.status eq 0}">
          <a href="deleteQna.do?seq=${qna.seq}">글삭제</a>
      </c:if>
         <a href="getQnaList.do">메인화면으로</a>
   </td>
   </tr>
   <p>
   </p>
   
</div>

</body>
</html>