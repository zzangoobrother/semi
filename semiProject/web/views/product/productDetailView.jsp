<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="productsError.jsp"%>
<%@ page import="semi.products.model.vo.Product, java.util.ArrayList" %>
<%
   Product product = (Product)request.getAttribute("product");
   ArrayList<String> list = (ArrayList<String>)request.getAttribute("list");
   String[] slideimg = product.getP_main_image().split(",");
   
	
   
%>
<%@ include file="../../header.jsp" %>

      <script type="text/javascript" src="/semi/resources/js/moment.min.js"></script>
      <script type="text/javascript" src="/semi/resources/js/daterangepicker.js"></script>
      
      <link rel="stylesheet" href="/semi/resources/css/daterangepicker.css">
         
      
       <script>

       
         $(function() {
            
            
           $('input[name="daterange"]').daterangepicker({
              autoUpdateInput: false,
             opens: 'left'
             
           }, function(start, end, label) {
             console.log("selected date " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
             
             
              
               var startDate = new Date(start.format('YYYY-MM-DD'));
               var endDate = new Date(end.format('YYYY-MM-DD'));
               
               var diffDay = endDate - startDate;
               var currDay = 24 * 60 * 60 * 1000;
               
               var totalHours = endDate.getDate() - startDate.getDate();
               
                var pPrice = <%= product.getP_price() %>;
            
               console.log("일 가격" + pPrice);
               console.log("몇 박 며칠 인가염? : " + totalHours);
               
               
               if(endDate < startDate){
                  
                  alert("날짜를 다시 선택 해주세요.");
                  
               }else{
                  document.getElementById("dateSelected").innerHTML = start.format('YYYY-MM-DD') + "부터 " + end.format('YYYY-MM-DD') + "까지";
                  
                  document.getElementById("rentaldate").innerHTML = parseInt(diffDay/currDay) + "일";
                  
                  document.getElementById("totalPrice").innerHTML = (parseInt(diffDay/currDay)) * (pPrice);  
               };       
               
               
               
             
           });
         });
         </script>  
      
      
      

<div class="page-head">
   <div class="container">
      <div class="row">
         <div class="page-head-content">
            <h1 class="page-title"><%= product.getP_name() %></h1>
         </div>
      </div>
   </div>
</div>

<div class="content-area single-property" style="background-color: #FCFCFC;">&nbsp;
            <div class="container">   

                <div class="clearfix padding-top-40" >

                    <div class="col-md-8 single-property-content prp-style-1" style="width: 66.66666667%">
                        <div class="row">
                            <div class="light-slide-item">            
                                <div class="clearfix">
                                    <ul id="image-gallery" class="gallery list-unstyled cS-hidden" style="width:3756px;">
                                    <% for(String si : slideimg ) {%>
                                       
                                        <li data-thumb="<%= si %>"> 
                                            <img src="<%= si %>" />
                                        </li>
                                    <% } %>   
             
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="single-property-wrapper">
                            <div class="single-property-header">                                          
                                <h1 class="property-title pull-left"><%=product.getP_name() %></h1>
                                <span class="property-price pull-right"><%=product.getP_price() %>원</span>
                            </div>





                            <div class="section">
                                <h4 class="s-property-title">Description</h4>
                                <div class="s-property-content">
                                    <p>Nulla quis dapibus nisl. Suspendisse ultricies Nulla quis dapibus nisl. Suspendisse ultricies commodo arcu nec pretium. Nullam sed arcu ultricies commodo arcu nec pretium. Nullam sed arcu ultricies Nulla quis dapibus nisl. Suspendisse ultricies commodo arcu nec pretium. Nullam sed arcu ultricies Nulla quis dapibus nisl. Suspendisse ultricies commodo arcu nec pretium. Nullam sed arcu ultricies                                </p>
                                 
                                </div>
                            </div>
                            
                     
                          
                          
                              
                            
                            
                            <!-- End description area  -->

                            <div class="section additional-details">

                                <h4 class="s-property-title">물품 설명</h4>

                                <ul class="additional-details-list clearfix">
                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">물품이름</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry"><%= product.getP_name() %></span>
                                    </li>

                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">대여가격</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry"><%= product.getP_price() %> 원</span>
                                    </li>
                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">수량</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry"><%= product.getP_count() %></span>
                                    </li>

                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">보유한 동사무소</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry"></span>
                                    </li>


                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">View</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry">Intracoastal View,Direct ew</span>
                                    </li>

                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">Waterfront Description:</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry">Intracoastal Front,Ocean Access</span>
                                    </li> 

                                </ul>
                            </div>  
                            
                            
                            
                            <!-- End additional-details area  -->

                            

                            <div class="section property-video"> 
                                <h4 class="s-property-title">상세이미지</h4> 
                                <div>
                                    <a title="상세이미지">
                                        <img src="<%=product.getP_detail_image() %>" class="img-responsive wp-post-image" alt="Exterior">            
                                    </a>
                                </div>
                            </div>
                            <!-- End video area  -->
                            
                            
                            
                            
                            

                            <div class="section property-share"> 
                                <h4 class="s-property-title">Share width your friends </h4> 
                                <div class="roperty-social">
                                    
                                </div>
                            </div>
                            <!-- End video area  -->
                            
                        </div>
                    </div>


                    <div class="col-md-4 p0" style="width: 33.33333333%;">
                        <aside class="sidebar sidebar-property blog-asside-right">
                            <div class="dealer-widget">
                                <div class="dealer-content">
                                    <div class="inner-wrapper">

                                        <div class="clear">
                                            
                                            <div class="col-xs-8 col-sm-8 ">
                                                <h3 class="dealer-name">
                                                    <a href=""><%=product.getP_item()  %></a> <br>
                                                    <span><%=product.getP_name() %></span>        
                                                </h3>
                                               
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                  
                  
                  
                  
                  
                         <div class="panel panel-default sidebar-menu similar-property-wdg wow fadeInRight animated">
                                <div class="panel-heading">
                                    <h3 class="panel-title">물품 선택</h3>
                                </div>
                                <div class="panel-body recent-property-widget">
                                        <ul>
                                        <li>
                                            <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6>물품&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h6>
                                                
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px;">
                                                 
                                           
                                           <select id="selectpicker" class="selectpicker" data-live-search="true" data-live-search-style="begins" title="주민센터 선택" onchange="centerSelect()">

                                                
                                              <% for(String of : list ) { %>
                                              <option value="<%= of %>"><%= of %></option>
                                              <% } %>
                                             </select> 
                                              
                                             
                                           
                                                
                                            </div>
                                            <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6>대여가격 : </h6>
                                                
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px;">
                                                <h6><%= product.getP_price() %> 원</h6>
                                           
                                                
                                            </div>
                                            
                                            
                                            
                                            
                                            
                                            <script>
                                                function centerSelect(){
                                                  var x = document.getElementById("selectpicker").value;
                                                  document.getElementById("selected").innerHTML = x;
                                                  
                                               } 
                                            
                                            /*    function dateSelect(){
                                                  var d = document.getElementById("dateSelect").value;
                                                  document.getElementById("dateSelected").innerHTML = "선택 날짜 : " + d;
                                               } */
                                               
                                               
                                               
                                               
                                               
                                            </script>
                                        </li>
                                        
                                        
                                        <li>
                                           <div class="rentaldate">
                                             <input type="text" id="dateSelect" name="daterange" class="daterange" onchange="dateSelect()" value="대여날짜를 선택하세요" style="outline: 0;
                                                                                                       border: none;
                                                                                                       width: 100%;
                                                                                                       height: inherit;
                                                                                                       color: #333333;
                                                                                                       font-size: 16px;
                                                                                                       padding: 5px 15px;
                                                                                                       border-radius: 3px;"/> 
                                           
                                           </div>
                                        </li>
                                        
                                      

                                    </ul>
                                </div>
                            </div>         
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                      <script type="text/javascript">
                      
                      $(document).ready(function(){
                         $("#add").click(function(){
                           if( !localStorage.<%= product.getP_name() %> ){
                             localStorage.<%= product.getP_name() %> = "[]";
                           }               
                           var list = JSON.parse(localStorage.<%= product.getP_name() %>);   
                           if( list.indexOf($(".pdname").text()) == -1 ){
                             list.push($(".pdname").text());
                             
                             
                           }if( list.indexOf($(".rentaldate").text()) == -1 ){
                             
                             list.push($(".rentaldate").text());
                             console.log(list.pop($("localStorage.<%= product.getP_name() %>")));
                             
                           }if( list.indexOf($(".pdimg").text()) == -1 ){
                               
                               list.push($(".pdimg").text());
                               
                             }
                            if( list.indexOf($(".selected").text()) == -1 ){
                                 
                                 list.push($(".selected").text());
                                 
                               } 
                          
                           
                           if( list.indexOf($(".totalPrice").text()) == -1 ){
                               
                               list.push($(".totalPrice").text());
                               
                             }
                           
                             
                           
                           
                           
                           
                           localStorage.<%= product.getP_name() %> = JSON.stringify(list);
                           $("#display").html(localStorage.<%= product.getP_name() %>);
                         }) 
                         
                         $("#remove").click(function(){
                            if(localStorage.<%= product.getP_name() %>){
                              var list = JSON.parse(localStorage.<%= product.getP_name() %>);
                              var idx = list.indexOf($(".pdname").text());
                              if( idx > -1 ){
                                list.splice(idx,1);
                              }
                              localStorage.<%= product.getP_name() %> = JSON.stringify(list);
                            }
                            $("#display").html(localStorage.<%= product.getP_name() %>);
                         });
                         
                         
                         
                         $("#removeAll").click(function(){
                            
                            localStorage.clear("<%= product.getP_name() %>");
                            
                         });
                         $("#display").html(localStorage.<%= product.getP_name() %>);
                         
                        
                         
                         
                         
                         
                       }); 
                      
                      
                      
                      
                      
                      </script>    
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                                             

                            <div class="panel panel-default sidebar-menu wow fadeInRight animated">
                                <div class="panel-heading">
                                    <h3 class="panel-title"> 선택 정보  </h3>
                                </div>
                                
                                <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6>동사무소 : &nbsp;</h6>
                                                
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px; line-height: 35px;">
                                                 
                                   <a id="selected" class="selected" ></a><br>
                                </div>
                                
                                
                                <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6>선택 날짜 :</h6>
                                                
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px; line-height: 35px;">
                                                 
                                   <a id="dateSelected" class="dateSelected"></a><br>
                                </div>
                                
                                
                                <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6>대여 기간 :  &nbsp;</h6>
                                                
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px; line-height: 35px;">
                                                 
                                   <a id="rentaldate" class="rentaldate" ></a><br>
                                </div>
                                
                                <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6> &nbsp; &nbsp;총 가격 :  &nbsp;</h6>
                                                
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px; line-height: 35px;">
                                                 
                                   <a id="totalPrice" class="totalPrice" ></a ><br><br>
                                </div>
                                
                                
                                
                                
                                
                                   <a id="selected" class="selected" ></a><br>
                                   <a id="dateSelected" class="dateSelected"></a><br>
                                   <a id="rentaldate" class="rentaldate" ></a><br>
                                   <a id="totalPrice" class="totalPrice" ></a ><br><br>
                                   <a class="pdimg"><%= product.getP_main_image().split(",")[0] %></a><br>
                                   <a class="pdname"><%= product.getP_name() %></a>

                  <div style="width: 100%;">
                                  <input type="button" id="add" value="add">
                                           <input type="button" id="remove" value="remove">
                                           <input type="button" id="removeAll" value="removeAll"> 

                     <div class="panel-body search-widget" >
                        <fieldset>
                           <div class="row" >
                              
                                 <input class="button btn largesearch-btn" style="width: 25%;  margin-left:5%;" type="button" value="장바구니" onclick="location.href='/semi/select'"> 
                                 <input class="button btn largesearch-btn" style="width: 25%; margin-left:5%;" type="button" value="목록보기" onclick="location.href='/semi/plist'"> 
                                 <input class="button btn largesearch-btn" style="width: 25%; margin-left:5%;" type="button" value="대여하기" onclick="location.href='/semi/views/payment/paymentProgressView.jsp'">
                              
                           </div>
                        </fieldset>
                     </div>
                  </div>




               </div>
               



               

                        </aside>
                    </div>
                </div>

            </div>
        </div>
<script>
$(document).ready(function () {

    $('#image-gallery').lightSlider({
        gallery: true,
        item: 1,
        thumbItem: 9,
        slideMargin: 0,
        speed: 500,
        auto: true,
        loop: true,
        onSliderLoad: function () {
            $('#image-gallery').removeClass('cS-hidden');
        }
    });
});
</script>
<%@ include file="../../footer.jsp" %>