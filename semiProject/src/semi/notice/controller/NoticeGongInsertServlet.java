package semi.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import semi.notice.model.service.NoticeGongService;
import semi.notice.model.vo.Notice;



/**
 * Servlet implementation class NoticeGongInsertServlet
 */
@WebServlet("/nginsert")
public class NoticeGongInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeGongInsertServlet() {
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
		
		//업로드할 파일의 용량 제한 : 예, 10Mbyte 로 정한다면
		 int maxSize = 1024 * 1024 * 10;
		
		 RequestDispatcher view =null;
		// enctype 속성이 "multipart/form-data"로 전송 체크
		 if(!ServletFileUpload.isMultipartContent(request)){
			 view = request.getRequestDispatcher("views/notice/noticeGongError.jsp");
			 request.setAttribute("message", "enctype 속성 값 에러!");
			 view.forward(request, response);
		 }
		
		// 파일이 업로드되어 저장될 폴더 지정
		String savePath = request.getSession().getServletContext().getRealPath("/semi/ngupfiles");
		
		// request 를 MultipartRequest 로 변환함
		MultipartRequest mrequest = 
				new MultipartRequest(request, savePath, maxSize, "UTF-8", 
						new DefaultFileRenamePolicy());
		 
		// 전송온 값 꺼내서 변수/객체에 저장하기
		Notice notice = new Notice();
		notice.setN_title(mrequest.getParameter("ngtitle"));
		notice.setA_id(mrequest.getParameter("ngwriter"));
		notice.setN_content(mrequest.getParameter("ngcontent"));
		
		//저장폴더에 기록된 원래 파일명 조회
		String originalFileName = mrequest.getFilesystemName("gupfile"); //writeform 에 있는 첨부파일 이름
		String originalFileName2 = mrequest.getFilesystemName("gupfile2");
		
		notice.setN_file1(originalFileName);
		notice.setN_file2(originalFileName2);
		
	/*	// 업로드된 파일명을 "년월일시분초.확장자" 로 변경함
				if (originalFileName != null && originalFileName2 != null) {
					// 변경할 파일명 만들기
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					String renameFilepath = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
							+ originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
					String renameFilepath2 = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
							+ originalFileName2.substring(originalFileName2.lastIndexOf(".") + 1);

					// 파일명 바꾸려면 File 객체의 renameTo() 사용함
					File originFile = new File(savePath + "\\" + originalFileName);
					File renameFile = new File(savePath + "\\" + renameFilepath);
					
					File originFile2 = new File(savePath + "\\" + originalFileName2);
					File renameFile2 = new File(savePath + "\\" + renameFilepath2);

					// 파일 이름바꾸기 실행 >> 실패할 경우 직접 바꾸기함
					// 새 파일만들고 원래 파일 내용 읽어서 복사하고
					// 복사가 끝나면 원래 파일 삭제함
					if (!originFile.renameTo(renameFile)) {
						int read = -1;
						byte[] buf = new byte[1024];

						FileInputStream fin = new FileInputStream(originFile);
						FileOutputStream fout = new FileOutputStream(renameFile);

						while ((read = fin.read(buf, 0, buf.length)) != -1) {
							fout.write(buf, 0, read);
						}

						fin.close();
						fout.close();
						// 원본 파일 삭제함
						originFile.delete();
					}
					
					notice.setRenameFilepath(renameFilepath);
					
					if (!originFile2.renameTo(renameFile2)) {
						int read = -1;
						byte[] buf = new byte[1024];

						FileInputStream fin = new FileInputStream(originFile2);
						FileOutputStream fout = new FileOutputStream(renameFile2);

						while ((read = fin.read(buf, 0, buf.length)) != -1) {
							fout.write(buf, 0, read);
						}

						fin.close();
						fout.close();
						// 원본 파일 삭제함
						originFile2.delete();
					}
					
					notice.setRenameFilepath2(renameFilepath2);
					
				}*/
		
		try {
			if(new NoticeGongService().insertNotice(notice) > 0){
				response.sendRedirect("/semi/nglist");
			}else{
				view = request.getRequestDispatcher("views/notice/noticeGongError.jsp");
				request.setAttribute("message", "공지글 등록 실패!!!");
				view.forward(request, response);
			}
		} catch (Exception e) {
			view = request.getRequestDispatcher("views/notice/noticeGongError.jsp");
			request.setAttribute("message", e.getMessage());
			view.forward(request, response);
		}
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
