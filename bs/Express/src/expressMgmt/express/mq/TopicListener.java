package expressMgmt.express.mq;

import javax.jms.Connection;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;

import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * Use in conjunction with TopicPublisher to test the performance of ActiveMQ
 * Topics.
 */
public class TopicListener implements MessageListener {

    private Connection connection;
    private MessageProducer producer;
    private Session session;
    private int count;
    private long start;
    private Topic topic;
    private Topic control;

    private String url = "tcp://localhost:61616";

    public static void main(String[] argv) throws Exception {
        TopicListener l = new TopicListener();
      
        l.run();
    }

    public void run() throws JMSException {
        ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory(url);
        connection = factory.createConnection();
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        topic = session.createTopic("topictest.messages");
        control = session.createTopic("topictest.control");

        MessageConsumer consumer = session.createConsumer(topic);
        consumer.setMessageListener(this);

        connection.start();

        producer = session.createProducer(control);
        System.out.println("Waiting for messages...");
    }

    private static boolean checkText(Message m, String s) {
        try {
            return m instanceof TextMessage && ((TextMessage)m).getText().equals(s);
        } catch (JMSException e) {
            e.printStackTrace(System.out);
            return false;
        }
    }

    public void onMessage(Message message) {
    	
        if (checkText(message, "SHUTDOWN")) {

            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        } else if (checkText(message, "REPORT")) {
            // send a report:
            try {
                long time = System.currentTimeMillis() - start;
                String msg = "Received " + count + " in " + time + "ms";
                producer.send(session.createTextMessage(msg));
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            count = 0;

        }else if (checkText(message, "query")) {
			
        	System.out.println("-----------");
        	try {
				producer.send(session.createTextMessage(" action: 1, actionType : "+((TextMessage)message).getText()));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
        	System.out.println("***********");
		} else {

            if (count == 0) {
                start = System.currentTimeMillis();
            }

            if (++count % 1000 == 0) {
                System.out.println("Received " + count + " messages.");
            }
        }
    }

    public void setUrl(String url) {
        this.url = url;
    }

}
