package com.qfbi.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.qfbi.Operation.ItemOperation;

/**
 * Servlet implementation class ShopAction
 */
@WebServlet("/ShopAction")
public class UpdateAction extends HttpServlet {

	private static final long serialVersionUID = 1L;
	static Logger logger = Logger.getLogger(UpdateAction.class);
 
	static {
		ItemOperation.init();
		PropertyConfigurator.configure("log4j.properties");
		logger.info("init successfully!!");
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest res, HttpServletResponse req)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest res, HttpServletResponse req)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setContentType("text/html;charset=utf-8");
		res.setCharacterEncoding("utf-8");
		req.setContentType("application/json");
		String query = res.getParameter("query");
		if (!"".equals(query) && query != null) {
			String ip = getIpAddr(res);
			logger.info("IP="+ ip + "	query=" + query);
			JSONArray jsonArray = ItemOperation.search(query);
			PrintWriter out = req.getWriter();
			out.print(jsonArray);
		}
	}
	
	/**
	 * 越过代理获取IP
	 */
	public String getIpAddr(HttpServletRequest request) {  
        
        String ip = request.getHeader("x-forwarded-for");  
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;
    }
}
