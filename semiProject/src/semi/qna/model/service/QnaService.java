package semi.qna.model.service;

import static semi.common.JDBCTemplat.close;
import static semi.common.JDBCTemplat.commit;
import static semi.common.JDBCTemplat.getConnection;
import static semi.common.JDBCTemplat.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import semi.board.model.dao.BoardDao;
import semi.board.model.vo.Board;
import semi.notice.model.dao.NoticeDao;
import semi.notice.model.vo.Notice;
import semi.qna.exception.QnaException;
import semi.qna.model.dao.QnaDao;
import semi.qna.model.vo.QnaBoard;


public class QnaService {
	public QnaService(){}
	
	public ArrayList<QnaBoard> selectList(int currentPage, int limit) 
			throws QnaException{
		Connection con = getConnection();
		ArrayList<QnaBoard> list = new QnaDao().selectList(con, currentPage, limit);
		close(con);
		return list;
	}
	
	public int insertNotice(QnaBoard qna) throws QnaException{
		Connection con = getConnection();
		int result = new QnaDao().insertNotice(con, qna);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}
	
	public QnaBoard selectNotice(int qnaNo) throws QnaException{
		Connection con = getConnection();
		QnaBoard qna = new QnaDao().selectNotice(con, qnaNo);
		close(con);
		return qna;
	}
	
	public void addReadCount(int qnaNo) throws QnaException{
		Connection con = getConnection();
		int result = new QnaDao().addReadCount(con, qnaNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
	}

	public int getListConut() throws QnaException{
		Connection con = getConnection();
		int listCount = new QnaDao().getListCount(con);
		close(con);
		return listCount;
	}
	
	public int deleteNotice(int qnaNo) throws QnaException{
		Connection con = getConnection();
		int result = new QnaDao().deleteNotice(con, qnaNo);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);		
		return result;
	}

	public int updateNotice(QnaBoard qna) throws QnaException{
		Connection con = getConnection();
		int result = new QnaDao().updateNotice(con, qna);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);		
		return result;
	}

	public void updateReplySeq(QnaBoard replyBoard) 
		throws QnaException{
		Connection con = getConnection();
		int result = new QnaDao().updateReplySeq(
				con, replyBoard);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		
	}
	
	/*public int updateReply(QnaBoard qna) 
			throws QnaException {
		Connection con = getConnection();
		int result = new BoardDao().updateReply(con, qna);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}*/

	public int insertReply(QnaBoard replyBoard) 
		throws QnaException{
		Connection con = getConnection();
		int result = new QnaDao().insertReply(con, replyBoard);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}


	
	


	

	

	

	

	
}
