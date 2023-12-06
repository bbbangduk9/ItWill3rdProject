<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>동영상 업로드</title>
</head>
<body>
    <h2>동영상 업로드</h2>

    <div id="container">
        <h1>글 등록 </h1>
<script>
function validateForm() {
    var vtitle = document.forms["videoForm"]["vtitle"].value;
    var genre = document.forms["videoForm"]["genre"].value;
    var addUploadFile = document.forms["videoForm"]["addUploadFile"].value;
	
    console.log(vtitle);
    console.log(genre);
    console.log(addUploadFile);
    if (vtitle == "" || genre == "" || addUploadFile == "") {
        alert("*표시 되어있는 문항은 다 입력해야합니다.");
        return false; // 폼 제출 방지
    }

    return true; // 폼 제출 허용
}

function previewImage(input) {
    var preview = document.getElementById('insertImage');
    var file = input.files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
        preview.src = reader.result;
    }

    if (file) {
        // 이미지 파일인지 확인
        if (validateFileType(file)) {
            reader.readAsDataURL(file);
        } else {
            // 이미지 파일이 아닌 경우
            alert('올바른 이미지 파일을 선택하세요 (JPEG, PNG, GIF, JPG).');
            input.value = ''; // 선택된 파일 제거
            preview.src = ''; // 이미지 미리보기 초기화
        }
    } else {
        preview.src = '';
    }
}

// 이미지 파일인지 확인하는 함수
function validateFileType(file) {
    var allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
    return allowedTypes.indexOf(file.type) !== -1;
}
    
    
function previewImage(input) {
    var preview = document.getElementById('insertVideo');
    var file = input.files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
        preview.src = reader.result;
    }

    if (file) {
        // 이미지 파일인지 확인
        if (validateFileType(file)) {
            reader.readAsDataURL(file);
        } else {
            // 이미지 파일이 아닌 경우
            alert('올바른 이미지 파일을 선택하세요 (MP4, AVI, MKV, MOV, WMV).');
            input.value = ''; // 선택된 파일 제거
            preview.src = ''; // 이미지 미리보기 초기화
        }
    } else {
        preview.src = '';
    }
}

// 이미지 파일인지 확인하는 함수
function validateFileType(file) {
    var allowedTypes = ['video/mp4', 'video/avi', 'video/mkv', 'video/mov', 'video/wmv'];
    return allowedTypes.indexOf(file.type) !== -1;
}
</script>

        <form name="videoForm" action="insertVideo.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <table>
                <tr>
                    <th width="70">아이디</th>
                    <td>
                        <input type="text" name="memberId" value="${vo.memberId }" readonly>
                    </td>
                </tr>
                <tr>
                    <th width="70">제목 *</th>
                    <td>
                        <input type="text" name="vtitle">
                    </td>
                </tr>
                <tr>
                    <th>장르 *</th>
                    <td>
                        <input type="text" name="genre">
                    </td>
                </tr>
                <tr>
                    <th>영상설명 </th>
                    <td>
                        <textarea name="description" rows="10" cols="40"></textarea>
                    </td>
                </tr>

                <tr>
                    <th>썸네일</th>
                    <td>
                        <input id="insertImage" type="file" name="uploadFile">
                    </td>
                </tr>
                <tr>
                    <th>영상 *</th>
                    <td>
                        <input id="insertVideo" type="file" name="addUploadFile">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="center">
                        <input type="submit" value="동영상 등록">
                    </td>
                </tr>
            </table>
        </form>
        <p>
            <a href="main.jsp">글 목록 가기</a>
        </p>

    </div>
</body>
</html>