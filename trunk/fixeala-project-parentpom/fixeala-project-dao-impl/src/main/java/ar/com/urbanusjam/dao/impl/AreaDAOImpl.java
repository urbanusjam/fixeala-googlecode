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
	public Area getAreaById(String id) {
		List<Area> areas = this.findWhere(" id = ? ", new Object[]{Long.valueOf(id)});
		return areas.size() > 0 ? areas.get(0) : null;
	}

	@Override
	public Area getAreaByName(String name) {
		List<Area> areas = this.findWhere(" name = ? ", new Object[]{name});
		return areas.size() > 0 ? areas.get(0) : null;
	}
	
}
