package semi.products.model.service;

import static semi.common.JDBCTemplat.close;
import static semi.common.JDBCTemplat.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import semi.products.exception.ProductsException;
import semi.products.model.dao.ProductsDao;
import semi.products.model.vo.Product;



public class ProductsService {

	public ProductsService() {}

	public int getListCount() throws ProductsException {
		Connection con = getConnection();
		int listCount = new ProductsDao().getListCount(con);
		close(con);
		System.out.println("serviceCount");
		return listCount;
	}

	public ArrayList<Product> selectList(int currentPage, int limit) throws ProductsException {
		Connection con = getConnection();
		ArrayList<Product> list = 
				new ProductsDao().selectList(con, currentPage, limit);
		close(con);
		System.out.println("serviceselect");
		return list;
	}

	public Product selectProducts(String pName) throws ProductsException {
		Connection con = getConnection();
		Product product = new ProductsDao().selectProducts(con, pName);
		close(con);
		return product;
	}

	/*public void addReadCount(int pno) throws ProductsException {
		Connection con = getConnection();
		int result = new ProductsDao().addReadCount(
				con, pno);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
	}*/

}
