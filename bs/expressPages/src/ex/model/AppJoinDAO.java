package ex.model;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import static org.hibernate.criterion.Example.create;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 

public class AppJoinDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory.getLogger(AppJoinDAO.class);

	public void save(AppJoin transientInstance) {
		log.debug("saving AppJoin instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(AppJoin persistentInstance) {
		log.debug("deleting AppJoin instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public AppJoin findById(java.lang.Integer id) {
		log.debug("getting AppJoin instance with id: " + id);
		try {
			AppJoin instance = (AppJoin) getSession().get("ex.model.AppJoin", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List<AppJoin> findByExample(AppJoin instance) {
		log.debug("finding AppJoin instance by example");
		try {
			List<AppJoin> results = (List<AppJoin>) getSession()
					.createCriteria("ex.model.AppJoin").add(create(instance))
					.list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding AppJoin instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from AppJoin as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findAll() {
		log.debug("finding all AppJoin instances");
		try {
			String queryString = "from AppJoin";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public AppJoin merge(AppJoin detachedInstance) {
		log.debug("merging AppJoin instance");
		try {
			AppJoin result = (AppJoin) getSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(AppJoin instance) {
		log.debug("attaching dirty AppJoin instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(AppJoin instance) {
		log.debug("attaching clean AppJoin instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}