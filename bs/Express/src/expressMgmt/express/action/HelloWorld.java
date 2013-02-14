package expressMgmt.express.action;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.MessageConsumer;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import expressMgmt.express.mq.Client;

/**
 * <code>Set welcome message.</code>
 */
public class HelloWorld extends ExampleSupport {

	private String name;
	private String inch;
	private String result;

	public String execute() throws Exception {

//		Client client = new Client();
//		client.start();
//		client.request("liu neng ...");

		setName("name...");

		result = "hello world ....";

		// ConnectionFactory ：连接工厂，JMS 用它创建连接

		ConnectionFactory connectionFactory;
		Connection connection = null;
		Session session;

		MessageConsumer consumer;
		MessageProducer producer;

		connectionFactory = new ActiveMQConnectionFactory(

		ActiveMQConnection.DEFAULT_USER,

		ActiveMQConnection.DEFAULT_PASSWORD,

		"tcp://localhost:61616");

		try {
			
			connection = connectionFactory.createConnection();
			connection.start();
			session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
			Destination dest = session.createQueue("TEST.QUEUE");

			// 创建生产者，并设定分配模式
			producer = session.createProducer(dest);
			producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
 
			// 获取操作连接

			session = connection.createSession(Boolean.FALSE,

			Session.AUTO_ACKNOWLEDGE);
			
			TextMessage response = session.createTextMessage();
			response.setText("questing ...");
			
			producer.send(dest, response);

			// 获取session注意参数是一个服务器的queue，须在在ActiveMq的console配置

			Destination	destination = session.createQueue("controlQ");

			consumer = session.createConsumer(destination);

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

		} finally {

			try {

				if (null != connection)

					connection.close();

			} catch (Throwable ignore) {

			}

		}

		return SUCCESS;

	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInch() {
		return inch;
	}

	public void setInch(String inch) {
		this.inch = inch;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

}
