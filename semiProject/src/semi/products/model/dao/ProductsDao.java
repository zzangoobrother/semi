package semi.products.model.dao;

import static semi.common.JDBCTemplat.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import semi.products.exception.ProductsException;
import semi.products.model.vo.Product;



public class ProductsDao {

	public ProductsDao() {}
	
	public int getListCount(Connection con) throws ProductsException {

		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from (select distinct p_name from TB_PRODUCT)";
		System.out.println("DaoCount");
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new ProductsException("물품이 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(rset);
			close(stmt);
		}
		
		return listCount;
	}

	public ArrayList<Product> selectList(Connection con, int currentPage, int limit) throws ProductsException{

	
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from (select rownum rnum, P_NAME, P_PRICE, P_MAIN_IMAGE from (select * from (select P_NAME, P_PRICE, P_MAIN_IMAGE from tb_product group by P_NAME, P_PRICE, P_MAIN_IMAGE) order by 3)) where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Product p = new Product();

				p.setP_name(rset.getString("p_name"));
				p.setP_price(rset.getInt("p_price"));
				p.setP_main_image(rset.getString("p_main_image"));
			
				
				list.add(p);
			}
			
			if(list.size() == 0)
				throw new ProductsException(
						"물품이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
		
		
		
		
		
	
	}

	public Product selectProducts(Connection con, String pName) throws ProductsException {
		Product product = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select p_name, p_price, p_count, p_main_image, p_detail_image, p_item from (select p_name, p_price, p_count, p_main_image, p_detail_image, p_item from tb_product group by p_name, p_price, p_count, p_main_image, p_detail_image, p_item) where p_name = ?";
		System.out.println(pName);
		System.out.println("Daoselect");
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, pName);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				product = new Product();
				
				product.setP_name(pName);
				product.setP_price(rset.getInt("p_price"));
				product.setP_count(rset.getInt("p_count"));
				product.setP_main_image(rset.getString("p_main_image"));
				product.setP_detail_image(rset.getString("p_detail_image"));
				product.setP_item(rset.getString("p_item"));
				
