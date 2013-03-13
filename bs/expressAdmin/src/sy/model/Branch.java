package sy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Version;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;


@Entity
@Table(name = "BRANCH", schema = "")
@DynamicInsert(true)
@DynamicUpdate(true)
public class Branch {

	private String branchId; //快递公司编号 pk
	private String branchName;//快递公司名称
	private String brancheTel; //快递公司电话
	private String branchAddr; //地址
	private String empId;//经理编号 foreign key(员工编号) 
	private String branchArea; //派送范围
	private String branchNoArrea; //不派送地区
	
	@Id
	public String getBranchId() {
		return branchId;
	}
	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getBrancheTel() {
		return brancheTel;
	}
	public void setBrancheTel(String brancheTel) {
		this.brancheTel = brancheTel;
	}
	public String getBranchAddr() {
		return branchAddr;
	}
	public void setBranchAddr(String branchAddr) {
		this.branchAddr = branchAddr;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getBranchArea() {
		return branchArea;
	}
	public void setBranchArea(String branchArea) {
		this.branchArea = branchArea;
	}
	public String getBranchNoArrea() {
		return branchNoArrea;
	}
	public void setBranchNoArrea(String branchNoArrea) {
		this.branchNoArrea = branchNoArrea;
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
