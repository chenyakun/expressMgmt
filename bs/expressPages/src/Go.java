import org.hibernate.Session;

import ex.model.HibernateSessionFactory;
import ex.model.OrderPackInfo;


public class Go {

	public static void main(String[] args) {
		
		Session session = HibernateSessionFactory.getSession();
		
		OrderPackInfo o = new OrderPackInfo();
		
		o.setCargo_desc("adf");
		
		session.save(o);
		
		
	}
}
