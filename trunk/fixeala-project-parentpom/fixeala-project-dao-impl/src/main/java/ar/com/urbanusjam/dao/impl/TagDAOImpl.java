package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Tag;

public class TagDAOImpl extends GenericDAOImpl<Tag, Serializable> implements TagDAO {

	public TagDAOImpl() {
		super(Tag.class);
	}

	@Override
	public void saveTag(Tag tag) {
		this.saveOrUpdate(tag);
	}

	@Override
	public List<Tag> getTags() {
		return this.findAll();
	}

	@Override
	public boolean findTagByName(String tagname) {
		return (this.findWhere(" tagname = ? ", tagname)).size() > 0 ? true : false ;
	}

}
