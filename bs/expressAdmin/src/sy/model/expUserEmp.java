package sy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;


@Entity
public class expUserEmp {

	private String expNum; //pk 条形码编号
	private String userId; //收件客户编号
	private String empId; //收件员工编号
	public String getExpNum() {
		return expNum;
	}
	public void setExpNum(String expNum) {
		this.expNum = expNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	@Id
	 
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
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
