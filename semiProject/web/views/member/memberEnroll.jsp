<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../header.jsp" %>

<script type="text/javascript">
	function dupIdCheck() {
		$.ajax({
			url : "/semi/idchk",
			type : "post",
			data : {
				m_id : $("#m_id").val()},
			success : function(data) {
				console.log("success : " + data);
				if (data == "ok") {
					alert("사용 가능한 아이디입니다.");
					$("#m_name").focus();
				} else {
					alert("이미 사용중인 아이디입니다.\n" + "다시 입력하십시오.");
					$("#m_id").select();
				}
			},
			error : function(jqXHR, textstatus, errorthrown) {
				console.log("error : " + jqXHR + ", " + textstatus + ", "
						+ errorthrown);
			}
		});
		return false;
	}
</script>

<!-- 디비에 암호화 처리 -->
<script type="text/javascript">
	function pwdChk(){
		var p1 = document.getElementById("pwd1").value;
		var p2 = document.getElementById("pwd2").value;
		
		
		if(p1 == p2) 
			return true; //submit
		else
			return false; //submit취소
	}
</script>
        <table align="center">
        <h2 align="center">회 원 가 입</h2>
					<form action="/semi/menroll.cp" method="post" onsubmit="return pwdChk();">
						
			<!-- <table align="center" cellspacing="0" border="1"> -->
						<div class="form-group">
							<tr>
							<td>아이디</td>
							<td><input name="m_id" class="form-control" id="m_id" 
								style="width: 200px; height: 25px; border-radius: 4px;">
								<button onclick="return dupIdCheck();" class="btn btn-warning">중복확인</button></td>
							</tr>
							</div>
							<div class="form-group">
							<tr>
							<td>비밀번호</td>
							<td><input type="password" name="m_password1"
										class="form-control" style="width: 200px; height: 25px; border-radius: 4px;"></td>
							</tr>
								</div>	
							<div class="form-group">
							<tr>
							<td>비밀번호 확인</td>
							<td><input type="password" name="m_password2"
											class="form-control" style="width: 200px; height: 25px; border-radius: 4px;"></td>
							</tr>
							</div>	
							<div class="form-group">
							<tr>
							<td>이름</td>
							<td><input name="m_name" class="form-control"
   								style="width: 200px; height: 25px; border-radius: 4px;"></td>
							</tr>
							</div>	
							<div class="form-group">
							<tr>
							<td>닉네임</td>
							<td><input name="m_nickname" class="form-control"
										style="width: 200px; height: 25px; border-radius: 4px;" ></td>
							</tr>
							</div>
							<div class="form-group">
							<tr>
							<td>전화번호</td>
							<td><input type="tel" name="m_phone" class="form-control"
								style="width: 200px; height: 25px; border-radius: 4px;"></td>
							</tr>
							</div>
		<div class="form-group">
			<tr>
				<td>주소</td>
				<td><input type="text" id="sample4_postcode" placeholder="우편번호"
					style="width: 200px; height: 25px; border-radius: 4px;"
					class="form-control"> <input type="button"
					onclick="sample4_execDaumPostcode()" value="우편번호 찾기"
					class="form-control"
					style="width: 100px; height: 25px; border-radius: 4px;"> <input
					type="text" id="sample4_roadAddress" placeholder="도로명주소"
					name="m_address" class="form-control"
					style="width: 200px; height: 25px; border-radius: 4px;"> <input
					type="text" id="sample4_jibunAddress" placeholder="지번주소"
					class="form-control" class="form-control"
					style="width: 200px; height: 25px; border-radius: 4px;"> <span
					id="guide" style="color: #999"></span> 
					<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
					<script charset="UTF-8" type="text/javascript" src="http://t1.daumcdn.net/postcode/api/core/180619/1529384927473/180619.js"></script>
					<br>
					<script>
						//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
						function sample4_execDaumPostcode() {
							new daum.Postcode(
									{
										oncomplete : function(data) {
											// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

											// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
											// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
											var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
											var extraRoadAddr = ''; // 도로명 조합형 주소 변수

											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraRoadAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraRoadAddr += (extraRoadAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraRoadAddr !== '') {
												extraRoadAddr = ' ('
														+ extraRoadAddr + ')';
											}
											// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
											if (fullRoadAddr !== '') {
												fullRoadAddr += extraRoadAddr;
											}

											// 우편번호와 주소 정보를 해당 필드에 넣는다.
											document
													.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
											document
													.getElementById('sample4_roadAddress').value = fullRoadAddr;
											document
													.getElementById('sample4_jibunAddress').value = data.jibunAddress;

											// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
											if (data.autoRoadAddress) {
												//예상되는 도로명 주소에 조합형 주소를 추가한다.
												var expRoadAddr = data.autoRoadAddress
														+ extraRoadAddr;
												document
														.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
														+ expRoadAddr + ')';

											} else if (data.autoJibunAddress) {
												var expJibunAddr = data.autoJibunAddress;
												document
														.getElementById('guide').innerHTML = '(예상 지번 주소 : '
														+ expJibunAddr + ')';

											} else {
												document
														.getElementById('guide').innerHTML = '';
											}
										}
									}).open();
						}
					</script></td>
			</tr>
		</div>
		<div class="form-group">
					<tr>
					<td>이메일</td>
					<td><input type="email" name="m_email" class="form-control"
						style="width: 200px; height: 25px; border-radius: 4px;">
					<button id="checkemail" onclick="window.open('address','window_name','width=400,height=350,location=no,status=no,scrollbars=yes');">이메일인증</button></td>
					</tr>
					
					</div>
					<div class="form-group">
					<tr>
					<td>생년월일</td>
					<td><script type="text/javascript">
						var today = new Date();
						var toyear = parseInt(today.getFullYear());
						var start = toyear;
						var end = toyear - 70;

							document
								.write("<font size=2><select name=birth1>");
							document
								.write("<option value='' selected>");
								for (i = start; i >= end; i--)
									document.write("<option>" + i);
								document.write("</select>년  ");
									document.write("<select name=birth2>");
									document
											.write("<option value='' selected>");
									for (i = 1; i <= 12; i++)
										document.write("<option>" + i);
									document.write("</select>월  ");

									document.write("<select name=birth3>");
									document
											.write("<option value='' selected>");
									for (i = 1; i <= 31; i++)
										document.write("<option>" + i);
									document.write("</select>일   </font>");
								</script> 
					</tr><br>
					</div>
					
					<tr>
			 		<td>성별</td>
					<td><input type="radio" name="m_gender" value="M" style="MARGIN: 0px 3px 1px 0px; WIDTH: 13px; HEIGHT: 13px 
								border-radius: 4px;">남&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="m_gender" value="F" style="MARGIN: 0px 3px 1px 0px; WIDTH: 13px; HEIGHT: 13px 
								border-radius: 4px;">여</td>
					</tr>
					
					<tr>
					<td align="center" colspan="2">
					<input type="submit"value="가입하기" style="width: 150px; height: 30px; border-radius: 4px;">&nbsp;
					<input type="reset" value="취소" style="width: 150px; height: 30px; border-radius: 4px;" onclick="location.href='/semi/index.jsp'">
					</td>
					</tr>
	</form>
	</table>
	<br><br>

<%@ include file="../../footer.jsp" %>