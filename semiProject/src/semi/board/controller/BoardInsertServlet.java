package semi.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import semi.board.model.service.BoardService;
import semi.board.model.vo.Board;
import semi.notice.model.service.NoticeGongService;
import semi.notice.model.vo.Notice;

/**
 * Servlet implementation class BoardInsertServlet
 */
@WebServlet("/binsert")
public class BoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//파일 첨부 기능 공지글 등록 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
				
		Board board = new Board();
		Board b = null;
		
	////ajax 시작
		
			String json1 = request.getParameter("jsonStr");
			System.out.println("JSON : " + json1);
			
			try {
				JSONParser jsonParser = new JSONParser();
				JSONObject job = (JSONObject)jsonParser.parse(json1);
				String  Title = (String)job.get("btitle");
				String  Writer = (String)job.get("bwriter");
				String  File1 = (String)job.get("bupfile");
				String  File2 = (String)job.get("bupfile2");
				String  Content = (String)job.get("bcontent");
				Integer Product = (Integer)job.get("pro");
				
				
				b = new Board();
				b.setRb_title(Title);
				b.setM_id(Writer);
				b.setRb_file1(File1);
				b.setRb_file2(File2);
				b.setRb_content(Content);
				b.setP_no(Product);
				
				
				System.out.println("JSON/N변수에 담은 : " + b.toString());
				
				
				if(new BoardService().insertNotice(b) > 0){
					response.sendRedirect("/semi/blist");
				}else{
				/*	view = request.getRequestDispatcher("views/notice/noticeGongError.jsp");
					request.setAttribute("message", "공지글 등록 실패!!!");
					view.forward(request, response);*/
				}
			} catch (Exception e) {
				/*view = request.getRequestDispatcher("views/notice/noticeGongError.jsp");
				request.setAttribute("message", e.getMessage());
				view.forward(request, response);*/
			}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}























