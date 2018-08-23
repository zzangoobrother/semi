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

	/*public int addReadCount(Connection con, int pno) throws ProductsException {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update TB_PRODUCT "
				+ "set board_readcount = board_readcount + 1 "
				+ "where board_num = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, pno);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new ProductsException(
						pno + "번 게시글 조회수 증가 처리 실패!");
		} catch (Exception e) {
			e.printStackTrace();
			throw new ProductsException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
		
	}*/

}
