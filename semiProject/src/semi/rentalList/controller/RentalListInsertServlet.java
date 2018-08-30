package semi.rentalList.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.rentalList.exception.RentalListException;
import semi.rentalList.model.service.RentalListService;
import semi.rentalList.model.vo.RentalList;



/**
 * Servlet implementation class RentalListInsertServlet
 */
@WebServlet("/rlist")
public class RentalListInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RentalListInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mId = (String) request.getParameter("loginId"); // 회원 아이디
		String paySelect = (String) request.getParameter("payselect"); // 결제 방법
		int orderpay = Integer.parseInt((String) request.getParameter("orderpay")); // 총 금액
		int count = Integer.parseInt((String) request.getParameter("totalcount")); // 대여 수량
		int productNo = Integer.parseInt((String) request.getParameter("productNo")); // 물품번호
		String startDay = (String) request.getParameter("startday"); // 대여실행일
		String endDay = (String) request.getParameter("endday"); //반납신청일
		
		String state = ""; //승인여부
		
		if(paySelect.equals("money")) {
			state = "입금대기중";
		} else {
			state = "결제완료";
		}
		
		RentalList rlist = new RentalList();
		
		rlist.setmId(mId);
		rlist.setrTotalCount(count);
		rlist.setrTotalMoney(orderpay);
		
		
		RequestDispatcher view = null;
		
		try {
			String rentalNo = new RentalListService().insertRentalList(rlist);
			
			if(rentalNo != null) {
				view = request.getRequestDispatcher("rinsert");
				
				rlist.setrNo(rentalNo);
				
				request.setAttribute("payselect", paySelect);
				request.setAttribute("productNo", productNo);
				request.setAttribute("startday", startDay);
				request.setAttribute("endday", endDay);
				request.setAttribute("state", state);
				request.setAttribute("rlist", rlist);
				
				view.forward(request, response);
			} else {
				view = request.getRequestDispatcher("views/payment/paymentError.jsp");
				request.setAttribute("message", "결제 목록 등록 실패");
				view.forward(request, response);
			}
		} catch (RentalListException e) {
			view = request.getRequestDispatcher("views/payment/paymentError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
		}
	}

}
