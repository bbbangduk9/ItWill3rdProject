<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>회원정보 관리_관리자페이지</title>
<script>
   function updateMemberMaster(memberId) {
       let selectedStatus = document.getElementById('status_' + memberId).value;
       console.log("memberId : " + memberId);
       console.log("selectedStatus : " + selectedStatus);
       $.ajax({
           type: "POST",
           url: "statusUpdate.do", // 백엔드 업데이트 URL로 변경
           data: {
               memberId: memberId,
               status: selectedStatus
           },
           success: function(response) {
               // 수정이 완료되었음을 사용자에게 알리기
               alert("수정이 완료되었습니다");
           },
           error: function(xhr, status, error) {
               // 수정이 실패했음을 사용자에게 알리기
               alert("수정에 실패했습니다");
           }
       });
   }
   function getMasterList(){
      let searchId = document.getElementById("searchID").value;
      console.log(searchId);
      $.ajax({
         type: "POST",
         url: "getMasterList.do",
         data: {
            "searchID" : searchId
         },
         success: function(response) {
            $('#subscribeList').html(response);
               console.log("검색완료")
           },
           error: function(xhr, status, error) {
              console.log("검색실패")
           }
      });
   }
</script>
<style>
   .masterList{
      width: 800px;
      text-align: center;
   }
   #masterListDiv {
      margin-left: 10%;
   }
   .masterList,
   .masterList th,
   .masterList td {
      border: 1px solid black;
   }
   .width_100 { 
      width: 100%; 
   }
   
</style>
</head>
<body>
   <div id="masterListDiv">
      <input type="text" name="searchID" id="searchID" placeholder="ID 검색">
      <input type="button" onclick="getMasterList()" value="검색">
      <!-- 데이터 표시 영역 -->
      <table class="masterSearch masterList">
         <tr>
            <th>ID</th>
            <th>이름</th>
            <th>채널명</th>
            <th>이메일</th>
            <th>가입일</th>
            <th>최근접속일</th>
            <th>상태</th>
            <th></th>
         </tr>
         <c:forEach var="vo" items="${masterList }">
         <tr>
            <td>${vo.memberId}</td>
            <td>${vo.name}</td>
            <td>${vo.title}</td>
            <td>${vo.email}</td>
            <td>${vo.regDate}</td>
            <td>${vo.logDate}</td>
            <td>
               <select class="width_100" id="status_${vo.memberId}">
                  <option value="1" <c:if test="${vo.status eq '1'}">selected</c:if>>정상</option>
                      <option value="2" <c:if test="${vo.status eq '2'}">selected</c:if>>계정정지</option>
               </select>
            </td>
            <td>
               <input type="button" class="width_100" value="수정" onclick="updateMemberMaster('${vo.memberId}')">
            </td>
         </tr>
         </c:forEach>
         <c:if test="${empty masterList }">
            <tr>
               <td colspan="8" class="center">데이터가 없습니다</td>
            </tr>
         </c:if>
      </table>
   </div>
</body>
</html>