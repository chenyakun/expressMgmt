package expressMgmt.express.mq;
 
import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;

import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * Use in conjunction with TopicListener to test the performance of ActiveMQ
 * Topics.
 */
public class TopicPublisher implements MessageListener {


    private Connection connection;
    private Session session;
    private MessageProducer publisher;
    private Topic topic;
    private Topic control;

    private String url = "tcp://localhost:61616";
    private int remaining;


    public static void main(String[] argv) throws Exception {
        TopicPublisher p = new TopicPublisher();
        
        p.run();
    }

    private void run() throws Exception {
        ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory(url);
        connection = factory.createConnection();
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        topic = session.createTopic("topictest.messages");
        control = session.createTopic("topictest.control");

        publisher = session.createProducer(topic);
        publisher.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

        session.createConsumer(control).setMessageListener(this);
        connection.start();
       
        
        publisher.send(session.createTextMessage("query"));
        

    }


    public void onMessage(Message message) {
        
        if (message instanceof TextMessage) {
            TextMessage txtMsg = (TextMessage) message;
            
				
            try {
            	
				System.out.println("txtMsg: "+txtMsg.getText());
				
			} catch (JMSException e) {
				e.printStackTrace();
			}
            
        }
    	System.out.println("Received report " + getReport(message) + " " + --remaining + " remaining");
            
    	  try {
			
    		  connection.stop();
    		  connection.close();

    	  } catch (JMSException e) {
		}
    }

    Object getReport(Message m) {
        try {
            return ((TextMessage)m).getText();
        } catch (JMSException e) {
            e.printStackTrace(System.out);
            return e.toString();
        }
    }

    static long min(long[] times) {
        long min = times.length > 0 ? times[0] : 0;
        for (int i = 0; i < times.length; i++) {
            min = Math.min(min, times[i]);
        }
        return min;
    }

    static long max(long[] times) {
        long max = times.length > 0 ? times[0] : 0;
        for (int i = 0; i < times.length; i++) {
            max = Math.max(max, times[i]);
        }
        return max;
    }

    static long avg(long[] times, long min, long max) {
        long sum = 0;
        for (int i = 0; i < times.length; i++) {
            sum += times[i];
        }
        sum -= min;
        sum -= max;
        return sum / times.length - 2;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
