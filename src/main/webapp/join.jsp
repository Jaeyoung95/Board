<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>

	<div class="container" align="center">
		<h1>회원가입</h1>
		<hr>
		<form action="JoinCtrl" method="post" name="join">
			<table class="table" style="width:400px;">
				<tr>
					<td>아이디</td>
					<td> <input type="text" name="id" id="id"> <button onclick="idCheck();return false;" class="btn btn-primary">ID중복확인</button> </td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="password"></td>
				</tr>
				
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="submit" value="가입" class="btn btn-primary">
						<input type="reset" value="다시입력" class="btn btn-primary">
					</td>
				</tr>
			</table>
		</form>
		<hr>
		<script type="text/javascript">
		function idCheck(){
			var $id=document.join.id.value;
			
			if($id=="" || $id.length==0){
				alert('id를 입력하세요.');
				document.join.id.focus();
				return;
			}else{
				$.ajax({
					url:"http://localhost:8081/Board/IdCheckCtrl",
					type:"post",
					data:{id:$id},
					dataType:"text",
					success(data){
						if(data=="USE_ID"){
							alert($id+'는 사용할 수 있습니다.');
							$("#id").val($id);
						}else if(data=="NOT_USE_ID"){
							alert($id+'는 사용할 수 없습니다.');
							$("#id").val("");
							// val메소드로 처리할 때는 실시간 값을 변경해서 처리할 경우 사용.
							// attr은 이미 객체가 생성될 때 설정된 값을 attr속성을 넣을 경우
							// 동적으로 변하지 않는다.
							// 결론 : 동적으로 HTML요소 변경시 val메소드 사용
						}
					},
					error:function(){
						alert('전송 실패');
					}
				});
			}
		}
		</script>
	</div>
</body>
</html>