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

	public ArrayList<String> selectOffice(String pName) throws ProductsException{
		Connection con = getConnection();
		ArrayList<String> list = new ProductsDao().selectOffice(con, pName);
		close(con);
		
	      return list;
	
	}

	public ArrayList<Product> selectProduct(String keyword, String localselect) throws ProductsException{
	      Connection con = getConnection();
	      ArrayList<Product> list = new ProductsDao().selectProduct(con, keyword, localselect);
	      close(con);
	      return list;
	   }

	public ArrayList<Product> cutOffSelectList(int currentPage, int limit) throws ProductsException {
		Connection con = getConnection();
		ArrayList<Product> list = new ProductsDao().cutOffSelectList(con, currentPage, limit);
		close(con);
		System.out.println("servicecutOffSelectList");
		return list;
	}

	public ArrayList<Product> drillSelectList(int currentPage, int limit) throws ProductsException {
		Connection con = getConnection();
		ArrayList<Product> list = new ProductsDao().drillSelectList(con, currentPage, limit);
		close(con);
		
		return list;
	}

	public ArrayList<Product> chargeSelectList(int currentPage, int limit) throws ProductsException {
		Connection con = getConnection();
		ArrayList<Product> list = new ProductsDao().chargeSelectList(con, currentPage, limit);
		close(con);
		
		return list;
	}

	public ArrayList<Product> etcSelectList(int currentPage, int limit) throws ProductsException {
		Connection con = getConnection();
		ArrayList<Product> list = new ProductsDao().etcSelectList(con, currentPage, limit);
		close(con);
		
		return list;
	}

	public ArrayList<Product> lifeEtcSelectList(int currentPage, int limit) throws ProductsException {
		Connection con = getConnection();
		ArrayList<Product> list = new ProductsDao().lifeEtcSelectList(con, currentPage, limit);
		close(con);
		
		return list;
	}
	

}
