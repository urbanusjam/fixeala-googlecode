package ar.com.urbanusjam.services;

import java.io.IOException;
import java.util.List;

import net.sf.jasperreports.engine.JRException;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.ReportDTO;

public interface ExportService {
	
	public boolean exportToPDF(ReportDTO report) throws IOException, JRException;	
	public boolean exportToXLS(ReportDTO report) throws IOException, JRException;	
	public boolean generateDataset(List<IssueDTO> issues, String fileFormat) throws IOException, JRException;	
}
