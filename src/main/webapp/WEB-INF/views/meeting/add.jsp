<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b5744597ccc65933ecad3607daed47e&libraries=services"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<body>
    <input type="text" id="adrs"><button id="btn2" type="button">검색</button>
	 <div id="map" style="width:1000px;height:800px;"></div>
    <div id="clickLatlng"></div>
    <p id="result"></p>

    <form class="mb-5 text-center form-control" action="./add" method="post" id="frm">
	    <input type="hidden" name="id" value="${sessionScope.member.id }">
	    제목<input type="text" name="title" id="title"><br>
	    내용<textarea class="input-group" rows="" cols="" name="contents" id="contents"></textarea>
	    모임날짜<input type="datetime-local"  id="meetingDate">
        정원<input type="number" id="personnel" min="2" max="10" name="personnel">
        <input type="hidden" name="meetingDate" id="meetingDate2">
	    <input type="hidden" name="lat" id="lat">
	    <input type="hidden" name="lng" id="lng">
	
		<button id="btn" type="button">등록</button>

   	</form>

    
    <script>
    
    const btn = document.getElementById("btn");
    const title = document.getElementById("title");
    const meetingDate = document.getElementById('meetingDate');
    const meetingDate2 = document.getElementById('meetingDate2');
	const frm = document.getElementById("frm");
         $("#contents").summernote({
            height:400,
            callbacks:{
                onImageUpload:function(files){
                alert('이미지 업로드')
                //이미지를 server로 전송하고
                //응답으로 이미지경로와 파일명을 받아서
                //img 태그를 만들어서 src속성에 이미지경로는 넣는것
                let formData = new FormData();//<form></form>
                formData.append('files',files[0]);//<input type='file' name='files'>
                $.ajax({
                    type:'post',
                    url:'setContentsImg',
                    data:formData,
                    cashe: false,
                    enctype:'multipart/form-data',
                    contentType: false,
                    processData: false,
                    success:function(result){
                        $("#contents").summernote("insertImage",result.trim());
                    },
                    error:function(){
                        console.log('error');
                    }
                });
                },
				onMediaDelete:function(files){
					let path = $(files[0]).attr("src"); // /resources/upload/notice/파일명
					$.ajax({
						type:'post',
						url:'./setContentsImgDelete',
						data:{
							path:path
						},
						success:function(result){
							console.log(result);
						},
						error:function(){
							console.log('error');
						}
					})
				}
            }
        }); 


		btn.addEventListener("click", function(){
			console.log(title.value=="");
			console.log(title.value.length == 0);
			if(title.value==""){
				alert('제목은 필수 입니다.');
				title.focus();
			}else {
                alert(meetingDate.value.replace('T',' '));
                let s = meetingDate.value.replace('T',' ');
                meetingDate2.value=s;
               
                
				frm.submit();
			}
		});

        // kakao.maps.load(function() {
        // // v3가 모두 로드된 후, 이 콜백 함수가 실행됩니다.
        // let map = new kakao.maps.Map(node, options);
        // });

    </script>
    <script src="../resources/js/meeting/addTest.js" defer></script>
</body>
</html>