package ex.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.alibaba.fastjson.JSON;

import ex.model.AppJoin;
import ex.model.AppJoinDAO;

/**
 * Servlet implementation class ApplyJoin
 */
@WebServlet("/ApplyJoin")
public class ApplyJoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ApplyJoinServlet() {
		// TODO Auto-generated constructor stub
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response) expressName: 韵达 expressCode:yunda networkName:123
	 *      startPlace: startPlace_input:河北省-石家庄市 headName:123 mobile:123
	 *      password:123 imgCode:123
	 */
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		
		AppJoin aj = new AppJoin();
		Map<String, Object> j = new HashMap<String, Object>();
		AppJoinDAO dao = new AppJoinDAO();
		Session session = dao.getSession();
		Transaction tx = session.beginTransaction(); 
		try {

			aj.setExpressName(request.getParameter("expressName")); // : 韵达
			aj.setExpressCode(request.getParameter("expressCode"));// yunda
			aj.setNetworkName(request.getParameter("networkName"));// :123
			aj.setStartPlace(request.getParameter("startPlace"));// :
			aj.setStartPlace_input(request.getParameter("startPlace_input")); // :河北省-石家庄市
			aj.setHeadName(request.getParameter("headName"));// :123
			aj.setMobile(request.getParameter("mobile"));// .:123
			aj.setPassword(request.getParameter("password"));// :123
			aj.setImgCode(request.getParameter("imgCode"));// :123
			

			

			dao.save(aj);
			tx.commit();
			
			j.put("number",aj.getId());
			j.put("name", request.getParameter("expressName"));
			j.put("status", "Y");
			
			System.out.println("appJoin save ok");

		} catch (Exception e) {

			e.printStackTrace();
			j.put("reason", e.getMessage());
			tx.rollback();
		}
		out.print(JSON.toJSON(j));
		
		out.flush();
		out.close();
		
		
		

	}

}
