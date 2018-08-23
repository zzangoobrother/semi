<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>

<script>
	function gomain() {
		location.href="/semi/index.jsp";
	}
</script>

<div>
	<div>
		<div>
			<span>장바구니</span> > <span>주문결제</span> <span>주문완료</span>
		</div>
	</div>
	<br>
	<div>
		<span>주문상품 확인</span>
	</div>
	<div align="center">
		<table cellspacing="0" border="1">
			<tr>
				<th colspan="2">상품/옵션정보</th><th>대여기간</th>
			</tr>
			
			<tr>
				<td rowspan="2"><a href="/semi/pdetail.bd?pname=포터블그라인더"><img src="/semi/resources/images/main/01_1.jpg"></a></td>
				<td><a href="/semi/pdetail.bd?pname=포터블그라인더">햄머드릴(PHD-2838)</a></td>
				<td rowspan="2">시작일 : 2018-08-20 ~ 종료일 : 2018-08-22</td>
			</tr>
			
			<tr>
				<td>옵션을 선택하지 않으셨습니다.</td>
			</tr>
		</table>
	</div>
	<br>
	<div align="center">
		<table cellspacing="0" border="1">
			<tr>
				<td>12,000원 - 0P = 12,000원</td>
			</tr>
		</table>
	</div>
	<div align="center">
		<input type="button" value="메인으로" onclick="gomain();">
	</div>
</div>

<%@ include file="../../footer.jsp" %>