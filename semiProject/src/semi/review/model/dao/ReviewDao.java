package semi.review.model.dao;

import java.sql.Connection;
import java.util.ArrayList;

import semi.review.model.vo.ReviewBoard;

public class ReviewDao {

	public ArrayList<ReviewBoard> listView(Connection conn) {
		ArrayList<ReviewBoard> list = null;
		
		return list;
	}
	
	public int deleteBoard(Connection conn, int BoardNo) {
		int result = 0;
		
		return result;
	}
	
	public int updateBoard(Connection conn, ReviewBoard review) {
		return 0;
	}
	
	public int insertBoard(Connection conn, ReviewBoard review) {
		return 0;
	}
}
