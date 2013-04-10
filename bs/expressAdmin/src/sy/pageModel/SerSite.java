package sy.pageModel;

public class SerSite implements java.io.Serializable {

	private int page;
	private int rows;
	private String sort;
	private String order;
	private String ids;
	private String q;

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	private String	siteId;
	private String	storename;
	private String	storeTel;
	private String  storeWebUrl;
	private String  storeBoss;
	private String  storeAddress;
	private String	storeOpenDate;
	private String	storeAddtionInfo;
	private String	storePosition;

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getStorename() {
		return storename;
	}

	public void setStorename(String storename) {
		this.storename = storename;
	}

	public String getStoreTel() {
		return storeTel;
	}

	public void setStoreTel(String storeTel) {
		this.storeTel = storeTel;
	}

	public String getStoreWebUrl() {
		return storeWebUrl;
	}

	public void setStoreWebUrl(String storeWebUrl) {
		this.storeWebUrl = storeWebUrl;
	}

	public String getStoreBoss() {
		return storeBoss;
	}

	public void setStoreBoss(String storeBoss) {
		this.storeBoss = storeBoss;
	}

	public String getStoreAddress() {
		return storeAddress;
	}

	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}

	public String getStoreOpenDate() {
		return storeOpenDate;
	}

	public void setStoreOpenDate(String storeOpenDate) {
		this.storeOpenDate = storeOpenDate;
	}

	public String getStoreAddtionInfo() {
		return storeAddtionInfo;
	}

	public void setStoreAddtionInfo(String storeAddtionInfo) {
		this.storeAddtionInfo = storeAddtionInfo;
	}

	public String getStorePosition() {
		return storePosition;
	}

	public void setStorePosition(String storePosition) {
		this.storePosition = storePosition;
	}

 

}
