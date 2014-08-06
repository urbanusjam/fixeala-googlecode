package ar.com.urbanusjam.services;

import java.io.IOException;

import net.sf.jasperreports.engine.JRException;
import ar.com.urbanusjam.services.dto.ReportDTO;

public interface ExportService {

	public boolean generateDataset(ReportDTO report) throws IOException, JRException, Exception;		
	
}
