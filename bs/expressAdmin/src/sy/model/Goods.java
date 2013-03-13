package sy.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

@Entity
public class Goods {

	private String expNum;//快递单条形码
	private String goodsName; //物品名称
	private double goodsWeight; //重量
	private int goodsPnum; //物品数量
	private double goodsBulk; //体积
	private double goodsFare; //快递费用
	private String goods_explation; //附加信息
	private String goodsType; //类型
	
	@Id 
	public String getExpNum() {
		return expNum;
	}
	public void setExpNum(String expNum) {
		this.expNum = expNum;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public double getGoodsWeight() {
		return goodsWeight;
	}
	public void setGoodsWeight(double goodsWeight) {
		this.goodsWeight = goodsWeight;
	}
	public int getGoodsPnum() {
		return goodsPnum;
	}
	public void setGoodsPnum(int goodsPnum) {
		this.goodsPnum = goodsPnum;
	}
	public double getGoodsBulk() {
		return goodsBulk;
	}
	public void setGoodsBulk(double goodsBulk) {
		this.goodsBulk = goodsBulk;
	}
	public double getGoodsFare() {
		return goodsFare;
	}
	public void setGoodsFare(double goodsFare) {
		this.goodsFare = goodsFare;
	}
	public String getGoods_explation() {
		return goods_explation;
	}
	public void setGoods_explation(String goods_explation) {
		this.goods_explation = goods_explation;
	}
	public String getGoodsType() {
		return goodsType;
	}
	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
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
