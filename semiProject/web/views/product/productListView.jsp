<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="./productsError.jsp"%>
<%@ page import="semi.products.model.vo.Product, java.util.ArrayList"%>
<%
	ArrayList<Product> list = (ArrayList<Product>)request.getAttribute("list");	
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>
<%@ include file="../../header.jsp"%>

<!-- property area -->
<div class="properties-area recent-property"
	style="background-color: #FFF;">
	<div class="container">
		<div class="row  pr0 padding-top-40 properties-page">
			<div class="col-md-12 padding-bottom-40 large-search">
				<div class="search-form wow pulse">

					   <form action="/semi/psearch" class=" form-inline" method="post" style="margin-left : 50px;"> 

                                <div class="form-group">                                   
                                    <select id="lunchBegins" name="localselect" class="selectpicker" data-live-search="true" data-live-search-style="begins" title="지역">

                                        <option value="종로구">종로구</option>
                                        <option value="중구">중구</option>
                                        <option value="용산구">용산구</option>
                                        <option value="성동구">성동구</option>
                                        <option value="광진구">광진구</option>
                                        <option value="동대문구">동대문구</option>
                                        <option value="중랑구">중랑구</option>
                                        <option value="성북구">성북구</option>
                                        <option value="강북구">강북구</option>
                                        <option value="도봉구">도봉구</option>
                                        <option value="노원구">노원구</option>
                                        <option value="은평구">은평구</option>
                                        <option value="서대문구">서대문구</option>
                                        <option value="마포구">마포구</option>
                                        <option value="양천구">양천구</option>
                                        <option value="강서구">강서구</option>
                                        <option value="구로구">구로구</option>
                                        <option value="금천구">금천구</option>
                                        <option value="영등포구">영등포구</option>
                                        <option value="동작구">동작구</option>
                                        <option value="관악구">관악구</option>
                                        <option value="서초구">서초구</option>
                                        <option value="강남구">강남구</option>
                                        <option value="송파구">송파구</option>
                                        <option value="강동구">강동구</option>

                                    </select>
                                </div>
                                <!-- <div class="form-group">                                     
                                    <select id="basic" class="selectpicker show-tick form-control">
                                        <option>분류</option>
                                        <option>절단공구 </option>
                                        <option>드릴공구</option>
                                        <option>충전공구</option>  
                                        <option>기타공구</option>
                                        <option>기타생활용품</option>    
                                        

                                    </select>
                                </div> -->
                                 <div class="form-group">
                                    <input type="text" class="form-control" placeholder="Key word" name="keyword" id="keyword">
                                </div>
                                <button class="btn search-btn" type="submit"><i class="fa fa-search"></i></button>
								
                            </form>
				</div>
			</div>

			<div class="col-md-12  clear">
				<div class="col-xs-10 page-subheader sorting pl0">
					<ul class="sort-by-list">
						<li class="active"><a href="javascript:void(0);"
							class="order_by_date" data-orderby="property_date"
							data-order="ASC"> Property Date <i
								class="fa fa-sort-amount-asc"></i>
						</a></li>
						<li class=""><a href="javascript:void(0);"
							class="order_by_price" data-orderby="property_price"
							data-order="DESC"> Property Price <i
								class="fa fa-sort-numeric-desc"></i>
						</a></li>
					</ul>
					<!--/ .sort-by-list-->

					<div class="items-per-page">
						<label for="items_per_page"><b>Property per page :</b></label>
						<div class="sel">
							<select id="items_per_page" name="per_page">
								<option value="3">3</option>
								<option value="6">6</option>
								<option value="9">9</option>
								<option selected="selected" value="12">8</option>
								<option value="15">15</option>
								<option value="30">30</option>
								<option value="45">45</option>
								<option value="60">60</option>
							</select>
						</div>
						<!--/ .sel-->
					</div>
					<!--/ .items-per-page-->
				</div>

				<div class="col-xs-2 layout-switcher">
					<a class="layout-list" href="javascript:void(0);"> <i
						class="fa fa-th-list"></i>
					</a> <a class="layout-grid active" href="javascript:void(0);"> <i
						class="fa fa-th"></i>
					</a>
				</div>
				<!--/ .layout-switcher-->
			</div>

			<div class="col-md-12 clear ">
				<div id="list-type" class="proerty-th">
					<% for (Product p : list) { %>
					<div class="col-sm-6 col-md-3 p0">
						<div class="box-two proerty-item">
							<div class="item-thumb">
								<a
									href="/semi/pdetail.bd?pname=<%=p.getP_name()%>&page=<%=currentPage%>"><img
									src="<%=p.getP_main_image().split(",")[0]%>"></a>
							</div>

							<div class="item-entry overflow">
								<h5>
									<a
										href="/semi/pdetail.bd?pname=<%=p.getP_name()%>&page=<%=currentPage%>"><%=p.getP_name() %></a>
								</h5>
								<div class="dot-hr"></div>
								<span class="pull-left"><b> 가격 :</b></span> <span
									class="proerty-price pull-right"><%=p.getP_price()%>원</span>
								<p style="display: none;">Suspendisse ultricies Suspendisse
									ultricies Nulla quis dapibus nisl. Suspendisse ultricies
									commodo arcu nec pretium ...</p>
								<div class="property-icon">
									<img src="/semi/assets/img/icon/bed.png">(5)| <img
										src="/semi/assets/img/icon/shawer.png">(2)| <img
										src="/semi/assets/img/icon/cars.png">(1)
								</div>

							</div>


						</div>
					</div>
					<% } %>


				</div>
			</div>


			<div class="col-md-12 clear">
				<div class="pull-right">
					<div class="pagination">
						<ul>
							<% if (currentPage > 1){ %>
							<li>
								<a href="/semi/plist?page=1"><<</a>
							<li>
							<% } %> 
							
							<% if (currentPage == 1) { %>
								
							<% } else {%>
								<li>
									<a href="/semi/plist?page=<%=currentPage - 1%>"><</a>
								</li>
							<% } %>

							<% for (int p = startPage; p <= endPage; p++) {
									if (p == currentPage) { %>
										<li><a href="#"><font color="red"><%=p%></font></a></li>
									<% } else { %>
										<li><a href="/semi/plist?page=<%=p%>"><%=p%></a></li>
							<%
									}
								}
							%>



							<% if (currentPage == maxPage) { %>
								
							<% } else { %>
								<li>
									<a href="/semi/plist?page=<%= currentPage + 1 %>">></a>
								</li>
							<% } %>

							<% if (currentPage >= maxPage) { %>
								
							<% } else {%>
							<li>
								<a href="/semi/plist?page=<%= maxPage %>">>></a>
							</li>
							<% } %>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<%@ include file="../../footer.jsp"%>