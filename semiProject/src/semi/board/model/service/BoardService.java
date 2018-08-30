package semi.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.sun.corba.se.impl.ior.GenericTaggedComponent;

import semi.board.model.dao.BoardDao;
import semi.board.model.vo.Board;
import semi.review.model.vo.ReviewBoard;

import static semi.common.JDBCTemplat.*;

public class BoardService {

	public ArrayList<Board> listView() {
		ArrayList<Board> list = new ArrayList<Board>();
		
		Connection conn = getConnection();
		
		list = new BoardDao().listView(conn);
		
		return list;
	}
	
	public ArrayList<Board> selectBoard(String str) {
		ArrayList<Board> list = new ArrayList<Board>();
		
		return list;
	}
	
	public Board insertBoard(Board board) {		
		return board;
	}
	
	public int updateBoard(Board board) {
		return 0;
	}
	
	public int deleteBoard(String str) {
		return 0;
	}
	
	public Board myBoard(String writer) {
		Board board = null;
		
		return board;
	}

	
	
}