				System.out.println(product.toString());
						
			}else{
				throw new ProductsException(pName + " 글 조회 실패!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return product;
	}

	public ArrayList<String> selectOffice(Connection con, String pName) throws ProductsException{
		
		ArrayList<String> list = new ArrayList<String>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select P_LOCAL  from tb_product where P_NAME = ? ";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, pName);
			
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
			 list.add(rset.getString("P_LOCAL"));
			}
			
			if(list.size() == 0)
				throw new ProductsException(
						"물품이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
		
		
		
		
	}

	public ArrayList<Product> selectProduct(Connection con, String keyword, String localselect) throws ProductsException{
	      ArrayList<Product> list = new ArrayList<Product>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query1 = "select * from tb_product where rowid in (select max(rowid) from tb_product group by p_name)";
	      String query2 = "select * from tb_product where p_name like ? and rowid in (select max(rowid) from tb_product group by p_name)";
	      String query3 = "select * from tb_product join tb_local on (p_local = l_name) where l_local like ?";
	      String query4 = "select * from tb_product join tb_local on (p_local = l_name) where l_local like ? and p_name like ?";
	      
	      try {
	         if(keyword.equals("no1") && localselect.equals("no2")){
	            pstmt = con.prepareStatement(query1);
	         }else if(!keyword.equals("no1") && localselect.equals("no2")){
	            pstmt = con.prepareStatement(query2);
	            pstmt.setString(1, "%" + keyword + "%");
	            System.out.println(keyword);
	            System.out.println(localselect);
	         }else if(keyword.equals("no1") && (!localselect.equals("no2"))){
	            pstmt = con.prepareStatement(query3);
	            pstmt.setString(1, "%" + localselect + "%");
	            System.out.println(keyword);
	            System.out.println(localselect);
	            
	         }else if((!keyword.equals("no1")) && (!localselect.equals("no2"))){
	            pstmt = con.prepareStatement(query4);
	            pstmt.setString(1, "%" + localselect + "%");
	            pstmt.setString(2, "%" + keyword + "%");
	            System.out.println(keyword);
	            System.out.println(localselect);
	         }
	         
	         rset = pstmt.executeQuery();
	         
	         while(rset.next()){
	            Product p = new Product();
	            
	            p.setP_no(rset.getInt("p_no"));
	            p.setP_name(rset.getString("p_name"));
	            p.setP_price(rset.getInt("p_price"));
	            p.setP_count(rset.getInt("p_count"));
	            p.setP_local(rset.getString("p_local"));
	            p.setP_main_image(rset.getString("p_main_image"));
	            p.setP_detail_image(rset.getString("p_detail_image"));
	            p.setP_item(rset.getString("p_item"));
	            p.setP_state(rset.getString("p_state"));
	            
	            list.add(p);
	            
	            if(list.size() == 0)
	               throw new ProductsException("제품이 없습니다.");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	         throw new ProductsException(e.getMessage());
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      return list;
	   }

	public ArrayList<Product> cutOffSelectList(Connection con, int currentPage, int limit) throws ProductsException {
		
		
		 
		  ArrayList<Product> list = new ArrayList<Product>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select * from tb_product where p_item=? and rowid in (select max(rowid) from tb_product group by p_name)";
	      
	      try {
	    	  pstmt = con.prepareStatement(query);
				pstmt.setString(1, "절단공구");
				
				
				 rset = pstmt.executeQuery();
	         
	         
	        
	         
	         while(rset.next()){
	            Product p = new Product();
	            
	            p.setP_no(rset.getInt("p_no"));
	            p.setP_name(rset.getString("p_name"));
	            p.setP_price(rset.getInt("p_price"));
	            p.setP_count(rset.getInt("p_count"));
	            p.setP_local(rset.getString("p_local"));
	            p.setP_main_image(rset.getString("p_main_image"));
	            p.setP_detail_image(rset.getString("p_detail_image"));
	            p.setP_item(rset.getString("p_item"));
	            p.setP_state(rset.getString("p_state"));
	            
	            list.add(p);
	            
	            if(list.size() == 0)
	               throw new ProductsException("제품이 없습니다.");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	         throw new ProductsException(e.getMessage());
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      return list;
	
	}

	public ArrayList<Product> drillSelectList(Connection con, int currentPage, int limit) throws ProductsException {
		 ArrayList<Product> list = new ArrayList<Product>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select * from tb_product where p_item=? and rowid in (select max(rowid) from tb_product group by p_name)";
	      
	      try {
	    	  pstmt = con.prepareStatement(query);
				pstmt.setString(1, "드릴공구");
				
				
				 rset = pstmt.executeQuery();
	         
	         
	        
	         
	         while(rset.next()){
	            Product p = new Product();
	            
	            p.setP_no(rset.getInt("p_no"));
	            p.setP_name(rset.getString("p_name"));
	            p.setP_price(rset.getInt("p_price"));
	            p.setP_count(rset.getInt("p_count"));
	            p.setP_local(rset.getString("p_local"));
	            p.setP_main_image(rset.getString("p_main_image"));
	            p.setP_detail_image(rset.getString("p_detail_image"));
	            p.setP_item(rset.getString("p_item"));
	            p.setP_state(rset.getString("p_state"));
	            
	            list.add(p);
	            
	            if(list.size() == 0)
	               throw new ProductsException("제품이 없습니다.");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	         throw new ProductsException(e.getMessage());
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      return list;
	}

	public ArrayList<Product> chargeSelectList(Connection con, int currentPage, int limit) throws ProductsException {
		ArrayList<Product> list = new ArrayList<Product>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select * from tb_product where p_item=? and rowid in (select max(rowid) from tb_product group by p_name)";
	      
	      try {
	    	  pstmt = con.prepareStatement(query);
				pstmt.setString(1, "충전공구");
				
				
				 rset = pstmt.executeQuery();
	         
	         
	        
	         
	         while(rset.next()){
	            Product p = new Product();
	            
	            p.setP_no(rset.getInt("p_no"));
	            p.setP_name(rset.getString("p_name"));
	            p.setP_price(rset.getInt("p_price"));
	            p.setP_count(rset.getInt("p_count"));
	            p.setP_local(rset.getString("p_local"));
	            p.setP_main_image(rset.getString("p_main_image"));
	            p.setP_detail_image(rset.getString("p_detail_image"));
	            p.setP_item(rset.getString("p_item"));
	            p.setP_state(rset.getString("p_state"));
	            
	            list.add(p);
	            
	            if(list.size() == 0)
	               throw new ProductsException("제품이 없습니다.");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	         throw new ProductsException(e.getMessage());
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      return list;
	}

	public ArrayList<Product> etcSelectList(Connection con, int currentPage, int limit) throws ProductsException {
		ArrayList<Product> list = new ArrayList<Product>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select * from tb_product where p_item=? and rowid in (select max(rowid) from tb_product group by p_name)";
	      
	      try {
	    	  pstmt = con.prepareStatement(query);
				pstmt.setString(1, "기타공구");
				
				
				 rset = pstmt.executeQuery();
	         
	         
	        
	         
	         while(rset.next()){
	            Product p = new Product();
	            
	            p.setP_no(rset.getInt("p_no"));
	            p.setP_name(rset.getString("p_name"));
	            p.setP_price(rset.getInt("p_price"));
	            p.setP_count(rset.getInt("p_count"));
	            p.setP_local(rset.getString("p_local"));
	            p.setP_main_image(rset.getString("p_main_image"));
	            p.setP_detail_image(rset.getString("p_detail_image"));
	            p.setP_item(rset.getString("p_item"));
	            p.setP_state(rset.getString("p_state"));
	            
	            list.add(p);
	            
	            if(list.size() == 0)
	               throw new ProductsException("제품이 없습니다.");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	         throw new ProductsException(e.getMessage());
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      return list;
	}

	public ArrayList<Product> lifeEtcSelectList(Connection con, int currentPage, int limit) throws ProductsException {
		ArrayList<Product> list = new ArrayList<Product>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select * from tb_product where p_item=? and rowid in (select max(rowid) from tb_product group by p_name)";
	      
	      try {
	    	  pstmt = con.prepareStatement(query);
				pstmt.setString(1, "기타생활용품");
				
				
				 rset = pstmt.executeQuery();
	         
	         
	        
	         
	         while(rset.next()){
	            Product p = new Product();
	            
	            p.setP_no(rset.getInt("p_no"));
	            p.setP_name(rset.getString("p_name"));
	            p.setP_price(rset.getInt("p_price"));
	            p.setP_count(rset.getInt("p_count"));
	            p.setP_local(rset.getString("p_local"));
	            p.setP_main_image(rset.getString("p_main_image"));
	            p.setP_detail_image(rset.getString("p_detail_image"));
	            p.setP_item(rset.getString("p_item"));
	            p.setP_state(rset.getString("p_state"));
	            
	            list.add(p);
	            
	            if(list.size() == 0)
	               throw new ProductsException("제품이 없습니다.");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	         throw new ProductsException(e.getMessage());
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      return list;
	}
}
