package me.expressMgmt.demo;

/**
 * 
 * @author geloin
 * @date 2012-9-14 下午6:00:15
 */

import java.util.UUID;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * 
 * @author geloin
 * @date 2012-9-14 下午6:00:15
 */
public class Client
//implements MessageListener 
{

	private String brokerURL = "tcp://localhost:61616";
	private Connection conn;
	private Session session;
	private String requestQueue = "TEST.QUEUE";
	private MessageProducer producer;
	private MessageConsumer consumer;
	private Destination tempDest;
	
	/* (non-Javadoc)
	 * @see javax.jms.MessageListener#onMessage(javax.jms.Message)
	 */
//	@Override
//	public void onMessage(Message message) {
//		try {
//			System.out.println("Receive response for: "
//					+ ((TextMessage) message).getText());
//		} catch (JMSException e) {
//			e.printStackTrace();
//		}
//	}

	/**
	 * 启动
	 * 
	 * @author geloin
	 * @date 2012-9-13 下午7:49:00
	 */
	private void start() {
		try {
			// 使用tcp协议创建连接通道并启动
			ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory(
					brokerURL);
			conn = factory.createConnection();
			conn.start();
			
			// 创建session及消息的目的地，并设定交互时使用的存储方式，同时定义队列名称，此名称与服务端相同
			session = conn.createSession(false, Session.AUTO_ACKNOWLEDGE);
			Destination dest = session.createQueue(requestQueue);

			// 创建生产者，并设定分配模式
			producer = session.createProducer(dest);
			producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

			// 使用临时目的地创建消费者，及消费者的临听程序
			tempDest = session.createTemporaryQueue();
			consumer = session.createConsumer(tempDest);
//			consumer.setMessageListener(this);
			while (true) {

				TextMessage message = (TextMessage) consumer.receive(1000);

				if (null != message) {

					System.out.println("收到消息" + message.getText());

				} else {

					break;

				}

			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 停止
	 * 
	 * @author geloin
	 * @date 2012-9-13 下午7:49:06
	 */
	public void stop() {
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

	/**
	 * 请求
	 * 
	 * @author geloin
	 * @date 2012-9-13 下午7:52:54
	 * @param request
	 * @throws Exception
	 */
	public void request(String request) throws Exception {
		System.out.println("Requesting:" + request);
		TextMessage txtMsg = session.createTextMessage();
		txtMsg.setText(request);

		txtMsg.setJMSReplyTo(tempDest);

		String correlationId = UUID.randomUUID().toString();
		txtMsg.setJMSCorrelationID(correlationId);

		producer.send(txtMsg);
	}
	
	/**
	 * 
	 * @author geloin
	 * @date 2012-9-14 下午6:00:15
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		Client client = new Client();
		client.start();
		int i = 0;
		while (i++ < 10) {
			client.request("REQUEST-" + i);
		}
		Thread.sleep(3000);
		client.stop();
	}

}