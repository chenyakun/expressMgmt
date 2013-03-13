package sy.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Version;



@Entity
public class Trace {

	private String tranceNum; //编号 pk
	private Date tranceInTime; //收件时间
	private Date comeTime; // 到达时间
	private String resId; //负责员工
	private String tranceOutTime; // 发出时间
	private Date hisDisTime;//派件时间
	private String hisSignName;//收件签名
	private String empId;// 派件员工编号
	private String expNum;//条形码编号
	private String state; //到达状态
	public String getTranceNum() {
		return tranceNum;
	}
	public void setTranceNum(String tranceNum) {
		this.tranceNum = tranceNum;
	}
	public Date getTranceInTime() {
		return tranceInTime;
	}
	public void setTranceInTime(Date tranceInTime) {
		this.tranceInTime = tranceInTime;
	}
	public Date getComeTime() {
		return comeTime;
	}
	public void setComeTime(Date comeTime) {
		this.comeTime = comeTime;
	}
	public String getResId() {
		return resId;
	}
	public void setResId(String resId) {
		this.resId = resId;
	}
	public String getTranceOutTime() {
		return tranceOutTime;
	}
	public void setTranceOutTime(String tranceOutTime) {
		this.tranceOutTime = tranceOutTime;
	}
	public Date getHisDisTime() {
		return hisDisTime;
	}
	public void setHisDisTime(Date hisDisTime) {
		this.hisDisTime = hisDisTime;
	}
	public String getHisSignName() {
		return hisSignName;
	}
	public void setHisSignName(String hisSignName) {
		this.hisSignName = hisSignName;
	}
	@Id
	@GeneratedValue
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getExpNum() {
		return expNum;
	}
	public void setExpNum(String expNum) {
		this.expNum = expNum;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
