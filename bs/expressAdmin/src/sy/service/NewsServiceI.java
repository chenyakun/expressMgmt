package sy.service;

import sy.pageModel.DataGrid;
import sy.pageModel.News;

public interface NewsServiceI {

	public DataGrid datagrid(News news);

	public News save(News news);

	public void remove(String ids);

	public News getNews(String id);

	public News edit(News bug);

}
