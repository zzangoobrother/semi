package semi.cart.model.service;

import static semi.common.JDBCTemplat.close;
import static semi.common.JDBCTemplat.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import semi.cart.exception.CartException;
import semi.cart.model.dao.CartDao;
import semi.cart.model.vo.Cart;




public class CartService {
	
	public CartService() {}

	public ArrayList<Cart> selectList() throws CartException{
		Connection con = getConnection();
		
		ArrayList<Cart> list = new CartDao().selectList(con);
		close(con);
		return list;
	}


	
	

}
