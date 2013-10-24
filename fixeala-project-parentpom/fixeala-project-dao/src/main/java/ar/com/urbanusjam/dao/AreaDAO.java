package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.Area;

public interface AreaDAO {
	
	public Area getAreaById(String id);
	public Area getAreaByName(String name);
	
}
