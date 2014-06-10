package ar.com.urbanusjam.web.utils;

public enum StatusList {
	
	OPEN("Abierto", "label label-important", "#B94A48"), 
	REOPENED("Reabierto", "label label-info", "#39B3D7"),
//	ACKNOWLEDGED("Admitido", "label label-primary", "blue"),
	IN_PROGRESS("En progreso", "label label-warning", "#F89406"),
	SOLVED("Resuelto", "label label-success", "#468847"),
	CLOSED("Cerrado", "label label-inverse", "#333333");
//	ARCHIVED("Archivado", "label label-default" , "gray");
	
	private String label;
	private String cssClass;
	private String colorCode;

	private StatusList(String label, String cssClass, String colorCode) {
		this.label = label;
		this.cssClass = cssClass;
		this.colorCode = colorCode;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	public String getColorCode() {
		return colorCode;
	}

	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}
	
}