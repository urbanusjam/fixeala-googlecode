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
	public List<Tag> getTags() {
		return this.findAll();
	}

	@Override
	public boolean tagExists(String tagname) {
		List<Tag> tags = this.findWhere(" tagname = ? ", tagname);
		return tags.size() > 0 ? true : false ;
	}

	@Override
	public Tag findTagByName(String tagname) {
		List<Tag> tags = this.findWhere(" tagname = ? ", tagname);
		return tags.get(0);
	}

}
