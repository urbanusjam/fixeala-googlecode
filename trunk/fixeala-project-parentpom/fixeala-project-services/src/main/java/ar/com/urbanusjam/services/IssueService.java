package ar.com.urbanusjam.services;

import java.util.List;

import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.TagDTO;

public interface IssueService {
	
	public void reportIssue(IssueDTO issue);	
	public List<IssueDTO> loadAllIssues();
	public List<IssueDTO> loadIssuesByStatus(String[] status);
	public List<String> getTagList();

}
