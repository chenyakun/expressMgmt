package ex.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * County entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "county", catalog = "sy")
public class County implements java.io.Serializable {

	// Fields

	private Integer id;
	private String cityid;
	private String county;
	private Integer version;

	// Constructors

	/** default constructor */
	public County() {
	}

	/** full constructor */
	public County(String cityid, String county, Integer version) {
		this.cityid = cityid;
		this.county = county;
		this.version = version;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "cityid", length = 10)
	public String getCityid() {
		return this.cityid;
	}

	public void setCityid(String cityid) {
		this.cityid = cityid;
	}

	@Column(name = "county")
	public String getCounty() {
		return this.county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	@Column(name = "version")
	public Integer getVersion() {
		return this.version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

}