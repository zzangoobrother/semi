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
					<form action="" class=" form-inline">
						<div class="col-md-12">
							<div class="col-md-4">
								<input type="text" class="form-control" placeholder="Key word">
							</div>
							<div class="col-md-4">
								<select id="lunchBegins" class="selectpicker"
									data-live-search="true" data-live-search-style="begins"
									title="Select your city">
									<option>New york, CA</option>
									<option>Paris</option>
									<option>Casablanca</option>
									<option>Tokyo</option>
									<option>Marraekch</option>
									<option>kyoto , shibua</option>
								</select>
							</div>
							<div class="col-md-4">
								<select id="basic" class="selectpicker show-tick form-control">
									<option>-Status-</option>
									<option>Rent</option>
									<option>Boy</option>
									<option>used</option>

								</select>
							</div>
						</div>
						<div class="col-md-12 ">
							<div class="search-row">

								<div class="col-sm-3">
									<label for="price-range">Price range ($):</label> <input
										type="text" class="span2" value="" data-slider-min="0"
										data-slider-max="600" data-slider-step="5"
										data-slider-value="[0,450]" id="price-range"><br />
									<b class="pull-left color">2000$</b> <b
										class="pull-right color">100000$</b>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<label for="property-geo">Property geo (m2) :</label> <input
										type="text" class="span2" value="" data-slider-min="0"
										data-slider-max="600" data-slider-step="5"
										data-slider-value="[50,450]" id="property-geo"><br />
									<b class="pull-left color">40m</b> <b class="pull-right color">12000m</b>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<label for="price-range">Min baths :</label> <input type="text"
										class="span2" value="" data-slider-min="0"
										data-slider-max="600" data-slider-step="5"
										data-slider-value="[250,450]" id="min-baths"><br />
									<b class="pull-left color">1</b> <b class="pull-right color">120</b>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<label for="property-geo">Min bed :</label> <input type="text"
										class="span2" value="" data-slider-min="0"
										data-slider-max="600" data-slider-step="5"
										data-slider-value="[250,450]" id="min-bed"><br /> <b
										class="pull-left color">1</b> <b class="pull-right color">120</b>
								</div>
								<!-- End of  -->

							</div>

							<div class="search-row">

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> Fire
											Place(3100)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> Dual
											Sinks(500)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> Hurricane
											Shutters(99)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> Swimming
											Pool(1190)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> 2
											Stories(4600)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> Emergency
											Exit(200)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> Laundry
											Room(10073)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> Jog Path(1503)
										</label>
									</div>
								</div>
								<!-- End of  -->

								<div class="col-sm-3">
									<div class="checkbox">
										<label> <input type="checkbox"> 26'
											Ceilings(1200)
										</label>
									</div>
								</div>
								<!-- End of  -->
							</div>
						</div>
					</form>
				</div>
			</div>

			 <div class="col-md-12  clear">
				

				<div class="col-xs-2 layout-switcher">
					<a class="layout-list" href="javascript:void(0);"> <i
						class="fa fa-th-list"></i>
					</a> <a class="layout-grid active" href="javascript:void(0);"> <i
						class="fa fa-th"></i>
					</a>
				</div>
				
			</div> 

			<div class="col-md-12 clear ">
				<div id="list-type" class="proerty-th">
					<% for (Product p : list) { %>
					<div class="col-sm-6 col-md-3 p0" >
						<div class="box-two proerty-item" >
							<div class="item-thumb">
								<a
									href="/semi/pdetail.bd?pname=<%=p.getP_name()%>"><img
									src="<%=p.getP_main_image().split(",")[0]%>"></a>
							</div>

							<div class="item-entry overflow">
								<h5>
									<a href="/semi/pdetail.bd?pname=<%=p.getP_name()%>"><%=p.getP_name() %></a>
								</h5>
								<div class="dot-hr"></div>
								<span class="pull-left"><b> 가격 :</b></span> <span
									class="proerty-price pull-right"><%=p.getP_price()%>원</span>
								<p style="display: none;"></p>
								
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