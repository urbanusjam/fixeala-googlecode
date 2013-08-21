package ar.com.urbanusjam.dao;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.Tag;

public interface TagDAO {
	
	public void saveTag(Tag tag);
	public List<Tag> getTags();
	public boolean findTagByName(String tagname);

}
