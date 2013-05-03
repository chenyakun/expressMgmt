package ex.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PackageQueryServlet
 */
@WebServlet("/PackageQueryServlet")
public class PackageQueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PackageQueryServlet() {
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
//		response.setContentType("text/json");
		PrintWriter out = response.getWriter();
		out.print("{\"com\":\"yunda\",\"condition\": \"F00\",\"data\": [{\"context\": \"河北石家庄公司合作分部:快件已被 图片 签收\",\"ftime\": \"2013-03-08 15:15:38\",\"time\": \"2013-03-08 15:15:38\"},{\"context\": \"河北石家庄公司合作分部:进行派件扫描；派送业务员：海林；联系电话： 15613133381\",\"ftime\": \"2013-03-08 15:01:59\",\"time\": \"2013-03-08 15:01:59\"},{\"context\": \"上海中转站:在分拨中心进行称重扫描\",\"ftime\": \"2013-03-06 23:50:30\",\"time\": \"2013-03-06 23:50:30\"} ],\"ischeck\": \"1\",\"message\": \"ok\",\"nu\": \"1200742746978\",\"state\": \"3\",\"status\": \"200\",\"updatetime\": \"2013-04-21 10:28:21\"}");
		System.out.println("query !");
		
	}

}
