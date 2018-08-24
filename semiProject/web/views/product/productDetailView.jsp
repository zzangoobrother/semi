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
			
		<!-- <script type="text/javascript">
		$(function() {
		
		  $('input[name="datefilter"]').daterangepicker({
		      autoUpdateInput: false,
		      locale: {
		          cancelLabel: 'Clear'
		      }
		  });
		
		  $('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
		      $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
		  });
		
		  $('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
		      $(this).val('');
		  });
		
		});
		</script> -->
		 <script>

		 
			$(function() {
			  $('input[name="daterange"]').daterangepicker({
				  autoUpdateInput: false,
			    opens: 'left'
			    
			  }, function(start, end, label) {
			    console.log("selected date " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
			    document.getElementById("dateSelected").innerHTML = "선택 날짜 : " + start.format('YYYY-MM-DD') + "부터 " + end.format('YYYY-MM-DD') + "까지";
			    
			  });
			});
			</script>  
		
		
		

<div class="page-head">
	<div class="container">
		<div class="row">
			<div class="page-head-content">
				<h1 class="page-title"><%=product.getP_name() %></h1>
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

                            <div class="section property-features">      

                                <h4 class="s-property-title">Features</h4>                            
                                <ul>
                                    <li><a href="properties.html">Swimming Pool</a></li>   
                                    <li><a href="properties.html">3 Stories</a></li>
                                    <li><a href="properties.html">Central Cooling</a></li>
                                    <li><a href="properties.html">Jog Path 2</a></li>
                                    <li><a href="properties.html">2 Lawn</a></li>
                                    <li><a href="properties.html">Bike Path</a></li>
                                    
                                       
                                </ul>
									   
                            </div>
                            <!-- End features area  -->

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
                                    <h3 class="panel-title">Similar Products</h3>
                                </div>
                                <div class="panel-body recent-property-widget">
                                        <ul>
                                        <li>
                                            <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6>물품&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</h6>
                                                
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px;">
                                                <h6><select id="centerSelect" onchange="centerSelect()">
                                        		<option>주민센터 선택</option>
                                        		<% for(String of : list ) { %>
                                        		<option value="<%= of %>"><%= of %></option>
                                        		<% } %>
                                        	</select></h6>
                                        	
                                        	
                                        	
                                                
                                            </div>
                                            <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0" style="width: 85px; height: 35px;">
                                                <h6>대여가격 : </h6>
                                                
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry" style="width: 226.66px; height: 71px;">
                                                <h6><%= product.getP_price() %> 원</h6>
                                        	
                                                
                                            </div>
                                            
                                            
                                            
                                            
                                            
                                            <script>
                                            	function centerSelect(){
                                            		var x = document.getElementById("centerSelect").value;
                                            		document.getElementById("selected").innerHTML = "선택 동사무소 : " + x;
                                            		
                                            	}
                                            
                                            	function dateSelect(){
                                            		var d = document.getElementById("dateSelect").value;
                                            		document.getElementById("dateSelected").innerHTML = "선택 날짜 : " + d;
                                            	}
                                            	
                                            	
                                            	
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
                                        	<!-- <input type="text" id="dateSelect" name="datefilter" onchange="dateSelect()" value="대여날짜를 선택하세요" style="outline: 0;
																																	    border: none;
																																	    width: 100%;
																																	    height: inherit;
																																	    color: #333333;
																																	    font-size: 16px;
																																	    padding: 5px 15px;
																																	    border-radius: 3px;" /> -->
                                        	</div>
                                        </li>
                                        
                                      

                                    </ul>
                                </div>
                            </div>         
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                      <script type="text/javascript">
                      
                      $(document).ready(function(){
                    	  $("#add").click(function(){
                    	    if( !localStorage.test ){
                    	      localStorage.test = "[]";
                    	    }               
                    	    var list = JSON.parse(localStorage.test);
                    	    if( list.indexOf($(".pdname").val()) == -1 ){
                    	      list.push($(".pdname").val());
                    	    }
                    	    localStorage.test = JSON.stringify(list);
                    	    $("#display").html(localStorage.test);
                    	  }) 
                    	  
                    	  $("#remove").click(function(){
                    	     if(localStorage.test){
                    	       var list = JSON.parse(localStorage.test);
                    	       var idx = list.indexOf($(".pdname").val());
                    	       if( idx > -1 ){
                    	         list.splice(idx,1);
                    	       }
                    	       localStorage.test = JSON.stringify(list);
                    	     }
                    	     $("#display").html(localStorage.test);
                    	  });
                    	  $("#display").html(localStorage.test);
                    	});
                      
                      
                      
                      
                      
                      </script>      
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                                             

                            <div class="panel panel-default sidebar-menu wow fadeInRight animated">
                                <div class="panel-heading">
                                    <h3 class="panel-title"> 선택 정보  </h3>
                                </div>
                                
                                	<a id="selected"></a><br>
                                	<a id="dateSelected"></a><br>
                                	<a id="totalprice">총 금액 : </a><br><br>
                                	<a id="pdimg"><%= product.getP_main_image().split(",")[0] %></a>
                                	<a class="pdname"><%= product.getP_name() %></a>
                                
                                <div style="width: 100%; ">
                                        	<input type="button" id="add" value="add">
                                        	<input type="button" id="remove" value="remove">
                                        	<a><input style="width: 30%; border-radius: 3px;" type="button" value="장바구니" onclick="location.href='/semi/select'"  ></a>  &nbsp; 
                                        	<a><input style="width: 30%;" type="button" value="목록보기" onclick="location.href='/semi/plist'"></a> &nbsp; 
                                         	<a><input style="width: 30%;" type="button" value="대여하기" onclick="location.href='/semi/views/payment/paymentProgressView.jsp'"></a>
                                         	
                                </div> 
                                <div id="display" style="border:1px solid gray"></div>
                                
                                
                                
                            </div>
                            

                            <div class="panel panel-default sidebar-menu wow fadeInRight animated" >
                                <div class="panel-heading">
                                    <h3 class="panel-title">Smart search</h3>
                                </div>
                                <div class="panel-body search-widget">
                                    <form action="" class=" form-inline"> 
                                        <fieldset>
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <input type="text" class="form-control" placeholder="Key word">
                                                </div>
                                            </div>
                                        </fieldset>

                                        <fieldset>
                                            <div class="row">
                                                <div class="col-xs-6">

                                                    <select id="lunchBegins" class="selectpicker" data-live-search="true" data-live-search-style="begins" title="Select Your City">

                                                        <option>New york, CA</option>
                                                        <option>Paris</option>
                                                        <option>Casablanca</option>
                                                        <option>Tokyo</option>
                                                        <option>Marraekch</option>
                                                        <option>kyoto , shibua</option>
                                                    </select>
                                                </div>
                                                <div class="col-xs-6">

                                                    <select id="basic" class="selectpicker show-tick form-control">
                                                        <option> -Status- </option>
                                                        <option>Rent </option>
                                                        <option>Boy</option>
                                                        <option>used</option>  

                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>

                                        <fieldset class="padding-5">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <label for="price-range">Price range ($):</label>
                                                    <input type="text" class="span2" value="" data-slider-min="0" 
                                                           data-slider-max="600" data-slider-step="5" 
                                                           data-slider-value="[0,450]" id="price-range" ><br />
                                                    <b class="pull-left color">2000$</b> 
                                                    <b class="pull-right color">100000$</b>                                                
                                                </div>
                                                <div class="col-xs-6">
                                                    <label for="property-geo">Property geo (m2) :</label>
                                                    <input type="text" class="span2" value="" data-slider-min="0" 
                                                           data-slider-max="600" data-slider-step="5" 
                                                           data-slider-value="[50,450]" id="property-geo" ><br />
                                                    <b class="pull-left color">40m</b> 
                                                    <b class="pull-right color">12000m</b>                                                
                                                </div>                                            
                                            </div>
                                        </fieldset>                                

                                        <fieldset class="padding-5">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <label for="price-range">Min baths :</label>
                                                    <input type="text" class="span2" value="" data-slider-min="0" 
                                                           data-slider-max="600" data-slider-step="5" 
                                                           data-slider-value="[250,450]" id="min-baths" ><br />
                                                    <b class="pull-left color">1</b> 
                                                    <b class="pull-right color">120</b>                                                
                                                </div>

                                                <div class="col-xs-6">
                                                    <label for="property-geo">Min bed :</label>
                                                    <input type="text" class="span2" value="" data-slider-min="0" 
                                                           data-slider-max="600" data-slider-step="5" 
                                                           data-slider-value="[250,450]" id="min-bed" ><br />
                                                    <b class="pull-left color">1</b> 
                                                    <b class="pull-right color">120</b>

                                                </div>
                                            </div>
                                        </fieldset>

                                        <fieldset class="padding-5">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <div class="checkbox">
                                                        <label> <input type="checkbox" checked> Fire Place</label>
                                                    </div> 
                                                </div>

                                                <div class="col-xs-6">
                                                    <div class="checkbox">
                                                        <label> <input type="checkbox"> Dual Sinks</label>
                                                    </div>
                                                </div>                                            
                                            </div>
                                        </fieldset>

                                        <fieldset class="padding-5">
                                            <div class="row">
                                                <div class="col-xs-6"> 
                                                    <div class="checkbox">
                                                        <label> <input type="checkbox" checked> Swimming Pool</label>
                                                    </div>
                                                </div>  
                                                <div class="col-xs-6"> 
                                                    <div class="checkbox">
                                                        <label> <input type="checkbox" checked> 2 Stories </label>
                                                    </div>
                                                </div>  
                                            </div>
                                        </fieldset>

                                        <fieldset class="padding-5">
                                            <div class="row">
                                                <div class="col-xs-6"> 
                                                    <div class="checkbox">
                                                        <label><input type="checkbox"> Laundry Room </label>
                                                    </div>
                                                </div>  
                                                <div class="col-xs-6"> 
                                                    <div class="checkbox">
                                                        <label> <input type="checkbox"> Emergency Exit</label>
                                                    </div>
                                                </div>  
                                            </div>
                                        </fieldset>

                                        <fieldset class="padding-5">
                                            <div class="row">
                                                <div class="col-xs-6"> 
                                                    <div class="checkbox">
                                                        <label>  <input type="checkbox" checked> Jog Path </label>
                                                    </div>
                                                </div>  
                                                <div class="col-xs-6"> 
                                                    <div class="checkbox">
                                                        <label>  <input type="checkbox"> 26' Ceilings </label>
                                                    </div>
                                                </div>  
                                            </div>
                                        </fieldset>

                                        <fieldset class="padding-5">
                                            <div class="row">
                                                <div class="col-xs-12"> 
                                                    <div class="checkbox">
                                                        <label>  <input type="checkbox"> Hurricane Shutters </label>
                                                    </div>
                                                </div>  
                                            </div>
                                        </fieldset>

                                        <fieldset >
                                            <div class="row">
                                                <div class="col-xs-12">  
                                                    <input class="button btn largesearch-btn" value="Search" type="submit">
                                                </div>  
                                            </div>
                                        </fieldset>                                     
                                    </form>
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