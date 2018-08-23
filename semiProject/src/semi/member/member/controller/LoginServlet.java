package semi.member.member.controller; 

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semi.member.model.service.MemberService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mId = request.getParameter("mid");
		
		String mPassword = request.getParameter("mpassword");
		
		try {
			
			String mName = new MemberService().loginCheck(mId, mPassword);
			
			
			if(mName != null){
				HttpSession session = request.getSession();	
				session.setAttribute("m_Name", mName);
				session.setAttribute("m_Id", mId);	
				
				response.sendRedirect("/semi/index.jsp");
				
			}
				
			else{
				RequestDispatcher view = request.getRequestDispatcher("views/member/memberError.jsp");
				request.setAttribute("message", "아이디나 암호를 다시 확인하세요.");
				view.forward(request, response);
			
			
			}
		} catch (Exception e) {
			RequestDispatcher view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
		}
	}

}
