package semi.qna.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import semi.notice.model.service.NoticeGongService;
import semi.notice.model.vo.Notice;
import semi.qna.model.service.QnaService;
import semi.qna.model.vo.QnaBoard;

/**
 * Servlet implementation class QnaInsertServlet
 */
@WebServlet("/qinsert")
public class QnaInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaInsertServlet() {
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
				
				QnaBoard qna = new QnaBoard();
				QnaBoard q = null;
				
			////ajax 시작
				
				String json1 = request.getParameter("jsonStr");
				System.out.println("JSON : " + json1);
			
				
				try {
					JSONParser jsonParser = new JSONParser();
					JSONObject job = (JSONObject)jsonParser.parse(json1);
					String  Title = (String)job.get("qtitle");
					String  Writer = (String)job.get("qwriter");
					String  File1 = (String)job.get("qupfile");
					String  File2 = (String)job.get("qupfile2");
					String  Content = (String)job.get("qcontent");
					
					
					q = new QnaBoard();
					q.setQ_title(Title);
					q.setM_id(Writer);
					q.setQ_file1(File1);
					q.setQ_file2(File2);
					q.setQ_content(Content);
				
					
					System.out.println("JSON/N변수에 담은 : " + q.toString());
					
					
					if(new QnaService().insertNotice(q) > 0){
						response.sendRedirect("/semi/nglist");
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
