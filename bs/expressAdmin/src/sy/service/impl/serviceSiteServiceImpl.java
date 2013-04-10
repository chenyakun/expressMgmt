package sy.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sy.dao.BaseDaoI;
import sy.model.Tbug;
import sy.model.TserviceSites;
import sy.pageModel.Bug;
import sy.pageModel.DataGrid;
import sy.pageModel.SerSite;
import sy.service.BugServiceI;
import sy.service.SerSiteServiceI;
import sy.util.ClobUtil;

@Service("serSiteService")
public class serviceSiteServiceImpl implements SerSiteServiceI {

	private BaseDaoI<TserviceSites> bugDao;

	public BaseDaoI<TserviceSites> getBugDao() {
		return bugDao;
	}

	@Autowired
	public void setBugDao(BaseDaoI<TserviceSites> bugDao) {
		this.bugDao = bugDao;
	}

	@Override
	public DataGrid datagrid(SerSite bug) {
		DataGrid dg = new DataGrid();
		String hql = "select new Tbug(t.id,t.name,t.createdatetime) from Tbug t ";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(bug, hql, params);
		String totalHql = "select count(*) from Tbug t ";
		Map<String, Object> params2 = new HashMap<String, Object>();
		totalHql = addWhere(bug, totalHql, params2);
		hql = addOrder(bug, hql);
		List<TserviceSites> l = bugDao.find(hql, params, bug.getPage(), bug.getRows());
		List<SerSite> nl = new ArrayList<SerSite>();
		changeModel(l, nl);
		dg.setTotal(bugDao.count(totalHql, params));
		dg.setRows(nl);
		return dg;
	}

	private void changeModel(List<TserviceSites> l, List<SerSite> nl) {
		if (l != null && l.size() > 0) {
			for (TserviceSites t : l) {
				SerSite u = new SerSite();
				BeanUtils.copyProperties(t, u);
				nl.add(u);
			}
		}
	}

	private String addOrder(SerSite bug, String hql) {
		if (bug.getSort() != null) {
			hql += " order by " + bug.getSort() + " " + bug.getOrder();
		}
		return hql;
	}

	private String addWhere(SerSite bug, String hql, Map<String, Object> params) {
//		hql += " where 1=1 ";
//		if (bug.getName() != null && !bug.getName().trim().equals("")) {
//			hql += " and t.name like '%%" + bug.getName().trim() + "%%'";
//		}
//		return hql;
		return null;
	}

	@Override
	public SerSite save(SerSite bug) {
		
		TserviceSites t = new TserviceSites();
		t.setSiteId(UUID.randomUUID().toString());
        t.setStoreAddress("tang feng road");
        t.setStoreAddtionInfo("no more");
        t.setStoreBoss("who");
        t.setStorename("xinxin");
        t.setStoreOpenDate("2013");
        t.setStorePosition("he 北");
        t.setStoreTel("13022119890801");
        t.setStoreWebUrl("http://www.baidu.com");
     
		
		bugDao.save(t);
//		bug.setId(t.getId());
//		bug.setNote("");
//		bug.setCreatedatetime(t.getCreatedatetime());
		return bug;
	}
 

	@Override
	public void remove(String ids) {
//		for (String id : ids.split(",")) {
//			SerSite t = bugDao.get(SerSite.class, id);
//			if (t != null) {
//				bugDao.delete(t);
//			}
//		}
	}

	@Override
	public SerSite getSite(String id) {
//		SerSite t = bugDao.get(SerSite.class, id);
//		if (t != null) {
//			SerSite b = new SerSite();
//			b.setId(t.getId());
//			b.setName(t.getName());
//			b.setCreatedatetime(t.getCreatedatetime());
//			b.setNote(ClobUtil.getString(t.getNote()));
//			return b;
//		}
		return null;
	}

	@Override
	public SerSite edit(SerSite bug) {
//		SerSite t = bugDao.get(SerSite.class, bug.getId());
//		if (t != null) {
//			t.setName(bug.getName());
//			t.setNote(ClobUtil.getClob(bug.getNote()));
//		}
//		bug.setNote("");// 大文本不需要返回到前台
//		return bug;
		return null;
	}

}
