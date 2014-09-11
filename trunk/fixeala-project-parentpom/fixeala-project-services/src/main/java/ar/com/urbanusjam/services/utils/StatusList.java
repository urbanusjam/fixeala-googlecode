package ar.com.urbanusjam.services.utils;

public enum StatusList {
	
	OPEN("ABIERTO", "#31B0D5"),
	ACKNOWLEDGED("ADMITIDO", "#3A87AD"),
	REJECTED("RECHAZADO", "#C9302C"),
	IN_PROGRESS("EN PROGRESO", "#F89406"),
	SOLVED("RESUELTO", "#449D44"),	
	CLOSED("CERRADO", "#333333"),
	REOPENED("REABIERTO", "#31B0D5"),
	ARCHIVED("ARCHIVADO", "#999999");
	
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