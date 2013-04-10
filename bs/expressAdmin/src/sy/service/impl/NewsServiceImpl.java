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
import sy.model.Tnews;
import sy.pageModel.DataGrid;
import sy.pageModel.News;
import sy.service.NewsServiceI;
import sy.util.ClobUtil;


@Service("newsService")
public class NewsServiceImpl implements NewsServiceI {

	private BaseDaoI<Tnews> bugDao;

	public BaseDaoI<Tnews> getBugDao() {
		return bugDao;
	}

	@Autowired
	public void setBugDao(BaseDaoI<Tnews> bugDao) {
		this.bugDao = bugDao;
	}

	@Override
	public DataGrid datagrid(News bug) {
		DataGrid dg = new DataGrid();
		String hql = "select new Tnews(t.id,t.name,t.createdatetime) from Tnews t ";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(bug, hql, params);
		String totalHql = "select count(*) from Tnews t ";
		Map<String, Object> params2 = new HashMap<String, Object>();
		totalHql = addWhere(bug, totalHql, params2);
		hql = addOrder(bug, hql);
		List<Tnews> l = bugDao.find(hql, params, bug.getPage(), bug.getRows());
		List<News> nl = new ArrayList<News>();
		changeModel(l, nl);
		dg.setTotal(bugDao.count(totalHql, params));
		dg.setRows(nl);
		return dg;
	}

	private void changeModel(List<Tnews> l, List<News> nl) {
		if (l != null && l.size() > 0) {
			for (Tnews t : l) {
				News u = new News();
				BeanUtils.copyProperties(t, u);
				nl.add(u);
			}
		}
	}

	private String addOrder(News bug, String hql) {
		if (bug.getSort() != null) {
			hql += " order by " + bug.getSort() + " " + bug.getOrder();
		}
		return hql;
	}

	private String addWhere(News bug, String hql, Map<String, Object> params) {
		hql += " where 1=1 ";
		if (bug.getName() != null && !bug.getName().trim().equals("")) {
			hql += " and t.name like '%%" + bug.getName().trim() + "%%'";
		}
		return hql;
	}

	@Override
	public News save(News bug) {
		Tnews t = new Tnews();
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
			Tnews t = bugDao.get(Tnews.class, id);
			if (t != null) {
				bugDao.delete(t);
			}
		}
	}

	@Override
	public News getNews(String id) {
		Tnews t = bugDao.get(Tnews.class, id);
		if (t != null) {
			News b = new News();
			b.setId(t.getId());
			b.setName(t.getName());
			b.setCreatedatetime(t.getCreatedatetime());
			b.setNote(ClobUtil.getString(t.getNote()));
			return b;
		}
		return null;
	}

	@Override
	public News edit(News bug) {
		Tnews t = bugDao.get(Tnews.class, bug.getId());
		if (t != null) {
			t.setName(bug.getName());
			t.setNote(ClobUtil.getClob(bug.getNote()));
		}
		bug.setNote("");// 大文本不需要返回到前台
		return bug;
	}

}
