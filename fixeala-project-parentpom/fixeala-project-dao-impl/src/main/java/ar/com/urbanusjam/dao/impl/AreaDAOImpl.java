package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import ar.com.urbanusjam.dao.AreaDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Area;

public class AreaDAOImpl extends GenericDAOImpl<Area, Serializable> implements AreaDAO {

	public AreaDAOImpl() {
		super(Area.class);
	}


	@Override
	public Area getAreaByName(String name) {
		List<Area> areas = this.findWhere(" name = ? ", name);
		return areas.size() > 0 ? areas.get(0) : null;
	}
	
	

}
