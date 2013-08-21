package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.List;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.Tag;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.UserDTO;

public class IssueServiceImpl implements IssueService{
	
	private IssueDAO issueDAO;
	private TagDAO tagDAO;
	
	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}
	
	public void setTagDAO(TagDAO tagDAO) {
		this.tagDAO = tagDAO;
	}


	@Override
	public void reportIssue(IssueDTO issueDTO) {		
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		issueDAO.saveIssue(issue);		
	}

	@Override
	public List<IssueDTO> loadAllIssues() {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getAllIssues();
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		for(Issue issue : issues){
			IssueDTO iDTO = convertToDTO(issue);
			issuesDTO.add(iDTO);
		}
		return issuesDTO;	
	}
	
	@Override
	public List<IssueDTO> loadIssuesByStatus(String[] status) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getIssuesByStatus(status);
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		for(Issue issue : issues){
			IssueDTO iDTO = convertToDTO(issue);
			issuesDTO.add(iDTO);
		}
		return issuesDTO;	
	}
	
	
	
	/********************************************************************************/
	
	
	
	public Issue convertTo(IssueDTO issueDTO){
				
		User user = new User();
		user.setUsername(issueDTO.getUser().getUsername());
		
		Issue issue = new Issue();
		issue.setReporter(user);
		issue.setAddress(issueDTO.getAddress());
		issue.setNeighborhood(issueDTO.getNeighborhood());
		issue.setCity(issueDTO.getCity());	
		issue.setProvince(issueDTO.getProvince());	
		issue.setTitle(issueDTO.getTitle());
		issue.setDescription(issueDTO.getDescription());
		
		//Collection<Tag> tagsCollection = new ArrayList<Tag>();
		List<String> tagList = issueDTO.getTags();
		
		for(String t : tagList){
			Tag newTag = new Tag();
			newTag.setTagname(t);				
			issue.addTag(newTag);	
		}
					
		issue.setDate(issueDTO.getDate());		
		issue.setLatitude(issueDTO.getLatitude());
		issue.setLongitude(issueDTO.getLongitude());
		issue.setStatus(issueDTO.getStatus());
		
		return issue;
	}
	
	public IssueDTO convertToDTO(Issue issue){
		
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(issue.getReporter().getUsername());
		
		IssueDTO issueDTO = new IssueDTO();
		issueDTO.setId(issue.getId());
		issueDTO.setUser(userDTO);
		issueDTO.setAddress(issue.getAddress());
		issueDTO.setNeighborhood(issue.getNeighborhood());
		issueDTO.setCity(issue.getCity());	
		issueDTO.setProvince(issue.getProvince());	
		issueDTO.setTitle(issue.getTitle());
		issueDTO.setDescription(issue.getDescription());				
		issueDTO.setDate(issue.getDate());		
		issueDTO.setLatitude(issue.getLatitude());
		issueDTO.setLongitude(issue.getLongitude());
		issueDTO.setStatus(issue.getStatus());
		
		return issueDTO;
	}
	
	

	@Override
	public List<String> getTagList() {
		List<Tag> tagList = new ArrayList<Tag>();
		List<String> list = new ArrayList<String>();
		tagList = tagDAO.getTags();	
		
		for(Tag t : tagList){			
			list.add(t.getTagname());
		}
		
		return list;
				
	}

	

	
}
