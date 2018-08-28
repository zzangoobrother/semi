<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../../header.jsp" %>
	<style type="text/css">
		
	</style>
	<script type="text/javascript">
 	//회원 조회용 변수
	var currentPage;
	var maxPage;
	var startPage;
	var endPage;
	var listCount;
	var pwdList = [];
	var rentalInfo = new Object();
	var filter;
	
	//select box default select 설정용 Date 변수
	var sysDate = new Date();
	var sysYear = sysDate.getFullYear();
	var sysMonth = sysDate.getMonth() + 1;
	var sysDay = sysDate.getDate();
	
	var localFilter;	//지역명
	var localNameFilter;	//동사무소명
	var productName; //물품명
	
	$(function(){
		//#table2 사이즈 변경
		//$("#table2 tr").not($("td")).css("width", "100px");
 		//#table1 의 모든 필드에 readonly 속성 추가
		$("#table1 input").attr("readonly", true);
		
		//$("#table1 input").attr("readonly", false);
		$("body").append("<td>");
		$("#table1 input").css("font-size", "14px");
		
		//$("#local1").attr("onChange", "localNamePrint(" + localFilter + ")");
		
		/* $("#local1").on("change", 
				function(){
				localFilter = $(":selected").val();
				$("#local2").html("");
				localNamePrint(localFilter);	//동사무소명 출력함수 호출	
				return false;
		}); */
		
		
		
	}); //document.ready
	
	//-------------------------------------------------------------
	//등록 버튼 클릭시 지역명 출력 -> 지역명 select 이벤트 발생시
	//select 한  filter 에 맞는 동사무소명 출력
	//동사무소명 select 이벤트 발생시 ->
	//해당 동사무소에 대여 가능한 && 재고가 존재하는 물품명 출력
	//물품명 select 이벤트 발생시 select 한 filter에 맞는
	//물품번호를 물품번호 필드에 출력
	
	//지역명 출력 함수
	function localPrint(){
		$.ajax({
			url : "/semi/rmlselect",
			type : "post",
			dataType : "json",
			success : function(data){
				var jsonStr = JSON.stringify(data);
				//jsonStr = jsonStr.replace("+", " ");
				var json = JSON.parse(jsonStr);
				
				for(var i = 0; i < json.list.length; i++){
					$("#local1").append("<option>" + decodeURIComponent(json.list[i].lloca) + "</option>");
				} //for
			}, //success
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			} // error
		}); //ajax
		
		return false;
	} //localPrint end-
	
	//지역명 select 이벤트 발생시
	function localSelectEvent(){
		localFilter = $(":selected").val();
		$("#local2").html("");
		localNamePrint(localFilter);	//동사무소명 출력함수 호출	
		return false;
	}
	
	//동사무소명 출력 함수
	function localNamePrint(localFilter){
		$.ajax({
			url : "/semi/rmlnselect",
			type : "post",
			data : {"local" : localFilter},
			dataType : "json",
			success : function(data){
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				
				$("#local2").append("<option>동사무소선택</option>");
				for(var i = 0; i < json.list.length; i++){
					json.list[i].lname = json.list[i].lname.replace("+", " ");
					$("#local2").append("<option>" + decodeURIComponent(json.list[i].lname) + "</option>");
				} //for
			}, //success
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			} // error
		}); //ajax
		return false;
	}
	
	//동사무소명 select 이벤트 발생시
	function localNameSelectEvent(){
		$("#pname").html("");
		localNameFilter = $("#local2 :selected").val();
		productPtint(localNameFilter);	//동사무소명 출력함수 호출	
		return false;
	}
	
	//물품명 출력함수
	function productPtint(localNameFilter){
		$.ajax({
			url : "/semi/rmpnselect",
			type : "post",
			data : {"lname" : localNameFilter},
			dataType : "json",
			success : function(data){
				
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				$("#pname").append("<option>물품명선택</option>")
				for(var i = 0; i < json.list.length; i++){
					$("#pname").append("<option>" + decodeURIComponent(json.list[i].pname) + "</option>");
				}
			}, //success
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			}
		}); //ajax	
		return false;
	} //productSelectBox_end
	
	//물품명 select 이벤트 발생시
	function productInfoPrint(){
		//$("#pname").html("");
		alert($("#pname :selected").val());
		productName = $("#pname :selected").val();
		//alert($("#pname :selected").val() + ", " + $("#local2 :selected").val());
		productInfoPtint(productName, localNameFilter); //물품정보 출력함수 호출
		return false;
	}
	
	//물품정보 출력함수
	function productInfoPtint(productName, localNameFilter){
		/*P_NO	NUMBER	No		1	물품번호
		P_NAME	VARCHAR2(300 BYTE)	No		2	물품명
		P_PRICE	NUMBER	Yes		3	물품가격
		P_COUNT	NUMBER	Yes		4	물품수량
		P_LOCAL	VARCHAR2(300 BYTE)	No		5	물품보유지역
		P_ITEM	VARCHAR2(100 BYTE)	No		8	물품품목
		P_STATE	VARCHAR2(100 BYTE)	Yes	"'대여가능'
		"	10	물품대여상태*/
		//alert(productName + ", " + localNameFilter);
		$.ajax({
			url : "/semi/rmpiselect",
			type : "post",
			data : {"pname" : productName, "lname" : localNameFilter},
			dataType : "json",
			success : function(data){
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				alert("석세스?");
				alert(json.pno + ", " + json.pprice + ", " + json.pcount + ", " + decodeURIComponent(json.pitem)+ ", " + decodeURIComponent(json.pstate));
				/* $("#pno").val(json.pno);
				$("#pprice").val(json.pprice);
				$("#pcount").val(json.pcount);
				$("#pitem").val(decodeURIComponent(json.pitem));
				$("#pstate").val(decodeURIComponent(json.pstate)); */
				
			}, //success
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			}
		}); //ajax
		
		return false;
	} //productPrint2 end-
	
	
	
	
	//등록 | 수정 | 삭제 radio 버튼 checked true 일 경우 버튼 숨기기
	//등록 | 수정 선택시 readonly 설정 제거
	//등록 선택시 필드 값 초기화
	//등록 | 수정 | 삭제 선택시 #form1 의 action 경로 설정
 	
	//등록 radio
	function enrollChecked(){
/* 		$("#enrollBtn").attr("style", "display:inline");
		$("#editBtn").attr("style", "display:none");
		$("#deleteBtn").attr("style", "display:none");
		
		$("#idchkBtn").attr("style", "display:block");
		
		$("#table1 input").attr("readonly", false);
		$("#table1 input").val(""); */
		
		$("#saveBtn").attr("style", "display:inline");
		$("#editSaveBtn").attr("style", "display:none");
		$("#returnBtn").attr("style", "display:none");
		
		$("#table1 input").not($("#rnum")).not($("#rdate")).not($("#rstartdate")).attr("readonly", false);
		$("#rrastdate").attr("style", "display:none");
		$("#rbookdate").attr("style", "display:none");
	
		$("#table1 input").val("");
 		//대여/반납접수일자, 대여실행일자 기본 값
		var sysMonth1 = 0;
		var sysDay1 = 0;
		
		if(sysMonth < 10){
			sysMonth1 = "0" + sysMonth;
		}else{
			sysMonth1 = sysMonth;
		}
		if(sysDay < 10){
			sysDay1 = "0" + sysDay;
		}else{
			sysDay1 = sysDay;
		}
		
		$("#rdate").val(sysYear + "-" + sysMonth1 + "-" + sysDay1);
		//$("#rdate").attr("readonly", true);
		$("#rreturndate").val(sysYear + "-" + sysMonth1 + "-" + (sysDay1+1));
		$("#rstartdate").val(sysYear + "-" + sysMonth1 + "-" + sysDay1);
		
		
		localPrint();	//지역명 출력 함수 호출
		
		/* $.ajax({
			url : "/semi/mrplist",
			type : "post",
			//dataType : "json",
			success : function(data){
				//리스트에서 꺼내서 물품명 select box for문 돌려서 생성
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
			
				for(var i = 0; i <= json.list.length; i++){
					$("#pname").append("<option id='pnameChk" + i + "'>" + decodeURIComponent(json.list[i].pname) + "</option>");
				} //for
				
			}, //success
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			}
		}); //ajax*/
 		return false;
	}
 	//수정 radio
	function editChecked(){
		$("#enrollBtn").attr("style", "display:none");
		$("#editBtn").attr("style", "display:inline");
		$("#deleteBtn").attr("style", "display:none");
		
		$("#table1 input").attr("readonly", false);
		$("#mid1").attr("readonly", true);
		$("#idchkBtn").attr("style", "display:none");
		//$("#form1").attr("action", "/semi/medit");
		return false;
	}
	//삭제 radio
	function deleteChecked(){
		$("#enrollBtn").attr("style", "display:none");
		$("#editBtn").attr("style", "display:none");
		$("#deleteBtn").attr("style", "display:inline");
		
		$("#table1 input").attr("readonly", true);
		$("#idchkBtn").attr("style", "display:none");
		
		//$("#form1").attr("action", "/semi/mdelete");
		return false;
	}
	//-------------------------------------------------------------
	
	//회원 등록
	function enrollClick(){
		if(confirm("입력한 정보로 신규 회원을 등록 하시겠습니까?")){
			var birth1 = $("#birth2").val();
			var birth2 = $("#birth2").val();
			var b2;
			if(birth2 < 10)
				b2 = "0" + birth2;
			else
				b2 = birth2;
			var birth3 = $("#birth3").val();
			var b3;
			if(birth3 < 10)
				b3 = "0" + birth3;
			else
				b3 = birth3;
			memberInfo.mname = $("#mname").val();
			memberInfo.mid = $("#mid1").val();
			memberInfo.mnick = $("#mnick").val();
			memberInfo.mpwd = $("#mpwd").val();
			memberInfo.msno = (birth1 + "-" + b2 + "-" + b3);
			if($("#T").is(":checked") == true)
				memberInfo.mgender = "M";
			else
				memberInfo.mgender = "F";
	
			memberInfo.mphone = $("#mphone").val();
			memberInfo.memail = $("#memail").val();
			
			var adr1 = $("#sample4_postcode").val();
			var adr2 = $("$sample4_roadAddress").val();
			memberInfo.maddress = (adr1 + ", " + adr2);
			
			memberInfo.mpoint = $("#mpoint").val(); 
			
			var jsonStr = JSON.stringify(memberInfo);
			//var json = JSON.parse(jsonStr);
	
			$.ajax({
				url : "/semi/mmenroll",
				type : "post",
				data : {"jsonStr" : jsonStr},
				//dataType : "json",
				success : function(data){
					if(data >= 1)
						alert("회원 등록 완료");
					else
						alert("회원 등록 실패");
					paging(currentPage);
				}, //success
				error : function(jqXHR, textstatus, errorThrown){
					console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
				} //error
			});//ajax
			paging(1);
		}else{
			alert("회원 등록을 취소합니다.");
		}
		return false;
	} //enrollClick
	
	//회원 수정
	function editClick(memberInfo){
		
		if(confirm("변경된 정보로 정말 수정하시겠습니까?")){
			var birth1 = $("#birth2").val();
			var birth2 = $("#birth2").val();
			var b2;
			if(birth2 < 10)
				b2 = "0" + birth2;
			else
				b2 = birth2;
			var birth3 = $("#birth3").val();
			var b3;
			if(birth3 < 10)
				b3 = "0" + birth3;
			else
				b3 = birth3;
			memberInfo.mname = $("#mname").val();
			memberInfo.mid = $("#mid").val();
			memberInfo.mnick = $("#mnick").val();
			memberInfo.mpwd = $("#mpwd").val();
			memberInfo.msno = (birth1 + "-" + b2 + "-" + b3);
			
			if($("#T").is(":checked") == true)
				memberInfo.mgender = "남";
			else
				memberInfo.mgender = "여";
	
			memberInfo.mphone = $("#mphone").val();
			memberInfo.memail = $("#memail").val();
			
			var adr1 = $("#sample4_postcode").val();
			var adr2 = $("$sample4_roadAddress").val();
			memberInfo.maddress = (adr1 + ", " + adr2);
			
			memberInfo.mpoint = $("#mpoint").val(); 
			
			var jsonStr = JSON.stringify(memberInfo);
	
			$.ajax({
				url : "/semi/mmedit",
				type : "post",
				data : {"jsonStr" : jsonStr},
				success : function(data){
					if(data >= 1)
						alert("회원 정보 수정 완료");
					else
						alert("회원 정보 수정 실패");
					paging(currentPage);
				}, //success
				error : function(jqXHR, textstatus, errorThrown){
					console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
				} //error
				
			});//ajax
		}else{
			alert("변경사항을 저장하지 않고 수정을 취소합니다.");
		}
		paging(currentPage);
		return false;
	}
	
	//회원 삭제
	function deleteClick(memberInfo){
		if(confirm("해당 회원을 정말 삭제하시겠습니까?")){
			var mid = memberInfo.mid;
			$.ajax({
				url : "/semi/mmdelete",
				type : "post",
				data : {"mid" : mid},
				success : function(data){
					if(data >= 1)
						alert("회원 정보 삭제 완료");
					else
						alert(memberInfo.mid + "님의 회원 정보 삭제 실패");
					$("#table1 input").val("");
					paging(currentPage);
					
				}, //success
				error : function(jqXHR, textstatus, errorThrown){
					console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
				} //error
				
			}); //ajax
		}else{
			alert("회원 삭제를 취소합니다.");
		}
		paging(currentPage);
		return false;
	} //deleteClick
	
	//-------------------------------------------------------------
	
	//회원 선택시 table1 필드에 회원 정보 출력과 memberInfo에 회원 정보 담기
	function radioCheck(num){	
		//select한 회원 정보로 memberInfo 초기화
		memberInfo.mname = $("#nametd" + num).text();
		memberInfo.mid = $("#idtd" + num).text();
		memberInfo.mnick = $("#nicktd" + num).text();
		memberInfo.mpwd = pwdList[num];
		memberInfo.msno = $("#snotd" + num).text();
		memberInfo.mgender = $("#gendertd" + num).text();
		memberInfo.mphone = $("#phonetd" + num).text();
		memberInfo.memail = $("#emailtd" + num).text();
		memberInfo.maddress = $("#addresstd" + num).text();
		memberInfo.mpoint = $("#pointtd" + num).text();
 		//table1에 회원 정보 출력
		//$("#mname").val($("#nametd" + num).text());
		$("#mname").val(memberInfo.mname);
		$("#mid1").val(memberInfo.mid);
		$("#mnick").val(memberInfo.mnick);
		$("#mpwd").val(memberInfo.mpwd);
		$("#mpwd2").val(memberInfo.mpwd);
		
		var sno = memberInfo.msno;	
		var year = sno.substring(0, 4);
		var month = sno.substring(6, 7);
		var day = sno.substring(9, 10);
		$("#birth1").val(year);
		$("#birth2").val(month);
		$("#birth3").val(day);
 		if(memberInfo.mgender == "남"){
			//$("#F").attr("checked", false);
			$("#T").attr("checked", true);
			
		}else if(memberInfo.mgender == "여"){
			//$("#T").attr("checked", false);
			$("#F").attr("checked", true);
		}
		
		$("#mphone").val(memberInfo.mphone);
		$("#memail").val(memberInfo.memail);
		
		var adrSplit = memberInfo.maddress.split(",");
		$("#sample4_postcode").val(adrSplit[0]);
		$("#sample4_roadAddress").val(adrSplit[1]);
		
		$("#mpoint").val(memberInfo.mpoint);
		
		return false;
 	}
	//-------------------------------------------------------------
	
	//회원 리스트 전체 조회
	function paging(page){
 		$.ajax({
			url : "/semi/mmlist",
			type : "get",
			data : {"page" : page},
			dataType : "json",
			success : function(data){
				//회원 리스트 직렬화
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				
				//페이지 값 추출
				currentPage = json.currentPage;
				maxPage = json.maxPage;
				startPage = json.startPage;
				endPage = json.endPage;
				listCount = json.listCount;
				jsonListSize = json.list.length;
				jsonPwd = json.list
				
				var values = "";
				for(var i in json.list){
					values += "<tr><td><input type='radio' onclick='radioCheck(" + i + ")' name='choice' id='choice" + i + "'></td>"
					+ "<td id='nametd" + i + "'>" + decodeURIComponent(json.list[i].mname) + "</td>"
					+ "<td id='idtd" + i + "'>" + decodeURIComponent(json.list[i].mid) + "</td>"
					+ "<td id='nicktd" + i + "'>" + decodeURIComponent(json.list[i].mnick) + "</td>"
					+ "<td id='snotd" + i + "'>" + decodeURIComponent(json.list[i].msno) + "</td>"
					+ "<td id='gendertd" + i + "'>" + decodeURIComponent(json.list[i].mgender) + "</td>"
					+ "<td id='phonetd" + i + "'>" + decodeURIComponent(json.list[i].mphone) + "</td>"
					+ "<td id='emailtd" + i + "'>" + decodeURIComponent(json.list[i].memail) + "</td>"
					+ "<td id='addresstd" + i + "'>" + decodeURIComponent(json.list[i].maddress) + "</td>"
					+ "<td id='pointtd" + i + "'>" +  json.list[i].mpoint + "</td></tr>";
					
					pwdList.push(json.list[i].mpwd);
					
				} //for
				$("#t1").html(values); 
				
				//페이징 처리
				var firstP = "<li><a id='firstBtn' href='#' onclick='paging(" + startPage + ")'>[처음으로]</a></li>";
				var finalP = "<li><a id='finalBtn' href='#' onclick='paging(" + endPage + ")'>[끝으로]</a></li>";
				
				for(var p = startPage; p <= endPage; p++){ 
					if(p == startPage)
						$("#domain").html(firstP);
					
					//if(p > startPage)
					$("#domain").append("<li><a href='#' onclick='paging(" + p + ")'>" + p + "</a></li>");
					
					if(p == endPage)
						$("#domain").append(finalP);	
				} //paging for
				
			}, //success
				error : function(jqXHR, textstatus, errorThrown){
					console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			} //error
		
		}); //ajax
 		return false;
	}
	
	//-------------------------------------------------------------
	
	//필터 선택 조회 
	function selectBtnClick(){
			
		filter = $("#filter").val();
		value = $("#searchTF").val();
 		$.ajax({
			url : "/semi/mmselect",
			type : "post",
			data : {"filter" : filter, "value" : value},
			dataType : "json",
			success : function(data){
				//회원 리스트 직렬화
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				
				var values = "";
				for(var i in json.list){
					values += "<tr><td><input type='radio' onclick='radioCheck(" + i + ")' name='choice' id='choice" + i + "'></td>"
					+ "<td id='nametd" + i + "'>" + decodeURIComponent(json.list[i].mname) + "</td>"
					+ "<td id='idtd" + i + "'>" + decodeURIComponent(json.list[i].mid) + "</td>"
					+ "<td id='nicktd" + i + "'>" + decodeURIComponent(json.list[i].mnick) + "</td>"
					+ "<td id='snotd" + i + "'>" + decodeURIComponent(json.list[i].msno) + "</td>"
					+ "<td id='gendertd" + i + "'>" + decodeURIComponent(json.list[i].mgender) + "</td>"
					+ "<td id='phonetd" + i + "'>" + decodeURIComponent(json.list[i].mphone) + "</td>"
					+ "<td id='emailtd" + i + "'>" + decodeURIComponent(json.list[i].memail) + "</td>"
					+ "<td id='addresstd" + i + "'>" + decodeURIComponent(json.list[i].maddress) + "</td>"
					+ "<td id='pointtd" + i + "'>" +  json.list[i].mpoint + "</td></tr>";
					
					pwdList.push(json.list[i].mpwd);
				} //for
 				$("#t1").html(values); 
				
			}, //success
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			} //error
		}); //ajax
		return false;	
	}
	
	//아이디 중복확인
	function dupIdCheck() {
		$.ajax({
			url : "/semi/idchk",
			type : "post",
			data : {
				m_id : $("#mid1").val()},
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
 <body>
<div class="properties-area recent-property" style="background-color: #FFF;">
	<div class="container" style="width:1400px;height:1400px;">  
                <div class="row">              
                <div class="col-md-3 p0 padding-top-40" style="width:300px;height:800;">
                    <div class="blog-asside-right pr0">
                        <div class="panel panel-default sidebar-menu wow fadeInRight animated animated" style="visibility: visible; animation-name: fadeInRight;">
                            <div class="panel-heading">
                                <h3 class="panel-title">대여관리</h3>
                            </div>
                            <div class="panel-body search-widget" id="table1">
                                <!-- <form action="" class=" form-inline">  -->
                                    <fieldset>
                                    	<div class="row">
                                            <div class="col-xs-12">
                                            	<input type="radio" id="radio1" name="radioC" onclick="enrollChecked();">등록
												<input type="radio" id="radio2" name="radioC" onclick="editChecked();">수정
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>대여소</label>
                                            </div>
                                            <div class="col-xs-12">
                                            	<select onChange="localSelectEvent();" class="btn dropdown-toggle btn-default" id="local1" name="local1">
													<option>지역선택</option>
												</select> 
												<select onChange="localNameSelectEvent();" class="btn dropdown-toggle btn-default" id="local2" name="local2">
													<option>동사무소선택</option>
												</select> 
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>대여번호</label>
                                            </div>
                                            <div class="col-xs-12">
                                            	<input type="text" id="rnum" name="rnum" placeholder="대여번호" class="form-control">
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>물품정보</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <select onChange="productInfoPtint();" class="btn dropdown-toggle btn-default" id="pname" name="pname">
													<option>물품명선택</option>
												</select> 
												<input type="text" id="pnum" name="pnum" placeholder="물품번호" class="form-control">
                                            </div>                    
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>대여금액</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <input type="text" id="rprice" name="rprice" placeholder="대여금액" class="form-control" style="width: 90px;">1개
                                                1개
                                                <input type="text" id="rcount" name="rcount" placeholder="대여수량" class="form-control" style="width: 47px;">
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>대여접수일자</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <input type="date" id="rdate" name="rdate">
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>대여실행일자</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <input type="date" id="rstartdate" name="rstartdate">
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>반납접수일자</label>
                                            </div>
                                            <div class="col-xs-12">
												<input type="date" id="rreturndate" name="rreturndate">                                
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>반납실행일자</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <input type="date" id="rrastdate" name="rrastdate">
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>예약일자</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <input type="date" id="rbookdate" name="rbookdate">
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>대여상태</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <select id="filter" name="filter">
												<option>대기</option>
												<option>대여중</option>						
												</select>
                                            </div>
                                        </div>
                                        <div class="row">
                                        	<div class="col-xs-12" style="width:53px;">
                                            	<label>대여자아이디</label>
                                            </div>
                                            <div class="col-xs-12">
                                                <input type="text" id="mid1" name="mid1" placeholder="대여자아이디" class="form-control">
                                            </div>                                           
                                        </div>                                      
                                        <div class="row" style="display:flex;align-items:center;justify-content:center;">
                                            <div class="col-xs-12">
                                                <button type="button" id="saveBtn" name="saveBtn" onclick="saveClick();" style="display:none;" class="btn btn-finish btn-primary">저장</button>
												<button type="button" id="editSaveBtn" name="editSaveBtn" onclick="editSaveClick(memberInfo);" style="display:none;" class="btn btn-finish btn-primary">완료</button>
												<button type="button" id="returnBtn" name="returnBtn" onclick="returnClick(memberInfo);" style="display:none;" class="btn btn-finish btn-primary">반납</button>
												<button type="reset" id="cancleBtn" name="cancleBtn" class="btn btn-finish btn-primary">취소</button>
                                            </div>
                                        </div>
                                        
                                    </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9  pr0 padding-top-40 properties-page" style="width:950px;height:1000px;">
                    <div class="col-md-12 clear"> 
                        <div class="col-xs-10 page-subheader sorting pl0">
                           <ul class="sort-by-list">
                                <li class="active">
                                	<select class="btn dropdown-toggle btn-default" id="filter" name="filter">
		                              <!-- <select class="selectpicker" id="filter" name="filter"> -->
										<option>선택</option>
										<option>이름</option>	
										<option>아이디</option>		
										<option>닉네임</option>	
										<option>전화번호</option>	
									</select>                                      
                                </li>
                                <li class="">
                                    <input style="width:400px;" class="form-control" type="search" size="80px" id="searchTF" name="search">
                                </li>
                                <li class="">
                                    <button class="btn btn-finish btn-primary" type="button" id="selecthBtn" name="selecthBtn" onclick="selectBtnClick();">조회</button>
                                </li>
                                <li class="">
                                    <button class="btn btn-finish btn-primary" type="button" id="listBtn" name="listBtn" onclick="paging(1);">전체조회</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                     <div class="col-md-12 clear"> 
                    	<table class="table" id="table2">
                    		<thead>
                            <tr>
								<th width="25">선택</th>
								<th width="100">이름</th>
								<th width="100">아이디</th>
								<th width="100">닉네임</th>
								<th width="100">생년월일</th>
								<th width="100">성별</th>
								<th width="100">전화번호</th>
								<th width="100">이메일</th>
								<th width="100">주소</th>
								<th width="100">포인트</th>
							</tr>
							</thead>
							<tbody id="t1">
							</tbody>
						</table>
                    </div>
                    <div class="col-md-12"> 
                        <div class="pull-right">
                            <div class="pagination">
                                <ul id="domain">
        
                                </ul>
                            </div>
                        </div>                
                    </div>    
                </div>  
                </div>              
            </div>
</div><!-- properties-area -->
 <%@ include file="../../footer.jsp"%>