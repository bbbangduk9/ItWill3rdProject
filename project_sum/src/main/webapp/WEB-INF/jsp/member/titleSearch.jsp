<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .eee {
        margin-left: 15px;
    }

    .flex-container {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        width: 50%;
    }

    .title-container {
        font-size: 30px;
        width: 200px;
        padding-left: 15px;
    }
</style>
</head>
<body>

<c:forEach var="ts" items="${titleSearch}">
    <div class="flex-container hoverPoint" onclick="moveSubscribe('${ts.memberId}')">
        <span class="hoverPoint"  style="border: 0 solid; width: 260px; height: 180px; display: flex; justify-content: center; align-items: center;">
            <img src="profileImage/${ts.image}" style="width: 150px; height: 150px; border: 1px solid; border-radius: 50%; border-color: black;">
        </span>
        <div class="title-container">
        	<p>${ts.title}</p>
            <p class="pt-2" style="color: #666; font-size: 15px;" >
                @${ts.memberId }
                <br>
                ${ts.email }
            </p >    
        </div>
    </div>
</c:forEach>


<script>
function moveSubscribe(memberId) {
    location.href="channel.do?memberId=" + memberId;
}

</script>
</body>
</html>