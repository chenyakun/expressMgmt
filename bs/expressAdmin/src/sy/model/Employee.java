package sy.model;

import javax.persistence.Entity;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

@Entity
public class Employee {

	private String empId; //员工编号 pk
	private String empName; // 姓名
	private String empPwd; //密码
	private String empAuth; // 权限
	private String empSex; //性别
	private String empAge; //年龄
	private String empTel; 
	private String empAddr;
	private String idenNum; //身份证号
	private String empPosi;// 岗位
	private String branchId; //隶属公司编号 fk
	protected Integer version;
	@Id
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpPwd() {
		return empPwd;
	}
	public void setEmpPwd(String empPwd) {
		this.empPwd = empPwd;
	}
	public String getEmpAuth() {
		return empAuth;
	}
	public void setEmpAuth(String empAuth) {
		this.empAuth = empAuth;
	}
	public String getEmpSex() {
		return empSex;
	}
	public void setEmpSex(String empSex) {
		this.empSex = empSex;
	}
	public String getEmpAge() {
		return empAge;
	}
	public void setEmpAge(String empAge) {
		this.empAge = empAge;
	}
	public String getEmpTel() {
		return empTel;
	}
	public void setEmpTel(String empTel) {
		this.empTel = empTel;
	}
	public String getEmpAddr() {
		return empAddr;
	}
	public void setEmpAddr(String empAddr) {
		this.empAddr = empAddr;
	}
	public String getIdenNum() {
		return idenNum;
	}
	public void setIdenNum(String idenNum) {
		this.idenNum = idenNum;
	}
	public String getEmpPosi() {
		return empPosi;
	}
	public void setEmpPosi(String empPosi) {
		this.empPosi = empPosi;
	}
	public String getBranchId() {
		return branchId;
	}
	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}
	@Version
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
 
}
