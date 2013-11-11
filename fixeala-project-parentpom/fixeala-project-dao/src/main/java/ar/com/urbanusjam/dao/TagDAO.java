package ar.com.urbanusjam.dao;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.Tag;

public interface TagDAO {
		
	public List<Tag> getTags();
	public boolean tagExists(String tagname);	
	public Tag findTagByName(String tagname);

}
