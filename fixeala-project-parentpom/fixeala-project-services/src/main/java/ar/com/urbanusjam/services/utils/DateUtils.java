package ar.com.urbanusjam.services.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;


public class DateUtils {

	public static String getFechaFormateada(Date fecha){			
		String formattedDate = "";		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern("dd/MM/yyyy");
        formattedDate = df.format(fecha.getTime());
        return formattedDate;	
	}
	
	public static String getFechaFormateadaConHora(Date fecha){			
		String formattedDate = "";		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern("dd/MM/yyyy hh:mm a");
        formattedDate = df.format(fecha.getTime());
        return formattedDate;	
	}
	
	public static GregorianCalendar toCalendar(Date date){
		Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return (GregorianCalendar) cal;
	}	

}
