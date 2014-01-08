package ar.com.urbanusjam.services.utils;

public class FileUploadUtils {
	
	public static String getExtensionArchivo(String nombreArchivo) {
		return nombreArchivo.substring(nombreArchivo.lastIndexOf(".") + 1, nombreArchivo.length());
    }
	
	public static String getNombreArchivoSinExtension(String nombreArchivo) {
		   String nombreArchivoSinExtension = "";        
		   if (nombreArchivo.lastIndexOf(".") == -1){
		       nombreArchivoSinExtension = nombreArchivo;
		   } else {
		       nombreArchivoSinExtension = nombreArchivo.substring(0, nombreArchivo.lastIndexOf("."));
		   } 
		   return nombreArchivoSinExtension;
	   }

}
