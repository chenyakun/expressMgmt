package ExpressMgmt.JMSClient.receive;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.ExceptionListener;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

 
public class RequestManager extends Thread implements MessageListener,
		ExceptionListener {

	private boolean running;

	private Session session;
	private Session replaySession;
	private Destination destination;
	private Destination replayDestination;
	private MessageProducer replyProducer;

	private boolean pauseBeforeShutdown = false;
	private int maxiumMessages;
	private static int parallelThreads = 1;
	private String subject = "myQueue";
	private boolean topic = false;
	private String user = ActiveMQConnection.DEFAULT_USER;
	private String password = ActiveMQConnection.DEFAULT_PASSWORD;
	private String url = ActiveMQConnection.DEFAULT_BROKER_URL;
	private boolean transacted;
	private boolean durable;
	private String clientId;
	private int ackMode = Session.AUTO_ACKNOWLEDGE;
	private String consumerName = "James";
	private long sleepTime;
	private long receiveTimeOut;
	private long batch = 10; // Default batch size for CLIENT_ACKNOWLEDGEMENT or
								// SESSION_TRANSACTED
	private long messagesReceived = 0;

	public static void main(String[] args) {

		System.out.println(args.length);

		for (String tempArgs : args) {

			System.out.println(tempArgs);
		}
		System.out.println("-------------");

		ArrayList<RequestManager> threads = new ArrayList();
		RequestManager RequestManager = new RequestManager();
		 
		RequestManager.showParameters();
		for (int threadCount = 1; threadCount <= parallelThreads; threadCount++) {
			RequestManager = new RequestManager();
			RequestManager.start();
			threads.add(RequestManager);
		}

		while (true) {
			Iterator<RequestManager> itr = threads.iterator();
			int running = 0;
			while (itr.hasNext()) {
				RequestManager thread = itr.next();
				if (thread.isAlive()) {
					running++;
				}
			}

			if (running <= 0) {
				System.out.println("All threads completed their work");
				break;
			}

			try {
				Thread.sleep(1000);
			} catch (Exception e) {
			}
		}
		Iterator<RequestManager> itr = threads.iterator();
		while (itr.hasNext()) {
			RequestManager thread = itr.next();
		}
	}

	public void showParameters() {
		System.out.println("Connecting to URL: " + url + " (" + user + ":"
				+ password + ")");
		System.out.println("Consuming " + (topic ? "topic" : "queue") + ": "
				+ subject);
		System.out.println("Using a " + (durable ? "durable" : "non-durable")
				+ " subscription");
		System.out.println("Running " + parallelThreads + " parallel threads");
	}

	public void run() {
		try {
			running = true;

			ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory(
					user, password, url);
			Connection connection = connectionFactory.createConnection();
			if (durable && clientId != null && clientId.length() > 0
					&& !"null".equals(clientId)) {
				connection.setClientID(clientId);
			}
			connection.setExceptionListener(this);
			connection.start();

			session = connection.createSession(transacted, ackMode);
			if (topic) {
				destination = session.createTopic(subject);
			} else {
				destination = session.createQueue(subject);
			}

			replaySession = connection.createSession(transacted, ackMode);
			replayDestination = replaySession.createQueue("controlQ");
			
			replyProducer = session.createProducer(replayDestination);
			replyProducer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

			MessageConsumer consumer = null;
			 
				consumer = session.createConsumer(destination);
			 
			if (maxiumMessages > 0) {
				consumeMessagesAndClose(connection, session, consumer);
			} else {
				if (receiveTimeOut == 0) {
					consumer.setMessageListener(this);
				} else {
					consumeMessagesAndClose(connection, session, consumer,
							receiveTimeOut);
				}
			}

		} catch (Exception e) {
			System.out.println("[" + this.getName() + "] Caught: " + e);
			e.printStackTrace();
		}
	}

	public void onMessage(Message message) {

		messagesReceived++;

		try {

			if (message instanceof TextMessage) {
				TextMessage txtMsg = (TextMessage) message;
				
				System.out.println("txtMsg.getText ---- > "+txtMsg.getText());
				
				replyProducer.send(txtMsg);
				System.out.println("sended txtMsg");
				
			}

			if (message.getJMSReplyTo() != null) {
				replyProducer.send(
						message.getJMSReplyTo(),
						session.createTextMessage("Reply: "
								+ message.getJMSMessageID()));
			}

			if (transacted) {
				if ((messagesReceived % batch) == 0) {
					System.out.println("Commiting transaction for last "
							+ batch + " messages; messages so far = "
							+ messagesReceived);
					session.commit();
				}
			} else if (ackMode == Session.CLIENT_ACKNOWLEDGE) {
				if ((messagesReceived % batch) == 0) {
					System.out.println("Acknowledging last " + batch
							+ " messages; messages so far = "
							+ messagesReceived);
					message.acknowledge();
				}
			}

		} catch (JMSException e) {
			System.out.println("[" + this.getName() + "] Caught: " + e);
			e.printStackTrace();
		} finally {
			if (sleepTime > 0) {
				try {
					Thread.sleep(sleepTime);
				} catch (InterruptedException e) {
				}
			}
		}
	}

	public synchronized void onException(JMSException ex) {
		System.out.println("[" + this.getName()
				+ "] JMS Exception occured.  Shutting down client.");
		running = false;
	}

	synchronized boolean isRunning() {
		return running;
	}

	protected void consumeMessagesAndClose(Connection connection,
			Session session, MessageConsumer consumer) throws JMSException,
			IOException {
		System.out.println("[" + this.getName()
				+ "] We are about to wait until we consume: " + maxiumMessages
				+ " message(s) then we will shutdown");

		for (int i = 0; i < maxiumMessages && isRunning();) {
			Message message = consumer.receive(1000);
			if (message != null) {
				i++;
				onMessage(message);
			}
		}
		System.out.println("[" + this.getName() + "] Closing connection");
		consumer.close();
		session.close();
		connection.close();
		if (pauseBeforeShutdown) {
			System.out.println("[" + this.getName()
					+ "] Press return to shut down");
			System.in.read();
		}
	}

	protected void consumeMessagesAndClose(Connection connection,
			Session session, MessageConsumer consumer, long timeout)
			throws JMSException, IOException {
		System.out
				.println("["
						+ this.getName()
						+ "] We will consume messages while they continue to be delivered within: "
						+ timeout + " ms, and then we will shutdown");

		Message message;
		while ((message = consumer.receive(timeout)) != null) {
			onMessage(message);
		}

		System.out.println("[" + this.getName() + "] Closing connection");
		consumer.close();
		session.close();
		connection.close();
		if (pauseBeforeShutdown) {
			System.out.println("[" + this.getName()
					+ "] Press return to shut down");
			System.in.read();
		}
	}

	public void setAckMode(String ackMode) {
		if ("CLIENT_ACKNOWLEDGE".equals(ackMode)) {
			this.ackMode = Session.CLIENT_ACKNOWLEDGE;
		}
		if ("AUTO_ACKNOWLEDGE".equals(ackMode)) {
			this.ackMode = Session.AUTO_ACKNOWLEDGE;
		}
		if ("DUPS_OK_ACKNOWLEDGE".equals(ackMode)) {
			this.ackMode = Session.DUPS_OK_ACKNOWLEDGE;
		}
		if ("SESSION_TRANSACTED".equals(ackMode)) {
			this.ackMode = Session.SESSION_TRANSACTED;
		}
	}

	public void setClientId(String clientID) {
		this.clientId = clientID;
	}

	public void setConsumerName(String consumerName) {
		this.consumerName = consumerName;
	}

	public void setDurable(boolean durable) {
		this.durable = durable;
	}

	public void setMaxiumMessages(int maxiumMessages) {
		this.maxiumMessages = maxiumMessages;
	}

	public void setPauseBeforeShutdown(boolean pauseBeforeShutdown) {
		this.pauseBeforeShutdown = pauseBeforeShutdown;
	}

	public void setPassword(String pwd) {
		this.password = pwd;
	}

	public void setReceiveTimeOut(long receiveTimeOut) {
		this.receiveTimeOut = receiveTimeOut;
	}

	public void setSleepTime(long sleepTime) {
		this.sleepTime = sleepTime;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setParallelThreads(int parallelThreads) {
		if (parallelThreads < 1) {
			parallelThreads = 1;
		}
		this.parallelThreads = parallelThreads;
	}

	public void setTopic(boolean topic) {
		this.topic = topic;
	}

	public void setQueue(boolean queue) {
		this.topic = !queue;
	}

	public void setTransacted(boolean transacted) {
		this.transacted = transacted;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void setUser(String user) {
		this.user = user;
	}


	public void setBatch(long batch) {
		this.batch = batch;
	}
}
