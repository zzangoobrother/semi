package semi.board.model.dao;

import java.sql.Connection;
import java.util.ArrayList;

import semi.board.model.vo.Board;

public class BoardDao {

	public ArrayList<Board> listView(Connection conn) {
		ArrayList<Board> list = new ArrayList<Board>();
		
		return list;
	}
	
	public ArrayList<Board> selectBoard(Connection conn, String str) {
		ArrayList<Board> list = new ArrayList<Board>();
		
		return list;
	}
	
	public Board insertBoard(Connection conn, Board board) {		
		return board;
	}
	
	public int updateBoard(Connection conn, Board board) {
		return 0;
	}
	
	public int deleteBoard(Connection conn, String str) {
		return 0;
	}
	
	public Board myBoard(Connection conn, String writer) {
		Board board = null;
		
		return board;
	}
}
