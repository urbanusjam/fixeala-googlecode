package ar.com.urbanusjam.services.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;



public class DateUtils {
	
	private static final String FORMAT_TIMESTAMP = "yyyyMMddHHmmssSSS";
	private static final String FORMAT_TIMESTAMP_DATE = "yyyyMMdd";
	private static final String FORMAT_TIMESTAMP_TIME = "HHmmss";
	private static final String FORMAT_DATE_DEFAULT = "dd/MM/yyyy";
	private static final String FORMAT_DATETIME_SECONDS = "dd/MM/yyyy hh:mm a";

	public static String getFechaFormateada(Date fecha){			
		String formattedDate = "";		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern(FORMAT_DATE_DEFAULT);
        formattedDate = df.format(fecha.getTime());
        return formattedDate;	
	}
	
	public static String getFechaFormateadaConHora(Date fecha){			
		String formattedDate = "";		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern(FORMAT_DATETIME_SECONDS);
        formattedDate = df.format(fecha.getTime());
        return formattedDate;	
	}
	
	public static GregorianCalendar toCalendar(Date date){
		Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return (GregorianCalendar) cal;
	}	
	
	public static String generateTimestamp(){
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(FORMAT_TIMESTAMP);         
		String timestamp = "";
		timestamp = sdf.format(cal.getTime());  
		return timestamp;
	}
	
	public static String generateTimestampDate(){
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(FORMAT_TIMESTAMP_DATE);         
		String timestamp = "";
		timestamp = sdf.format(cal.getTime());  
		return timestamp;
	}
	public static String generateTimestampTime(){
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(FORMAT_TIMESTAMP_TIME);         
		String timestamp = "";
		timestamp = sdf.format(cal.getTime());  
		return timestamp;
	}

}
