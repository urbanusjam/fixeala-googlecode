package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Tag;

@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
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

	@Override
	public void deleteTag(Tag tag) {
		this.delete(tag);		
	}

	@Override
	public void saveTags(String[] tags) {
		// TODO Auto-generated method stub
		
	}
	
	


}
