package semi.board.model.dao;

import static semi.common.JDBCTemplat.*;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


import semi.board.exception.BoardException;
import semi.board.model.vo.Board;
import semi.notice.exception.NoticeException;
import semi.notice.model.vo.Notice;

public class BoardDao {
	public BoardDao(){}

	public ArrayList<Board> selectList(Connection con, int currentPage, int limit) 
			throws BoardException{
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from ("
				+ "select rownum rnum, rb_no, "
				+ "rb_title, rb_content, rb_count, "
				+ "rb_date, rb_file1, rb_file2, m_id, p_no "
				+ "from (select * from tb_reviewboard "
				+ "order by rb_no desc)) "
				+ "where rnum >= ? and rnum <= ?";
				
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
				
				b.setRb_no(rset.getInt("rb_no"));
				b.setRb_title(rset.getString("rb_title"));
				b.setRb_content(rset.getString("rb_content"));
				b.setRb_count(rset.getInt("rb_count"));
				b.setRb_date(rset.getDate("rb_date"));
				b.setRb_file1(rset.getString("rb_file1"));
				b.setRb_file2(rset.getString("rb_file2"));
				b.setM_id(rset.getString("m_id"));
				b.setP_no(rset.getInt("p_no"));
				
				list.add(b);
			}
				if(list.size() == 0)
					throw new BoardException("공지글이 없습니다.");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	
	public int insertNotice(Connection con, Board board) 
	throws BoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into tb_reviewboard values "
				+ "((select max(rb_no) + 1 from tb_reviewboard), "
				+ "?, ?, default, sysdate, ?, ?, ?, ?)" ;
	
	try {
		pstmt = con.prepareStatement(query);
		pstmt.setString(1, board.getRb_title());
		pstmt.setString(2, board.getRb_content());
		pstmt.setString(3, board.getRb_file1());
		pstmt.setString(4, board.getRb_file2());
		pstmt.setString(5, board.getM_id());
		pstmt.setInt(6, board.getP_no());

		result = pstmt.executeUpdate();
		
		if(result <= 0)
			throw new BoardException("새 공지글 등록 실패!!!");
		
	} catch (Exception e) {
		e.printStackTrace();
		throw new BoardException(e.getMessage());
	}finally{
		close(pstmt);
	}	
	return result;
	}
	
	public Board selectNotice(Connection con, int boardNo) 
	throws BoardException{
		Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from tb_reviewboard "
				+ "where rb_no =?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				board = new Board();
				
				board.setRb_no(boardNo);
				board.setRb_title(rset.getString("rb_title"));
				board.setRb_content(rset.getString("rb_content"));
				board.setRb_count(rset.getInt("rb_count"));
				board.setRb_date(rset.getDate("rb_date"));
				board.setRb_file1(rset.getString("rb_file1"));
				board.setRb_file2(rset.getString("rb_file2"));
				board.setM_id(rset.getString("m_id"));				
				board.setP_no(rset.getInt("p_no"));
								
			}else{
				throw new BoardException("후기글 조회 실패!!!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException(e.getMessage());
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return board;
	}
	
	public int addReadCount(Connection con, int boardNo) 
	throws BoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update tb_reviewboard "
				+ "set rb_count = rb_count + 1 "
				+ "where rb_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new BoardException(
						boardNo + "번 게시글 조회수 증가처리실패!!!");
		
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int getListCount(Connection con) throws BoardException{
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from tb_reviewboard";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				listCount = rset.getInt(1);
			}else{
				throw new BoardException("게시글이 존재하지 않습니다!!!!!!!!!!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException(e.getMessage());
		}finally{
			close(rset);
			close(stmt);
		}
		
		return listCount;
	}
	
	public int deleteNotice(Connection con, int boardNo) 
	throws BoardException{
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "delete from tb_reviewboard " + "where rb_no =?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new BoardException("게시글 삭제 실패!!!!");

		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException(e.getMessage());
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int updateNotice(Connection con, Board board) 
	throws BoardException{
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "";
		if(board.getRb_file1() != null){
			query = "update tb_reviewboard set " 
					+ "rb_title = ?, " 
					+ "rb_content = ?, "
					+ "rb_file1 = ?, " 
					+ "rb_file2 = ?, " 
					+ "p_no = ? " 
					+ "where rb_no = ?";
		}else{
			query = "update tb_reviewboard set "
					+ "rb_title = ?, "
					+ "rb_content = ?, "
					+ "p_no = ? "
					+ "where rb_no = ?";
		}
		
		try {
			pstmt = con.prepareStatement(query);
			
		if(board.getRb_file1() != null || board.getRb_file2() != null){
			pstmt.setString(1, board.getRb_title());
			pstmt.setString(2, board.getRb_content());
			pstmt.setString(3, board.getRb_file1());
			pstmt.setString(4, board.getRb_file2());
			pstmt.setInt(5, board.getP_no());
			pstmt.setInt(6, board.getRb_no());
		}else{
			pstmt.setString(1, board.getRb_title());
			pstmt.setString(2, board.getRb_content());
			pstmt.setInt(3, board.getP_no());
			pstmt.setInt(4, board.getRb_no());
			
		}
			result = pstmt.executeUpdate();
			
			if(result <= 0)
				throw new BoardException("원글 수정 실패!!!!!");
			
		} catch (Exception e) {
			throw new BoardException(e.getMessage());
		}finally{
			close(pstmt);
		}
		
		
		return result;
	}

	

	

	

	


}














