<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../header.jsp" %>

<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">
	//취소버튼 클릭시
	function backmain() {
		alert("주문이 취소되었습니다.");
		location.href="/semi/index.jsp";
	}	
	
	// 카드 또는 무통장입금 체크시
	$(function() {
		$("input[type=radio]").change(function() {
			if($(this).is(":checked")) {
				if($(this).val() == "card") {
					$("#payselect").html("카드선택");
				} else {
					$("#payselect").html("은행선택<select><option>국민은행 464646-01-282828 예금주 : 홍길동</option><option>우리은행 263251-02-158965 예금주 : 홍길동</option></select>입금자명<input type=/'text/' name=/'sellname/' id=/'sellname/'>");
				}
			}
		});
	});
</script>
<div>
	<div>
		<div>
			장바구니 > <strong>주문/결제</strong> > 주문완료
		</div>
	</div>

	<!-- 결제할 상품 출력 -->
	<div align="center">
		<div>
			주문상품 확인
		</div>
		<form action="/semi/rlist" id="fsubmit" method="post">
		
		<!-- 서블릿에 전달해야하느 값들 -->
		<input type="hidden" name="loginId" id = "loginId" value=" <%= mId %>">
		<input type="hidden" name="totalcount" id="totlcount" value="1">
		<input type="hidden" name="productNo" id="productNo" value="03">
		
		<div>
			<table cellspacing="0" border="1">
				<tr>
					<th colspan="2">상품/옵션정보</th><th>대여가</th><th>대여일</th>
				</tr>
				<tr>
					<td rowspan="2">
						<a href="/semi/pdetail.bd?pname=포터블그라인더"><img src="/semi/resources/images/main/01_1.jpg"></a>
					</td>
					<td><a href="/semi/pdetail.bd?pname=포터블그라인더">LED후레쉬(LF-1418Z)</a></td>
					<td rowspan="2">10000원</td>
					<td rowspan="2">시작일 : <input type="hidden" name="startday" id="startday" value="2018-08-20">2018-08-20 ~ 종료일 : <input type="hidden" name="endday" id="endday" value="2018-08-21">2018-08-21</td>
				</tr>
				<tr>
					<td>옵션을 선택하지 않으셨습니다.</td>
				</tr>
			</table>
		</div>		
	</div>
	
	<!-- 결제 금액과 결제 방법 선택 -->
	<div align="center">
		<div>결제 정보</div>
		<div>
			<table cellspacing="0" border="1">
				<tr>
					<td><label>결제금액</label></td><td><input type="hidden" name="orderpay" id="orderpay" value="12000">12000원</td>
					<td><label>총 결제금액</label></td><td>12000원</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div align="center">
		<div>
			결제선택
			<table cellspacing="0" border="1" id="pay">
				<tr>
					<td align="center">
					<input name="payselect" type="radio" value="card">신용카드
					<input name="payselect" type="radio" value="money" checked>무통장입금
					<br>
					<span id="payselect">은행선택
					<select>
						<option>국민은행 464646-01-282828 예금주 : 홍길동</option>
						<option>우리은행 263251-02-158965 예금주 : 홍길동</option>
					</select>
					입금자명<input type="text" name="sellname" id="sellname"></span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div align="center">
		
		<input type="button" id="checkcard" value="결제하기">
		<input type="button" onclick="backmain();" value="취소하기">
	</div>
	</form>
</div>

<!-- 카드 결제시 작동하는 API -->
<script type="text/javascript">

		$("#checkcard").click(function() {
			$("input[type=radio]").each(function() {
				if ($(this).is(":checked")) {
					if ($(this).val() == "card") {
						var IMP = window.IMP;
						IMP.init("imp10675025");

						IMP.request_pay({
							pg : "inicis",
							pay_method : "card",
							merchant_uid : "merchant_" + new Date().getTime(),
							name : "주문명: 결제테스트",
							amount : $("#orderpay").val(),

							buyer_email : "iamport@siot.do",
							buyer_name : $("#sellname").html(),
							buyer_tel : "010-1234-5678",
							buyer_addr : "서울특별시 강남구 삼성동",
							buyer_postcode : "123-456",

						}, function(rsp) {
							console.log(rsp);
							if (rsp.success) {
								var msg = "결제가 완료되었습니다.";
								msg += "고유ID : " + rsp.imp_uid;
								msg += "상점 거래ID : " + rsp.merchant_uid;
								msg += "결제 금액 : " + rsp.paid_amount;
								msg += "카드 승인번호 : " + rsp.apply_num;
							} else {
								var msg = "결제에 실패하였습니다.";
								msg += "에러내용 : " + rsp.error_msg;
							}
							alert(msg);
						});
					} else {
						$("#fsubmit").submit();
					}
				}
			}); 
		});
</script>
<%@ include file="../../footer.jsp" %>