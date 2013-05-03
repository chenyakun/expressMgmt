package sy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "OrderPackInfo", schema = "")
public class OrderPackInfo implements java.io.Serializable {

	private String orderid; // uuid
	private String source;
	private String orderSource;
	private String priceId;
	private String type;
	private String startPlace;// ; //110105
	private String endPlace;// ; //310113
	private String weight;// ; //2.0
	private String volume;// ; //0.0
	private String sender_name; // adsf
	private String sender_company; // asdf
	private String sender_address1; // asdf
	private String sender_address2; // 234234
	private String sender_mobile; // 23423423423
	private String sender_tel1; //
	private String sender_tel2; //
	private String sender_tel3; //
	private String receive_name; // 234
	private String receive_company; // 234
	private String receive_address1; // 234
	private String receive_address2; // 234234
	private String receive_mobile; // 23423423423
	private String receive_tel1; // 234234
	private String receive_tel2; // 23422342
	private String receive_tel3; // 34234
	private String cargo_name; // 234234
	private String cargo_total_number; // 234
	private String cargo_desc; // 234234aeraer
	private String pay_type; // PREPAID
	
	@Id
	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}


	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getOrderSource() {
		return orderSource;
	}

	public void setOrderSource(String orderSource) {
		this.orderSource = orderSource;
	}

	public String getPriceId() {
		return priceId;
	}

	public void setPriceId(String priceId) {
		this.priceId = priceId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStartPlace() {
		return startPlace;
	}

	public void setStartPlace(String startPlace) {
		this.startPlace = startPlace;
	}

	public String getEndPlace() {
		return endPlace;
	}

	public void setEndPlace(String endPlace) {
		this.endPlace = endPlace;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getSender_name() {
		return sender_name;
	}

	public void setSender_name(String sender_name) {
		this.sender_name = sender_name;
	}

	public String getSender_company() {
		return sender_company;
	}

	public void setSender_company(String sender_company) {
		this.sender_company = sender_company;
	}

	public String getSender_address1() {
		return sender_address1;
	}

	public void setSender_address1(String sender_address1) {
		this.sender_address1 = sender_address1;
	}

	public String getSender_address2() {
		return sender_address2;
	}

	public void setSender_address2(String sender_address2) {
		this.sender_address2 = sender_address2;
	}

	public String getSender_mobile() {
		return sender_mobile;
	}

	public void setSender_mobile(String sender_mobile) {
		this.sender_mobile = sender_mobile;
	}

	public String getSender_tel1() {
		return sender_tel1;
	}

	public void setSender_tel1(String sender_tel1) {
		this.sender_tel1 = sender_tel1;
	}

	public String getSender_tel2() {
		return sender_tel2;
	}

	public void setSender_tel2(String sender_tel2) {
		this.sender_tel2 = sender_tel2;
	}

	public String getSender_tel3() {
		return sender_tel3;
	}

	public void setSender_tel3(String sender_tel3) {
		this.sender_tel3 = sender_tel3;
	}

	public String getReceive_name() {
		return receive_name;
	}

	public void setReceive_name(String receive_name) {
		this.receive_name = receive_name;
	}

	public String getReceive_company() {
		return receive_company;
	}

	public void setReceive_company(String receive_company) {
		this.receive_company = receive_company;
	}

	public String getReceive_address1() {
		return receive_address1;
	}

	public void setReceive_address1(String receive_address1) {
		this.receive_address1 = receive_address1;
	}

	public String getReceive_address2() {
		return receive_address2;
	}

	public void setReceive_address2(String receive_address2) {
		this.receive_address2 = receive_address2;
	}

	public String getReceive_mobile() {
		return receive_mobile;
	}

	public void setReceive_mobile(String receive_mobile) {
		this.receive_mobile = receive_mobile;
	}

	public String getReceive_tel1() {
		return receive_tel1;
	}

	public void setReceive_tel1(String receive_tel1) {
		this.receive_tel1 = receive_tel1;
	}

	public String getReceive_tel2() {
		return receive_tel2;
	}

	public void setReceive_tel2(String receive_tel2) {
		this.receive_tel2 = receive_tel2;
	}

	public String getReceive_tel3() {
		return receive_tel3;
	}

	public void setReceive_tel3(String receive_tel3) {
		this.receive_tel3 = receive_tel3;
	}

	public String getCargo_name() {
		return cargo_name;
	}

	public void setCargo_name(String cargo_name) {
		this.cargo_name = cargo_name;
	}

	public String getCargo_total_number() {
		return cargo_total_number;
	}

	public void setCargo_total_number(String cargo_total_number) {
		this.cargo_total_number = cargo_total_number;
	}

	public String getCargo_desc() {
		return cargo_desc;
	}

	public void setCargo_desc(String cargo_desc) {
		this.cargo_desc = cargo_desc;
	}

	public String getPay_type() {
		return pay_type;
	}

	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}

}
