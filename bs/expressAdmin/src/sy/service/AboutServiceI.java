package sy.service;

import sy.pageModel.About;
import sy.pageModel.DataGrid;

public interface AboutServiceI {

	public DataGrid datagrid(About about);

	public About save(About abouts);

	public void remove(String ids);

	public About getAbout(String id);

	public About edit(About abouts);

}
