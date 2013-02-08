/**    
 * @FileName: Send.java  
 * @Package:ExpressMgmt.JMSClient.send  
 * @Description: TODO 
 * @author: ME   
 * @date:2013-2-8 上午8:27:41  
 * @version V1.0    
 */
package ExpressMgmt.JMSClient.send;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;

/**
 * @ClassName: Send
 * @Description: TODO
 * @author: ME
 * @date:2013-2-8 上午8:27:41
 */
public class Sender {

	private static final int SEND_NUMBER = 5;

	public static void main(String[] args) {

		ConnectionFactory connectionFactory;

		Connection connection = null;

		Session session;

		Destination destination;

		MessageProducer producer;
		
		connectionFactory = new org.apache.activemq.ActiveMQConnectionFactory(
				ActiveMQConnection.DEFAULT_USER,
				ActiveMQConnection.DEFAULT_PASSWORD, "tcp://localhost:61616");

		try {
			connection = connectionFactory.createConnection();

			connection.start();

			session = connection.createSession(Boolean.TRUE,
					Session.AUTO_ACKNOWLEDGE);

			destination = session.createQueue("queue2");

			producer = session.createProducer(destination);

			producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

			sendMessage(session, producer);

			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				if (connection != null) {
					connection.close();
				}
			} catch (Exception e2) {
			}
		}

	}

	public static void sendMessage(Session session, MessageProducer producer)
			throws Exception {

		for (int i = 0; i < SEND_NUMBER; i++) {

			TextMessage message = session.createTextMessage("ActiveMQ 发送的消息 "
					+ i);
			System.out.println("sended message " + i + " ok");
			producer.send(message);
		}

	}

}
