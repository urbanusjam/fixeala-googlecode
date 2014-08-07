package ar.com.urbanusjam.web.services.export.transformer;

import org.apache.commons.collections.Transformer;

import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.services.export.dto.IssueExcelDTO;

public class IssueDTOTransformer implements Transformer {

	@Override
	public Object transform(Object input) {
		 if (input instanceof IssueDTO) {
	            
			 IssueDTO issue = (IssueDTO) input;            
	         IssueExcelDTO dto = new IssueExcelDTO();
	     
	         dto.setNroReclamo(issue.getId());
	         dto.setFecha(issue.getFechaFormateada());
	         dto.setRubro(null);
	         
//	         if( issue.getTags() != null || issue.getTags().size() > 0 )
//	        	 dto.setCategoria(issue.getTags().toString());
//	         else
	        	 dto.setCategoria(issue.getCategorias());
	         dto.setTitulo(issue.getTitle());
	         dto.setDireccion(issue.getAddress());
	         dto.setBarrio(issue.getNeighborhood() != null ? issue.getNeighborhood() : null);
	         dto.setCiudad(issue.getCity());
	         dto.setProvincia(issue.getProvince());
	         dto.setLatitud(issue.getLatitude());
	         dto.setLongitud(issue.getLongitude());
	         dto.setEstado(issue.getStatus());
	         	            
	         return dto;
	         
	     } else
	            return new IssueExcelDTO();
	}

}
