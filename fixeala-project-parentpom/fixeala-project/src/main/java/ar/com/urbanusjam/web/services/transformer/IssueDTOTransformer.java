package ar.com.urbanusjam.web.services.transformer;

import org.apache.commons.collections.Transformer;

import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.domain.api.DataResponse;
import ar.com.urbanusjam.web.domain.api.ReclamoResponse;

public class IssueDTOTransformer implements Transformer {

	@Override
	public Object transform(Object input) {
		 if (input instanceof IssueDTO) {
	            
			 IssueDTO issue = (IssueDTO) input;            
	         DataResponse dto = new DataResponse();
	     
	         dto.setNroReclamo(issue.getId());
	         dto.setFecha(issue.getFechaFormateada());
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
	            return new DataResponse();
	}

}
