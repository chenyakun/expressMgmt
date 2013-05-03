package ex.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import ex.model.HibernateSessionFactory;
import ex.model.OrderPackInfo;

/**
 * Servlet implementation class PackageQueryServlet
 */
@WebServlet("/PackageOrderServlet")
public class SendPackOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendPackOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
 
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		request.getParameter("");
		
		OrderPackInfo oInfo = new OrderPackInfo();
		oInfo.setCargo_desc(request.getParameter("cargo_desc"));
		oInfo.setCargo_name(request.getParameter("cargo_name"));
		oInfo.setCargo_total_number(request.getParameter("cargo_total_number"));
		oInfo.setEndPlace(request.getParameter("endPlace"));
		oInfo.setOrderid(UUID.randomUUID().toString());
		oInfo.setOrderSource(request.getParameter("orderSource"));
		oInfo.setPay_type(request.getParameter("pay_type"));
		oInfo.setPriceId(request.getParameter("priceId"));
		oInfo.setReceive_address1(request.getParameter("receive_address1"));
		oInfo.setReceive_address2(request.getParameter("receive_address2"));
		oInfo.setReceive_company(request.getParameter("receive_company"));
		
		oInfo.setReceive_mobile(request.getParameter("receive_mobile"));
		oInfo.setReceive_name(request.getParameter("receive_name"));
		oInfo.setReceive_tel1(request.getParameter("receive_tel1"));
		oInfo.setReceive_tel2(request.getParameter("receive_tel2"));
		oInfo.setReceive_tel3(request.getParameter("receive_tel3"));
		oInfo.setSender_address1(request.getParameter("sender_address1"));
		
		oInfo.setSender_address2(request.getParameter("sender_address2"));
		oInfo.setSender_company(request.getParameter("sender_company"));
		oInfo.setSender_mobile(request.getParameter("sender_mobile"));
		oInfo.setSender_name(request.getParameter("sender_name"));
		oInfo.setSender_tel1(request.getParameter("sender_tel1"));
		oInfo.setSender_tel2(request.getParameter("sender_tel2"));
		oInfo.setSender_tel3(request.getParameter("sender_tel3"));
		
		oInfo.setSource(request.getParameter("source"));
		oInfo.setStartPlace(request.getParameter("startPlace"));
		oInfo.setType(request.getParameter("type"));
		oInfo.setVolume(request.getParameter("volume"));
		oInfo.setWeight(request.getParameter("weight"));
		
		
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = session.beginTransaction();
		try {
			
			session.saveOrUpdate(oInfo);
			tx.commit();
			//out.print("{\"result\":\"ok\",\"reason\":\"订单添加成功\"}");
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
			out.print("{\"result\":\"error\",\"reason\":\""+e.getMessage()+"\"}");
		}finally{
			
			session.close();
		}
		 
		
		System.out.println("query !");
		out.flush();
		out.close();
	}

}
