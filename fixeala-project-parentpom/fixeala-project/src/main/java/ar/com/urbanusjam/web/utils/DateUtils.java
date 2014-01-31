package ar.com.urbanusjam.web.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class DateUtils {

	public static String getFechaFormateada(Date fecha){			
		String formattedDate = StringUtils.EMPTY;		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern("dd/MM/yyyy");
        formattedDate = df.format(fecha.getTime());
        return formattedDate;	
	}
	
	public static String getFechaFormateadaConHora(Date fecha){			
		String formattedDate = StringUtils.EMPTY;		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern("dd/MM/yyyy hh:mm a");
        formattedDate = df.format(fecha.getTime());
        return formattedDate;	
	}

}
