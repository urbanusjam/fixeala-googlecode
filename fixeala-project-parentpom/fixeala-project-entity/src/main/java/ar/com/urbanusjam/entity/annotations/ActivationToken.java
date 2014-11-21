package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="activation")
public class ActivationToken extends Token implements Serializable {
	
	private static final long serialVersionUID = 1L;

}
