package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="issue_follow")
public class IssueFollow extends IssueMainAbstract implements Serializable {
	
	private static final long serialVersionUID = 1L;
		
}