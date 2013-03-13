package sy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

@Entity
public class InterAera {

	private String braId; //分公司编号 fk
	private String areaCode;// 区号 pk
	private String areaZip; //邮编
	private String city; //城市
	private String county; //县区
	private String isOpen; // 是否开通
	@Id
	public String getBraId() {
		return braId;
	}
	public void setBraId(String braId) {
		this.braId = braId;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getAreaZip() {
		return areaZip;
	}
	public void setAreaZip(String areaZip) {
		this.areaZip = areaZip;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	public String getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
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
