package semi.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import semi.board.exception.BoardException;
import semi.board.model.dao.BoardDao;
import semi.board.model.vo.Board;


import static semi.common.JDBCTemplat.*;

public class BoardService {
	public BoardService(){}

	public ArrayList<Board> selectList(int currentPage, int limit) 
			throws BoardException{
		Connection con = getConnection();
		ArrayList<Board> list = new BoardDao().selectList(con, currentPage, limit);
		close(con);
		return list;
	}
	
	public int insertNotice(Board board) throws BoardException{
		Connection con = getConnection();
		int result = new BoardDao().insertNotice(con, board);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}
	
	public Board selectNotice(int boardNo) throws BoardException{
		Connection con = getConnection();
		Board board = new BoardDao().selectNotice(con, boardNo);
		close(con);
		return board;
	}
	
	public void addReadCount(int boardNo) throws BoardException{
		Connection con = getConnection();
		int result = new BoardDao().addReadCount(con, boardNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
	}

	public int getListConut() throws BoardException{
		Connection con = getConnection();
		int listCount = new BoardDao().getListCount(con);
		close(con);
		return listCount;
	}
	
	public int deleteNotice(int boardNo) throws BoardException{
		Connection con = getConnection();
		int result = new BoardDao().deleteNotice(con, boardNo);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;		
	}

	public int updateNotice(Board board) throws BoardException{
		Connection con = getConnection();
		int result = new BoardDao().updateNotice(con, board);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);		
		return result;
	}

	

	

	



	
	
}
