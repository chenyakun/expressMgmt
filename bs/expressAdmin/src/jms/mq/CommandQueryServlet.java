package jms.mq;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TemporaryQueue;
import javax.jms.TextMessage;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * Servlet implementation class CommandQueryServlet
 */
@WebServlet("/CommandQueryServlet")
public class CommandQueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static Map<String, MessageProducer> queueProducerDic = null;

	static {

		queueProducerDic = new HashMap<String, MessageProducer>();

	}

	/**
	 * Broker address
	 */
	private String brokerURL = "";

	/**
	 * ActiveMq factory
	 */
	private ConnectionFactory connectionFactory;

	/**
	 * ActiveMq connection
	 */
	private Connection connection;

	/**
	 * 会话
	 */
	private Session session;

	/**
	 * 接收消息的延时时间
	 */
	private Long delayTime = (long) 5000;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CommandQueryServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request,response) ;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8") ; 
		response.setContentType("text/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		// 获取前台传过来的JSON
//		int length = request.getContentLength();
//		byte[] bytes = new byte[length];
//		ServletInputStream inputStream = request.getInputStream();
//		inputStream.read(bytes);
//		String jsonStr = new String(bytes);

		String cmdData = "hello";
		String queuetype = "demo";
		try {
			this.initActiveMQ();

			String responseText = getReplyMessage(queuetype, cmdData);

			out.print(responseText);
		} catch (JMSException e) {
			try {
				session.close();
			} catch (JMSException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
				connection.close();
			} catch (JMSException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

		}

	}

	public String getReplyMessage(String queuename, String messageStr)
			throws JMSException {

		Message message = session.createTextMessage(messageStr);

		TemporaryQueue tempQueue = session.createTemporaryQueue();
		System.out.println(tempQueue.getQueueName());
//		Destination senderReceiveAddr = session.createQueue(tempQueue
//				.getQueueName());
		message.setJMSReplyTo(tempQueue);

		MessageConsumer receiveConsumer = session
//				.createConsumer(senderReceiveAddr);
				.createConsumer(tempQueue);

		MessageProducer sender = getMessageProducer(queuename);

		if (sender != null) {
			sender.send(message);
		}

		message = receiveConsumer.receive(delayTime);

		if (message == null) {
			return "";
		}
		TextMessage textMessage = (TextMessage) message;

		return textMessage.getText();
	}

	/**
	 * 根据队列名,获取该队列的消息生产者
	 * 
	 * @param queuename
	 * @return
	 * @throws JMSException
	 */
	public synchronized MessageProducer getMessageProducer(String queuename)
			throws JMSException {

		MessageProducer producer = queueProducerDic.get(queuename);
		if (producer == null) {
			Destination queue = session.createQueue(queuename);
			producer = session.createProducer(queue);
			queueProducerDic.put(queuename, producer);
		}
		return producer;
	}

	private void initActiveMQ() {
		connectionFactory = new ActiveMQConnectionFactory(
				ActiveMQConnection.DEFAULT_USER,
				ActiveMQConnection.DEFAULT_PASSWORD,
				ActiveMQConnection.DEFAULT_BROKER_URL);
		try {
			connection = connectionFactory.createConnection();
			connection.start();
			// 第一个参数表示是否支持事务
			session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		} catch (JMSException e) {
			e.printStackTrace();
		}
	}

}
