package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;


@Entity
@Table(name="media_content")
@Inheritance(strategy=InheritanceType.JOINED)
public class MediaContent implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_content")
    private Long id;   
    
    @ManyToOne
   	@JoinColumn(name = "id_issue")	
   	private Issue issue;
    
    @Column(name = "file_id")
    private String fileID;
    
    @Column(name = "file_type")
    private String fileType;
    
    @Column(name = "filename")
    private String filename;
    
    @Column(name = "file_order")
    private Integer fileOrder;
    
    @Column(name = "upload_date")
    private Integer uploadDate;
    
    @Column(name = "width")
    private Integer width;
    
    @Column(name = "height")
    private Integer height;
    
    @Column(name = "size")
    private Integer size;
   
    @Column(name = "deletehash")
    private String deleteHash;
    
    @Column(name = "link")
    private String link;
    
    @Column(name = "is_profile_pic")
    private boolean isProfilePic;
    
    @Column(name = "username")
    private String username;
    
    @Transient
	private String issueID;
    
    @Transient
  	private String displaySize;
    
    @Transient
  	private String filenameShort;
    
    
	public MediaContent(){
        
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	public String getFileID() {
		return fileID;
	}

	public void setFileID(String fileID) {
		this.fileID = fileID;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Integer getFileOrder() {
		return fileOrder;
	}

	public void setFileOrder(Integer fileOrder) {
		this.fileOrder = fileOrder;
	}

	public Integer getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Integer uploadDate) {
		this.uploadDate = uploadDate;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getDeleteHash() {
		return deleteHash;
	}

	public void setDeleteHash(String deleteHash) {
		this.deleteHash = deleteHash;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public boolean isProfilePic() {
		return isProfilePic;
	}

	public void setProfilePic(boolean isProfilePic) {
		this.isProfilePic = isProfilePic;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getIssueID() {
		return issueID;
	}

	public void setIssueID(String issueID) {
		this.issueID = issueID;
	}

	public String getDisplaySize() {
		return convertFileSize(this.size);
	}

	public void setDisplaySize(String displaySize) {
		this.displaySize = displaySize;
	}
	
	public String getFilenameShort() {
		
		if(!this.filename.isEmpty()){
			
			String longname = this.filename;
			String[] parts = longname.split("\\.");
			String type = parts[1];
			String shorten = parts[0];
			
			if(longname.length() > 25){
				return shorten.subSequence(0, 15) + "..." + type;
			}
			else
				return this.filename;
			
		}
		
		return "";
	}

	public void setFilenameShort(String filenameShort) {
		this.filenameShort = filenameShort;
	}

	private String convertFileSize(int size){
		
		Locale locale  = new Locale("en", "UK");
		String pattern = "###.##";

		DecimalFormat df = (DecimalFormat)
		        NumberFormat.getNumberInstance(locale);
		df.applyPattern(pattern);
		// Get length of file in bytes
		double fileSizeInBytes = Double.valueOf(size);
		// Convert the bytes to Kilobytes (1 KB = 1024 Bytes)
		double fileSizeInKB = fileSizeInBytes / 1024;
		// Convert the KB to MegaBytes (1 MB = 1024 KBytes)
		double fileSizeInMB = fileSizeInKB / 1024;

		if (fileSizeInKB > 1024) {
		  return df.format(fileSizeInMB) + " MB";
		}
		else
			return df.format(fileSizeInKB) + " KB";
	}
	

}