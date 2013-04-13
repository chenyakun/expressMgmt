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
import sy.model.TcurrentPackage;
import sy.pageModel.Package;
import sy.pageModel.DataGrid;
import sy.service.PackageServiceI;
import sy.util.ClobUtil;

@Service("packageService")
public class PackageServiceImpl implements PackageServiceI {

	private BaseDaoI<TcurrentPackage> PackageDao;

	public BaseDaoI<TcurrentPackage> geTcurrentPackageDao() {
		return PackageDao;
	}

	@Autowired
	public void seTcurrentPackageDao(BaseDaoI<TcurrentPackage> PackageDao) {
		this.PackageDao = PackageDao;
	}

	@Override
	public DataGrid datagrid(Package Package) {
		DataGrid dg = new DataGrid();
		String hql = "select new TcurrentPackage(t.id,t.name,t.createdatetime) from TcurrentPackage t ";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(Package, hql, params);
		String totalHql = "select count(*) from TcurrentPackage t ";
		Map<String, Object> params2 = new HashMap<String, Object>();
		totalHql = addWhere(Package, totalHql, params2);
		hql = addOrder(Package, hql);
		List<TcurrentPackage> l = PackageDao.find(hql, params, Package.getPage(), Package.getRows());
		List<Package> nl = new ArrayList<Package>();
		changeModel(l, nl);
		dg.setTotal(PackageDao.count(totalHql, params));
		dg.setRows(nl);
		return dg;
	}

	private void changeModel(List<TcurrentPackage> l, List<Package> nl) {
		if (l != null && l.size() > 0) {
			for (TcurrentPackage t : l) {
				Package u = new Package();
				BeanUtils.copyProperties(t, u);
				nl.add(u);
			}
		}
	}

	private String addOrder(Package Package, String hql) {
		if (Package.getSort() != null) {
			hql += " order by " + Package.getSort() + " " + Package.getOrder();
		}
		return hql;
	}

	private String addWhere(Package Package, String hql, Map<String, Object> params) {
//		hql += " where 1=1 ";
//		if (Package.getName() != null && !Package.getName().trim().equals("")) {
//			hql += " and t.name like '%%" + Package.getName().trim() + "%%'";
//		}
//		return hql;
		return "";
	}

	@Override
	public Package save(Package Package) {
		TcurrentPackage t = new TcurrentPackage();
		t.setGuid(UUID.randomUUID().toString());
		t.setFromCustomerInfo(Package.getFromCustomerInfo());
		t.setFromDate(new Date().toString());
		t.setFromSite(Package.getFromSite());
		t.setPackageid(UUID.randomUUID().toString());
		t.setPackageStatus(Package.getPackageStatus());
		t.setPackageTransInfo(Package.getPackageTransInfo());
		t.setPackageType(Package.getPackageType());
		t.setPackageVolume(Package.getPackageVolume());
		t.setPackageWeight(Package.getPackageWeight());
		t.setToAddress(Package.getToAddress());
		t.setFromAddress(Package.getFromAddress());
		t.setToCustomerInfo(Package.getToCustomerInfo());
		t.setToCustomerMail(Package.getToCustomerMail());
		t.setToTel(Package.getToTel());
	
		PackageDao.save(t);
//		Package.setId("a");
//		Package.setNote("");
//		Package.setCreatedatetime(t.getCreatedatetime());
		return Package;
	}

	@Override
	public void remove(String ids) {
		for (String id : ids.split(",")) {
			TcurrentPackage t = PackageDao.get(TcurrentPackage.class, id);
			if (t != null) {
				PackageDao.delete(t);
			}
		}
	}

	@Override
	public Package getPackage(String id) {
		TcurrentPackage Package = PackageDao.get(TcurrentPackage.class, id);
		if (Package != null) {
			Package t = new Package();
			t.setGuid(Package.getGuid());
			t.setFromCustomerInfo(Package.getFromCustomerInfo());
			t.setFromDate(new Date().toString());
			t.setFromSite(Package.getFromSite());
			t.setPackageid(UUID.randomUUID().toString());
			t.setPackageStatus(Package.getPackageStatus());
			t.setPackageTransInfo(Package.getPackageTransInfo());
			t.setPackageType(Package.getPackageType());
			t.setPackageVolume(Package.getPackageVolume());
			t.setPackageWeight(Package.getPackageWeight());
			t.setToAddress(Package.getToAddress());
			t.setFromAddress(Package.getFromAddress());
			t.setToCustomerInfo(Package.getToCustomerInfo());
			t.setToCustomerMail(Package.getToCustomerMail());
			t.setToTel(Package.getToTel());
 
			return t;
		}
		return null;
	}

	@Override
	public Package edit(Package Package) {
		TcurrentPackage t = PackageDao.get(TcurrentPackage.class, Package.getGuid());
		if (t != null) {
			
			t.setFromCustomerInfo(Package.getFromCustomerInfo());
			t.setFromDate(Package.getFromDate());
			t.setFromSite(Package.getFromSite());
			t.setPackageStatus(Package.getPackageStatus());
			t.setPackageTransInfo(Package.getPackageTransInfo());
			t.setPackageType(Package.getPackageType());
			t.setPackageVolume(Package.getPackageVolume());
			t.setPackageWeight(Package.getPackageWeight());
			t.setToAddress(Package.getToAddress());
			t.setFromAddress(Package.getFromAddress());
			t.setToCustomerInfo(Package.getToCustomerInfo());
			t.setToCustomerMail(Package.getToCustomerMail());
			t.setToTel(Package.getToTel());
		}
		return Package;
	}

}
