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
import sy.model.Tbulletin;
import sy.pageModel.Bulletin;
import sy.pageModel.DataGrid;
import sy.service.BulletinServiceI;
import sy.util.ClobUtil;

@Service("bulletinService")
public class BulletinServiceImpl implements BulletinServiceI {

	private BaseDaoI<Tbulletin> bugDao;

	public BaseDaoI<Tbulletin> getBugDao() {
		return bugDao;
	}

	@Autowired
	public void setBugDao(BaseDaoI<Tbulletin> bugDao) {
		this.bugDao = bugDao;
	}

	@Override
	public DataGrid datagrid(Bulletin bug) {
		DataGrid dg = new DataGrid();
		String hql = "select new Tbulletin(t.id,t.name,t.createdatetime) from Tbulletin t ";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(bug, hql, params);
		String totalHql = "select count(*) from Tbulletin t ";
		Map<String, Object> params2 = new HashMap<String, Object>();
		totalHql = addWhere(bug, totalHql, params2);
		hql = addOrder(bug, hql);
		List<Tbulletin> l = bugDao.find(hql, params, bug.getPage(), bug.getRows());
		List<Bulletin> nl = new ArrayList<Bulletin>();
		changeModel(l, nl);
		dg.setTotal(bugDao.count(totalHql, params));
		dg.setRows(nl);
		return dg;
	}

	private void changeModel(List<Tbulletin> l, List<Bulletin> nl) {
		if (l != null && l.size() > 0) {
			for (Tbulletin t : l) {
				Bulletin u = new Bulletin();
				BeanUtils.copyProperties(t, u);
				nl.add(u);
			}
		}
	}

	private String addOrder(Bulletin bug, String hql) {
		if (bug.getSort() != null) {
			hql += " order by " + bug.getSort() + " " + bug.getOrder();
		}
		return hql;
	}

	private String addWhere(Bulletin bug, String hql, Map<String, Object> params) {
		hql += " where 1=1 ";
		if (bug.getName() != null && !bug.getName().trim().equals("")) {
			hql += " and t.name like '%%" + bug.getName().trim() + "%%'";
		}
		return hql;
	}

	@Override
	public Bulletin save(Bulletin bug) {
		Tbulletin t = new Tbulletin();
		t.setId(UUID.randomUUID().toString());
		t.setName(bug.getName());
		t.setNote(ClobUtil.getClob(bug.getNote()));
		t.setCreatedatetime(new Date());
		bugDao.save(t);
		bug.setId(t.getId());
		bug.setNote("");
		bug.setCreatedatetime(t.getCreatedatetime());
		return bug;
	}

	@Override
	public void remove(String ids) {
		for (String id : ids.split(",")) {
			Tbulletin t = bugDao.get(Tbulletin.class, id);
			if (t != null) {
				bugDao.delete(t);
			}
		}
	}

	@Override
	public Bulletin getBulletins(String id) {
		Tbulletin t = bugDao.get(Tbulletin.class, id);
		if (t != null) {
			Bulletin b = new Bulletin();
			b.setId(t.getId());
			b.setName(t.getName());
			b.setCreatedatetime(t.getCreatedatetime());
			b.setNote(ClobUtil.getString(t.getNote()));
			return b;
		}
		return null;
	}

	@Override
	public Bulletin edit(Bulletin bug) {
		Tbulletin t = bugDao.get(Tbulletin.class, bug.getId());
		if (t != null) {
			t.setName(bug.getName());
			t.setNote(ClobUtil.getClob(bug.getNote()));
		}
		bug.setNote("");// 大文本不需要返回到前台
		return bug;
	}

}
