package ar.com.urbanusjam.entity;

import java.io.Serializable;
import java.util.Date;

public class PointRecord implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date date;
	private Integer points;
	private String operation;
	
		
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}
	
	public void setDate(Date date) {
		this.date = date;
	}
	
	public Integer getPoints() {
		return points;
	}
	
	public void setPoints(Integer points) {
		this.points = points;
	}
	
	public String getOperation() {
		return operation;
	}
	
	public void setOperation(String operation) {
		this.operation = operation;
	}
	
	

}
