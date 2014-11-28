package ar.com.urbanusjam.entity.utils;

public enum StatusList {
	
	OPEN("ABIERTO", "#3399FF"), //red
	VERIFIED("VERIFICADO", "#009933"), //green
	REJECTED("RECHAZADO", "#C9302C"), //red
	IN_PROGRESS("EN PROGRESO", "#FF9900"), //orange
	SOLVED("RESUELTO", "#0066FF"), //blue	
	REOPENED("REABIERTO", "#3399FF"), //red
	CLOSED("CERRADO", "#333333"), //dark gray	
	ARCHIVED("ARCHIVADO", "#999999"); //gray
	
//	public static final String OPEN = "ABIERTO";
//	public static final String ACKNOWLEDGED = "ADMITIDO";
//	public static final String VERIFIED = "VERIFICADO";
//	public static final String REJECTED = "RECHAZADO";
//	public static final String REOPENED = "REABIERTO";	
//	public static final String IN_PROGRESS = "EN PROGRESO";
//	public static final String SOLVED = "RESUELTO";	
//	public static final String CLOSED = "CERRADO";	
//	public static final String ARCHIVED = "ARCHIVADO"; 
//	public static final String ASSIGNED = "ASIGNADO";
//	public static final String DEFERRED = "DIFERIDO";	
	
	private String label;
	private String colorCode;

	private StatusList(String label, String colorCode) {
		this.label = label;
		this.colorCode = colorCode;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getColorCode() {
		return colorCode;
	}

	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}
	
}