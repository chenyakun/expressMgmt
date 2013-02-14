/**
 * 
 * @author geloin
 * @date 2012-9-14 下午5:37:38
 */
package expressMgmt.express.mq;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * 服务进程
 * 
 * @author geloin
 * @date 2012-9-14 下午5:37:38
 */
public class Server implements MessageListener {

	private String brokerURL = "tcp://localhost:61616";
	private Connection conn;
	private Session session;
	private String requestQueue = "TEST.QUEUE";
	private MessageProducer producer;
	private MessageConsumer consumer;

	/**
	 * 消息处理
	 * 
	 * @author geloin
	 * @date 2012-9-14 下午5:53:46
	 * @param messageText
	 * @return
	 */
	private String handleRequest(String messageText) {
		return "Response to '" + messageText + "'";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.jms.MessageListener#onMessage(javax.jms.Message)
	 */
	public void onMessage(Message message) {
		// 监听到有消息传送至此时，执行onMessage
		try {
			// 若有消息传送到服务时，先创建一个文本消息
			TextMessage response = this.session.createTextMessage();
			// 若从客户端传送到服务端的消息为文本消息
			if (message instanceof TextMessage) {
				// 先将传送到服务端的消息转化为文本消息
				TextMessage txtMsg = (TextMessage) message;
				// 取得文本消息的内容
				String messageText = txtMsg.getText();
				// 将客户端传送过来的文本消息进行处理后，设置到回应消息里面
				response.setText(handleRequest(messageText));
			}
			// 设置回应消息的关联ID，关联ID来自于客户端传送过来的关联ID
			response.setJMSCorrelationID(message.getJMSCorrelationID());
			// 生产者发送回应消息，目的由客户端的JMSReplyTo定义，内容即刚刚定义的回应消息
			producer.send(message.getJMSReplyTo(), response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @author geloin
	 * @date 2012-9-14 下午5:37:39
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		// 定义并启动服务
		Server server = new Server();
		server.start();

		// 监听控制器输入
		System.out.println("\nPress any key to stop the server\n");
		System.in.read();

		// 停止服务
		server.stop();
	}

	/**
	 * 服务
	 * 
	 * @author geloin
	 * @date 2012-9-14 下午5:55:49
	 * @throws Exception
	 */
	public void start() throws Exception {
		// 使用tcp协议创建连接通道并启动
		ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory(
				brokerURL);
		conn = factory.createConnection();
		conn.start();

		// 创建session及消息的目的地，并设定交互时使用的存储方式，同时定义队列名称，客户端通过此名称连接
		session = conn.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination dest = session.createQueue(requestQueue);

		// 创建生产者，并设定分配模式，生产者的目的地为null，因为它的目的地由JMSReplyTo定义
		producer = session.createProducer(null);
		producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

		// 消费者，及消费者的临听程序
		consumer = session.createConsumer(dest);
		consumer.setMessageListener(this);
	}

	/**
	 * 回收资源
	 * 
	 * @author geloin
	 * @date 2012-9-13 上午9:42:06
	 * @throws Exception
	 */
	private void stop() {
		try {
			if (null != producer) {
				producer.close();
			}

			if (null != consumer) {
				consumer.close();
			}

			if (null != session) {
				session.close();
			}

			if (null != conn) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}