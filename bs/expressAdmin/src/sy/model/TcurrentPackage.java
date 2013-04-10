package sy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Version;

@Entity
public class TcurrentPackage {

	private String guid;
	private String packageid;
	private String fromAddress;
	private String fromTel;
	private String fromDate;
	private String toAddress;
	private String toTel;
	private String toCustomerMail;
	private String fromCustomerInfo;
	private String toCustomerInfo;
	private String packageType;
	private String packageTransInfo;
	private String packageVolume;
	private String packageWeight;
	private String packageStatus;
	private String fromSite;
	
	@Id
	@GeneratedValue
	public String getGuid() {
		return guid;
	}
	public void setGuid(String guid) {
		this.guid = guid;
	}
	public String getPackageid() {
		return packageid;
	}
	public void setPackageid(String packageid) {
		this.packageid = packageid;
	}
	public String getFromAddress() {
		return fromAddress;
	}
	public void setFromAddress(String fromAddress) {
		this.fromAddress = fromAddress;
	}
	public String getFromTel() {
		return fromTel;
	}
	public void setFromTel(String fromTel) {
		this.fromTel = fromTel;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToAddress() {
		return toAddress;
	}
	public void setToAddress(String toAddress) {
		this.toAddress = toAddress;
	}
	public String getToTel() {
		return toTel;
	}
	public void setToTel(String toTel) {
		this.toTel = toTel;
	}
	public String getToCustomerMail() {
		return toCustomerMail;
	}
	public void setToCustomerMail(String toCustomerMail) {
		this.toCustomerMail = toCustomerMail;
	}
	public String getFromCustomerInfo() {
		return fromCustomerInfo;
	}
	public void setFromCustomerInfo(String fromCustomerInfo) {
		this.fromCustomerInfo = fromCustomerInfo;
	}
	public String getToCustomerInfo() {
		return toCustomerInfo;
	}
	public void setToCustomerInfo(String toCustomerInfo) {
		this.toCustomerInfo = toCustomerInfo;
	}
	public String getPackageType() {
		return packageType;
	}
	public void setPackageType(String packageType) {
		this.packageType = packageType;
	}
	public String getPackageTransInfo() {
		return packageTransInfo;
	}
	public void setPackageTransInfo(String packageTransInfo) {
		this.packageTransInfo = packageTransInfo;
	}
	public String getPackageVolume() {
		return packageVolume;
	}
	public void setPackageVolume(String packageVolume) {
		this.packageVolume = packageVolume;
	}
	public String getPackageWeight() {
		return packageWeight;
	}
	public void setPackageWeight(String packageWeight) {
		this.packageWeight = packageWeight;
	}
	public String getPackageStatus() {
		return packageStatus;
	}
	public void setPackageStatus(String packageStatus) {
		this.packageStatus = packageStatus;
	}
	public String getFromSite() {
		return fromSite;
	}
	public void setFromSite(String fromSite) {
		this.fromSite = fromSite;
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
