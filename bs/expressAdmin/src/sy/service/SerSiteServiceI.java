package sy.service;

import sy.pageModel.DataGrid;
import sy.pageModel.SerSite;

public interface SerSiteServiceI {

	public DataGrid datagrid(SerSite about);

	public SerSite save(SerSite abouts);

	public void remove(String ids);

	public SerSite getSite(String id);

	public SerSite edit(SerSite abouts);

}
