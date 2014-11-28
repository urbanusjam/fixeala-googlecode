package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="issue_verification_request")
public class IssueVerification extends IssueMainAbstract implements Serializable {

	private static final long serialVersionUID = 1L;
		
	@Column(name = "is_verified")
	private boolean isVerified;
	
	public boolean isVerified() {
		return isVerified;
	}

	public void setVerified(boolean isVerified) {
		this.isVerified = isVerified;
	}

	
}
