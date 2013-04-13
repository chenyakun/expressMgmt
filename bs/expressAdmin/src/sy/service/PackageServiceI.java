package sy.service;

import sy.pageModel.DataGrid;
import sy.pageModel.Package;

public interface PackageServiceI {

	public DataGrid datagrid(Package about);

	public Package save(Package abouts);

	public void remove(String ids);

	public Package getPackage(String id);

	public Package edit(Package abouts);

}
