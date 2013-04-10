package sy.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Version;

@Entity
@Table(name = "TSITE", schema = "")
public class TserviceSites  implements java.io.Serializable{

		private String	siteId;
		private String	storename;
		private String	storeTel;
		private String  storeWebUrl;
		private String  storeBoss;
		private String  storeAddress;
		private String	storeOpenDate;
		private String	storeAddtionInfo;
		private String	storePosition;
		
		
		@Id
		@Column(name = "siteId", nullable = false)
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
		protected Integer version;


		@Version
		public Integer getVersion() {
			return version;
		}
		public void setVersion(Integer version) {
			this.version = version;
		}
}
