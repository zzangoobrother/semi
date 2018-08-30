package semi.products.model.dao;

import static semi.common.JDBCTemplat.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.sun.prism.Presentable;

import semi.member.exception.MemberException;
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
		
		String query = "select P_LOCAL from tb_product where P_NAME = ? ";
		
		
		
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

	public int mGetListCount(Connection conn) throws ProductsException {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from TB_PRODUCT";

		try {
			stmt = conn.createStatement();
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

	public ArrayList<Product> mAllSelectList(Connection conn, int currentPage, int limit) throws ProductsException {
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state, p_main_image, p_detail_image, l_local from TB_PRODUCT, tb_local where p_local = l_name) where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
					
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Product p = new Product();

				p.setP_name(rset.getString("p_name"));
				p.setP_price(rset.getInt("p_price"));
				p.setP_count(rset.getInt("p_count"));
				p.setP_local(rset.getString("p_local"));
				p.setP_item(rset.getString("p_item"));
				p.setP_state(rset.getString("p_state"));
				p.setP_main_image(rset.getString("p_main_image"));
				p.setP_detail_image(rset.getString("p_detail_image"));
				p.setGu(rset.getString("l_local"));
			
				
				list.add(p);
			}
			
			if(list.size() == 0)
				throw new ProductsException("물품이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int mGetSelectListCount(Connection conn, String filter, String searchTF) throws ProductsException {
		int listCount = 0;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "";
		
		if(filter.equals("지역")) {
			if(!searchTF.equals("")) {
				query = "select count(*) from TB_PRODUCT where p_local in (select l_name from tb_local where l_address like ?)";
			} else {
				query = "select count(*) from TB_PRODUCT";
			}
		} else if(filter.equals("동사무소")) {
			if(!searchTF.equals("")) {
				query = "select count(*) from TB_PRODUCT where p_local like ?";
			} else {
				query = "select count(*) from TB_PRODUCT";
			}
		} else if(filter.equals("물품품목")) {
			if(!searchTF.equals("")) {
				query = "select count(*) from TB_PRODUCT where p_item like ?";
			} else {
				query = "select count(*) from TB_PRODUCT";
			}
		} else if(filter.equals("대여상태")) {
			if(!searchTF.equals("")) {
				query = "select count(*) from TB_PRODUCT where p_state like ?";
			} else {
				query = "select count(*) from TB_PRODUCT";
			}
		}
		
		try {
			if(!searchTF.equals("")) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + searchTF + "%");
				rset = pstmt.executeQuery();
			} else {
				stmt = conn.createStatement();
				rset = stmt.executeQuery(query);
			}
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new ProductsException("물품이 존재하지 않습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}

	public ArrayList<Product> mSelectList(Connection conn, int currentPage, int limit, String filter, String searchTF) throws ProductsException {
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "";
		
		if(filter.equals("지역")) {
			if(!searchTF.equals("")) {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from tb_product where p_local in (select l_name from tb_local where l_address like ?)) where rnum >= ? and rnum <= ?";
			} else {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from TB_PRODUCT) where rnum >= ? and rnum <= ?";
			}
		} else if(filter.equals("동사무소")) {
			if(!searchTF.equals("")) {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from tb_product where p_local like ?) where rnum >= ? and rnum <= ?";
			} else {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from TB_PRODUCT) where rnum >= ? and rnum <= ?";
			}
		} else if(filter.equals("물품품목")) {
			if(!searchTF.equals("")) {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from tb_product where p_item like ?) where rnum >= ? and rnum <= ?";
			} else {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from TB_PRODUCT) where rnum >= ? and rnum <= ?";
			}
		} else if(filter.equals("대여상태")) {
			if(!searchTF.equals("")) {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from tb_product where p_state like ?) where rnum >= ? and rnum <= ?";
			} else {
				query = "select * from (select rownum rnum, p_name, p_price, p_count, p_local, p_item, p_state from TB_PRODUCT) where rnum >= ? and rnum <= ?";
			}
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			
			if(!searchTF.equals("")) {
				pstmt.setString(1, "%" + searchTF + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else {
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			}
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Product p = new Product();

				p.setP_name(rset.getString("p_name"));
				p.setP_price(rset.getInt("p_price"));
				p.setP_count(rset.getInt("p_count"));
				p.setP_local(rset.getString("p_local"));
				p.setP_item(rset.getString("p_item"));
				p.setP_state(rset.getString("p_state"));
			
				
				list.add(p);
			}
			
			if(list.size() == 0)
				throw new ProductsException("물품이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Product> selectCenterName(Connection conn, String filter) throws ProductsException {
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select l_name from tb_local where l_local = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, filter);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Product p = new Product();
				
				p.setP_local(rset.getString(1));
				
				list.add(p);
			}
			
			if(list.size() == 0)
				throw new ProductsException("물품이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public String getImageNum(Connection conn) throws ProductsException {
		Statement stmt = null;
		ResultSet rset = null;
		
		String num = "";
		
		String query = "select max(P_DETAIL_IMAGE) from tb_product";
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				num = rset.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		} finally{
			close(rset);
			close(stmt);
		}
		
		return num;
	}

	public int insertManagement(Connection conn, Product p) throws ProductsException {
		int result = 0;
		PreparedStatement pstmt = null;
		System.out.println(p.toString());
		String query = "insert into tb_product values ((select max(p_no) + 1 from tb_product), ?, ?, ?, ?, ?, ?, ?, sysdate, '대여가능')";
		
		try {
			pstmt = conn.prepareStatement(query);
			System.out.println(result);
			pstmt.setString(1, p.getP_name());
			pstmt.setInt(2, p.getP_price());
			pstmt.setInt(3, p.getP_count());
			pstmt.setString(4, p.getP_local());
			pstmt.setString(5, p.getP_main_image());
			pstmt.setString(6, p.getP_detail_image());
			pstmt.setString(7, p.getP_item());
			
			result = pstmt.executeUpdate();
			System.out.println(result);
			if(result <= 0)
				throw new MemberException("물품 가입 실패");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally {
			close(pstmt);
		}
		System.out.println(result);
		return result;
	}

	public int proUpdate(Connection conn, int price, int count, String name, String local) throws ProductsException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update tb_product set p_price = ?, p_count = ? where p_name = ? and p_local = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, price);
			pstmt.setInt(2, count);
			pstmt.setString(3, name);
			pstmt.setString(4, local);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new ProductsException("물품 수정 실패!");
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int proDelete(Connection conn, String name, String local) throws ProductsException {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from tb_product where p_name = ? and p_local = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, name);
			pstmt.setString(2, local);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new ProductsException("물품 삭제 실패!");
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Product> localSelectList(Connection conn, String local) {
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select l_name from tb_local where l_local = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, local);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Product p = new Product();
				
				p.setP_local(rset.getString(1));
				
				list.add(p);
			}
			
			if(list.size() == 0)
				throw new ProductsException("물품이 존재하지 않습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
}
