package ar.com.urbanusjam.web.services;

import java.io.IOException;

import net.sf.jasperreports.engine.JRException;
import ar.com.urbanusjam.services.dto.ReportDTO;

public interface ExportService {

	public void exportDataset(ReportDTO report) throws IOException, JRException, Exception;		
	
}
