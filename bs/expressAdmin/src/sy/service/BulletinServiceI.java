package sy.service;

import sy.pageModel.Bulletin;
import sy.pageModel.DataGrid;

public interface BulletinServiceI {

	public DataGrid datagrid(Bulletin news);

	public Bulletin save(Bulletin news);

	public void remove(String ids);

	public Bulletin getBulletins(String id);

	public Bulletin edit(Bulletin bug);

}
