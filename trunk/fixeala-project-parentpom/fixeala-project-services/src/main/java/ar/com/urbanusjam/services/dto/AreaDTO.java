package ar.com.urbanusjam.services.dto;

import java.io.Serializable;

public class AreaDTO implements Serializable{

	private static final long serialVersionUID = -7081029893230321340L;
	
	private String areaName;
	private String areaAcronym;
	private String cityName;
	private String cityAcronym;
	private String provinceName;
	private String provinceAcronym;
	
	
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getAreaAcronym() {
		return areaAcronym;
	}
	public void setAreaAcronym(String areaAcronym) {
		this.areaAcronym = areaAcronym;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getCityAcronym() {
		return cityAcronym;
	}
	public void setCityAcronym(String cityAcronym) {
		this.cityAcronym = cityAcronym;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getProvinceAcronym() {
		return provinceAcronym;
	}
	public void setProvinceAcronym(String provinceAcronym) {
		this.provinceAcronym = provinceAcronym;
	}
	
	
	
	
	


}
