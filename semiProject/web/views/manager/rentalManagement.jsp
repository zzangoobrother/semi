<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
	
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
	/* if(sysMonth > 10)
		sysMonth = "0" + sysMonth; */
	var sysDay = sysDate.getDate();
	/* if(sysDay > 10)
		sysDay = 0 + sysDay; */
	
	
	
	
	$(function(){
		//#table2 사이즈 변경
		//$("#table2 tr").not($("td")).css("width", "100px");

		//#table1 의 모든 필드에 readonly 속성 추가
		$("#table1 input").attr("readonly", true);
		
		//$("#table1 input").attr("readonly", false);
		$("body").append("<td>");
		$("#table1 input").css("font-size", "14px");
		
	}); //document.ready

	//-------------------------------------------------------------
	//등록 radio
	function enrollChecked(){
		$("#saveBtn").attr("style", "display:inline");
		$("#editSaveBtn").attr("style", "display:none");
		$("#returnBtn").attr("style", "display:none");
		
		$("#table1 input").not($("#rnum")).not($("#rdate")).not($("#rstartdate")).attr("readonly", false);
		$("#rrastdate").attr("style", "display:none");
		$("#rbookdate").attr("style", "display:none");
		
		
		
		$("#table1 input").val("");
		//등록 라디오 버튼 클릭시 물품 중에서 대여상태가 대기상태인
		//품목을 객체로 받아와서 대여상품 콤보박스에 실시간 출력되도록 처리
		//아이디 입력 후 유효성 조회하기 > 이것도 ajax 호출로
		//alert 창 띄워서 존재하는 아이디인지 확인 //id말고 다른 것도 받아야 할 듯
		//일단은 품목출력만
		
		
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
		
		return false;
	}
	//수정 radio
	function editChecked(){
		$("#saveBtn").attr("style", "display:none");
		$("#editSaveBtn").attr("style", "display:inline");
		$("#returnBtn").attr("style", "display:inline");
		
		$("#table1 input").attr("readonly", false);
		$("#mid").attr("readonly", true);
		//$("#form1").attr("action", "/semi/medit");
		return false;
	}

	//-------------------------------------------------------------
	
	//대여 등록
	function enrollClick(){
		
		//rentalInfo.retalNum = $("#rnum").val();
		rentalInfo.retalNum = $("#pnum").val();
		rentalInfo.retalNum = $("#mid").val();
		rentalInfo.retalNum = $("#rprice").val();
		rentalInfo.retalNum = $("#rdate").val();
		rentalInfo.retalNum = $("#rstartdate").val();
		rentalInfo.retalNum = $("#rreturndate").val();
		//rentalInfo.retalNum = $("#rrastdate").val();
		rentalInfo.retalNum = $("#rbookdate").val();
		rentalInfo.retalNum = $("#pstate").val();
		rentalInfo.retalNum = $("#rcount").val();
		
		var jsonStr = JSON.stringify(rentalInfo);
		//var json = JSON.parse(jsonStr);

		$.ajax({
			url : "/semi/renroll",
			type : "post",
			data : {"jsonStr" : jsonStr},
			//dataType : "json",
			success : function(data){
				if(data >= 1)
					alert("대여 등록 완료");
				else
					alert("대여 등록 실패");
				paging(currentPage);
			}, //success
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
			} //error
		});//ajax
		return false;
	} //enrollClick
	
	//회원 수정
	function editClick(memberInfo){
		var birth1 = $("#birth1").val();
		var b1 = birth1.substring(2, 4);
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
		memberInfo.msno = (b1 + b2 + b3);
		
		if($("#T").is(":checked") == true)
			memberInfo.mgender = "남";
		else
			memberInfo.mgender = "여";

		memberInfo.mphone = $("#mphone").val();
		memberInfo.memail = $("#memail").val();
		memberInfo.maddress = $("#maddress").val();
		memberInfo.mpoint = $("#mpoint").val(); 
		
		var jsonStr = JSON.stringify(memberInfo);

		$.ajax({
			url : "/semi/medit",
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
		

		return false;
	}
	
	//회원 삭제
	function deleteClick(memberInfo){
		var mId = memberInfo.mid;
		$.ajax({
			url : "/semi/mdelete",
			type : "post",
			data : {"mId" : mId},
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
		$("#mid").val(memberInfo.mid);
		$("#mnick").val(memberInfo.mnick);
		$("#mpwd").val(memberInfo.mpwd);
		$("#mpwd2").val(memberInfo.mpwd);
		
		var sno = memberInfo.msno;	
		var year = sno.substring(0, 2);
		if(year < 19)
			year = (20 + year);
		
		else
			year = (19 + year);
		
		var month = parseInt(sno.substring(2, 4));
		//if(month > 10)
		//	month = month.substring(1, 2);
		
		var day = parseInt(sno.substring(4, 6));
		//if(day > 10)
		//	day = day.substring(1, 2);
		//alert(year + ", " + month + ", " + day);
		$("#birth1").val(year);
		$("#birth2").val(month);
		$("#birth3").val(day);
			//alert(memberInfo.mgender);
		if(memberInfo.mgender == "남"){
			$("#T").attr("checked", true);
			$("#F").attr("checked", false);
		}else if(memberInfo.mgender == "여"){
			$("#F").attr("checked", true);
			$("#T").attr("checked", false);
		}
		
		$("#mphone").val(memberInfo.mphone);
		$("#memail").val(memberInfo.memail);
		$("#maddress").val(memberInfo.maddress);
		$("#mpoint").val(memberInfo.mpoint);
		
		return false;

	}
	//-------------------------------------------------------------
	
	//회원 리스트 전체 조회
	function paging(page){
		

		$.ajax({
			url : "/semi/mlist",
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
				for(var p = startPage; p <= endPage; p++){ 
					if(p == currentPage){
						$("#domain").html(domainHtml + "<font color='red' size='4'>[" + p + "]</font>");
					}else{ 
						$("#domain").html(domainHtml + "<a href='#' onclick='paging(" + p + ")'>" + p + "</a>");
					}
					var domainHtml = $("#domain").html();
				}
				
				//맨끝
				$("#finalBtn").attr("onclick", "paging(" + maxPage + ")");
				
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
			url : "/semi/mselect",
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

</script>

        <!-- Left Panel -->

     <aside id="left-panel" class="left-panel" style="background-color:#ffcc00;padding:0px;border:0px;box-sizing:border-box;">
       <div class="navbar navbar-expand-sm nabar-default" style="background-color:#ffcc00;padding:0px;border:0px;box-sizing:border-box;">
        <!-- <nav class="navbar navbar-expand-sm navbar-default" style="background-color:#ffcc00;width:350px;box-sizing:border-box;"> -->  
             <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
                    <!-- <i class="fa fa-bars"></i> -->
                </button>
               <a class="navbar-brand" href="./"><div style="color:black;">관리자 페이지</div></a>
                <!-- <a class="navbar-brand hidden" href="./"><img src="images/logo2.png" alt="Logo"></a> -->
            </div> 
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li>
                    <div style="color:black;">
                        <strong><a href="/semi/memberManagement.jsp">대여관리</a><br>
                        <a href="">대여관리</a></strong>
                    </div>
                    </li>  
<!-- rentalDetailView
 -->            <div class="col-lg-6">
            <div class="card-body" style="width:380px;hegiht:550px;">
 			<div class="card" id="table1">
                      <div class="card-header">
                        <strong>대여 상세 정보</strong>
                        <div align="right">
                        <input type="radio" id="radio1" name="radioC" onclick="enrollChecked();">등록
						<input type="radio" id="radio2" name="radioC" onclick="editChecked();">수정
						</div>
                      </div>
                      <div class="card-body card-block" style="font-size:14px;">
                        <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
       
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여번호</label></div>
                            <div class="col-12 col-md-9" ><input type="text" id="rnum" name="rnum" placeholder="대여번호" class="form-control"><small class="help-block form-text">신규 등록시 자동 생성됩니다.</small></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">물품번호</label></div>
                            <div class="col-12 col-md-9"><input type="text" id="pnum" name="pnum" placeholder="물품번호" class="form-control"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여상품</label></div>
                            <div class="col-12 col-md-9"><input type="text" id="rname" name="rname" placeholder="대여상품" class="form-control"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여금액</label></div>
                            <div class="col-12 col-md-9"><input type="text" id="rprice" name="rprice" placeholder="대여금액" class="form-control"></div>
                          </div>                              
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여수량</label></div>
                            <div class="col-12 col-md-9"><input type="text" id="rcount" name="rcount" placeholder="대여수량" class="form-control"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여접수일자</label></div>
                            <div class="col-12 col-md-9"><input type="date" id="rdate" name="rdate"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여실행일자</label></div>
                            <div class="col-12 col-md-9"><input type="date" id="rstartdate" name="rstartdate"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">반납접수일자</label></div>
                            <div class="col-12 col-md-9"><input type="date" id="rreturndate" name="rreturndate"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">반납실행일자</label></div>
                            <div class="col-12 col-md-9"><input type="date" id="rrastdate" name="rrastdate"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">예약일자</label></div>
                            <div class="col-12 col-md-9"><input type="date" id="rbookdate" name="rbookdate"></div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여상태</label></div>
                            <div class="col-12 col-md-9">
                            <select id="filter" name="filter">
							<option>대기</option>
							<option>대여중</option>						
							</select>
                            </div>
                          </div>
                          <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">대여자아이디</label></div>
                            <div class="col-12 col-md-9"><input type="text" id="mid" name="mid" placeholder="대여자아이디" class="form-control"></div>
                          </div>                        	

                         
                          <div align="center">
                      		<button type="button" id="saveBtn" name="saveBtn"  onclick="saveClick();" style="display:none;">저장</button>
							<button type="button" id="editSaveBtn" name="editSaveBtn" onclick="editSaveClick(memberInfo);" style="display:none;">완료</button>
							<button type="button" id="returnBtn" name="returnBtn" onclick="returnClick(memberInfo);" style="display:none;">반납</button>
							<button type="reset" id="cancleBtn" name="cancleBtn">취소</button>
						  </div>
						 </form>
                      </div>
					</div>
				</div>  
				
				
				
				
				
				            <!-- </div>  -->
            
</div></ul>
            </div>
            </div>
        <!-- </nav> -->
    </aside>  <!-- /#left-panel -->
        <div class="breadcrumbs" > 
             <div class="col-sm-4"> 
                 <div class="page-header float-left">
                    <div class="page-title">
                        <h2 >회원관리</h2>                   
                    </div>                   
                </div> 
             </div> 
        </div>

        <div class="content mt-3" style="width:2000px;height:500px;">
            <div class="animated fadeIn">
                <div class="row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">
                        <select class="btn btn-warning" id="filter" name="filter">
							<option>선택</option>
							<option>이름</option>	
							<option>아이디</option>		
							<option>닉네임</option>	
							<option>전화번호</option>	
						</select>
						<input style="border:3px;" type="search" size="80px" id="searchTF" name="search">
						<button class="btn btn-warning" type="button" id="selecthBtn" name="selecthBtn" onclick="selectBtnClick();">조회</button>
		                <button class="btn btn-warning" type="button" id="listBtn" name="listBtn" onclick="paging(1);">전체조회</button>

                        </div>
                        <div class="card-body">
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

				
                      <!-- 페이징 처리 -->
					<div id="paging1" align="center" style="text-align: center">
					<a id="firstBtn" href="#" onclick="paging(1);">[처음으로]</a>
					<div id="domain" style="text-align: center"></div>
					<a id="finalBtn" href="#" onclick="">[끝으로]</a>
					</div>
                        </div>
                    </div>
                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->
    </div><!-- /#right-panel -->

    <!-- Right Panel -->


<%@ include file="../../footer.jsp" %>