/**    
 * @FileName: Receiver.java  
 * @Package:ExpressMgmt.JMSClient.receive  
 * @Description: TODO 
 * @author: ME   
 * @date:2013-2-8 上午8:26:40  
 * @version V1.0    
 */
package ExpressMgmt.JMSClient.receive;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * @ClassName: Receiver
 * @Description: TODO
 * @author: ME
 * @date:2013-2-8 上午8:26:40
 */
public class Receiver extends Thread implements MessageListener {

	ConnectionFactory connectionFactory;
	Connection connection = null;

	Session session;

	Destination destination;

	MessageConsumer consumer;

	public static void main(String[] args) {

		Receiver receiver = new Receiver();
		receiver.start();
	}

	public void run() {

		System.out.println("run..");
		connectionFactory = new ActiveMQConnectionFactory(
				ActiveMQConnection.DEFAULT_USER,
				ActiveMQConnection.DEFAULT_PASSWORD, "tcp://localhost:61616");

		try {
			connection = connectionFactory.createConnection();

			connection.start();

			session = connection.createSession(Boolean.FALSE,
					Session.AUTO_ACKNOWLEDGE);

			destination = session.createQueue("myQueue");

			consumer = session.createConsumer(destination);
//			consumer.setMessageListener(this);

			 while (true) {
			 TextMessage message = (TextMessage) consumer.receive(1000);
			
			 if (message != null) {
			
			 System.out.println("get it! " + message.getText());
			 //
			 // } else {
			 // break;
			 }
			
			 }

		} catch (JMSException e) {
			e.printStackTrace();
			// TODO: add log
		} finally {

			try {
				if (connection != null) {
					connection.close();
				}
			} catch (Exception e2) {

			}
		}
	}

	@Override
	public void onMessage(Message message) {
		try {

			if (message instanceof TextMessage) {
				TextMessage txtMsg = (TextMessage) message;
				// replyProducer.send(txtMsg);
				System.out.println("received  txtMsg  " + txtMsg.getText());
			}
		} catch (JMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
