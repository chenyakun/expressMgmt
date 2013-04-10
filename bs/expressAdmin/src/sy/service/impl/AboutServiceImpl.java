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
import sy.model.Tabout;
import sy.pageModel.About;
import sy.pageModel.DataGrid;
import sy.service.AboutServiceI;
import sy.util.ClobUtil;

@Service("aboutService")
public class AboutServiceImpl implements AboutServiceI {

	private BaseDaoI<Tabout> bugDao;

	public BaseDaoI<Tabout> getBugDao() {
		return bugDao;
	}

	@Autowired
	public void setBugDao(BaseDaoI<Tabout> bugDao) {
		this.bugDao = bugDao;
	}

	@Override
	public DataGrid datagrid(About bug) {
		DataGrid dg = new DataGrid();
		String hql = "select new Tabout(t.id,t.name,t.createdatetime) from Tabout t ";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(bug, hql, params);
		String totalHql = "select count(*) from Tabout t ";
		Map<String, Object> params2 = new HashMap<String, Object>();
		totalHql = addWhere(bug, totalHql, params2);
		hql = addOrder(bug, hql);
		List<Tabout> l = bugDao.find(hql, params, bug.getPage(), bug.getRows());
		List<About> nl = new ArrayList<About>();
		changeModel(l, nl);
		dg.setTotal(bugDao.count(totalHql, params));
		dg.setRows(nl);
		return dg;
	}

	private void changeModel(List<Tabout> l, List<About> nl) {
		if (l != null && l.size() > 0) {
			for (Tabout t : l) {
				About u = new About();
				BeanUtils.copyProperties(t, u);
				nl.add(u);
			}
		}
	}

	private String addOrder(About bug, String hql) {
		if (bug.getSort() != null) {
			hql += " order by " + bug.getSort() + " " + bug.getOrder();
		}
		return hql;
	}

	private String addWhere(About bug, String hql, Map<String, Object> params) {
		hql += " where 1=1 ";
		if (bug.getName() != null && !bug.getName().trim().equals("")) {
			hql += " and t.name like '%%" + bug.getName().trim() + "%%'";
		}
		return hql;
	}

	@Override
	public About save(About bug) {
		Tabout t = new Tabout();
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
			Tabout t = bugDao.get(Tabout.class, id);
			if (t != null) {
				bugDao.delete(t);
			}
		}
	}

	@Override
	public About getAbout(String id) {
		Tabout t = bugDao.get(Tabout.class, id);
		if (t != null) {
			About b = new About();
			b.setId(t.getId());
			b.setName(t.getName());
			b.setCreatedatetime(t.getCreatedatetime());
			b.setNote(ClobUtil.getString(t.getNote()));
			return b;
		}
		return null;
	}

	@Override
	public About edit(About bug) {
		Tabout t = bugDao.get(Tabout.class, bug.getId());
		if (t != null) {
			t.setName(bug.getName());
			t.setNote(ClobUtil.getClob(bug.getNote()));
		}
		bug.setNote("");// 大文本不需要返回到前台
		return bug;
	}

}
