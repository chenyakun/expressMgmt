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
@WebServlet("/MapInfoServlet")
public class MapInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MapInfoServlet() {
        super();
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
	 * 
	 * {
  "com": "yunda",
  "condition": "F00",
  "data": [
    {
      "context": "河北石家庄公司合作分部:快件已被 图片 签收",
      "ftime": "2013-03-08 15:15:38",
      "time": "2013-03-08 15:15:38"
    },
    {
      "context": "河北石家庄公司合作分部:进行派件扫描；派送业务员：海林；联系电话： 15613133381",
      "ftime": "2013-03-08 15:01:59",
      "time": "2013-03-08 15:01:59"
    },
    {
      "context": "河北石家庄公司合作分部:到达目的地网点，快件将很快进行派送",
      "ftime": "2013-03-08 14:56:33",
      "time": "2013-03-08 14:56:33"
    },
    {
      "context": "河北石家庄公司:进行派件扫描；派送业务员：公司；联系电话：85300184",
      "ftime": "2013-03-08 08:50:31",
      "time": "2013-03-08 08:50:31"
    },
    {
      "context": "河北石家庄公司:到达目的地网点，快件将很快进行派送",
      "ftime": "2013-03-08 02:53:09",
      "time": "2013-03-08 02:53:09"
    },
    {
      "context": "上海中转站:在分拨中心进行称重扫描",
      "ftime": "2013-03-06 23:50:30",
      "time": "2013-03-06 23:50:30"
    },
    {
      "context": "上海宝山区五角场公司:进行揽件扫描",
      "ftime": "2013-03-06 20:27:18",
      "time": "2013-03-06 20:27:18"
    },
    {
      "context": "上海宝山区五角场公司:进行快件扫描",
      "ftime": "2013-03-06 20:15:35",
      "time": "2013-03-06 20:15:35"
    },
    {
      "context": "上海宝山区五角场公司:进行揽件扫描",
      "ftime": "2013-03-06 19:53:31",
      "time": "2013-03-06 19:53:31"
    }
  ],
  "ischeck": "1",
  "message": "ok",
  "nu": "1200742746978",
  "state": "3",
  "status": "200",
  "updatetime": "2013-04-21 13:18:08"
}
	 * 
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
//		response.setContentType("text/json");
		PrintWriter out = response.getWriter();
		out.print("{\"usedTime\":156127000,\"arrCityCode\":\"\",\"startCityCode\":\"3101\",\"shortArrCity\":\"\",\"addrList\":[\"上海市宝山区\",\"上海市\",\"河北省石家庄市\",\"河北省石家庄市新华区\"],\"arrCity\":\"\",\"arrTime\":\"\"}");
		System.out.println("query MapInfo!");
		
	}

}
