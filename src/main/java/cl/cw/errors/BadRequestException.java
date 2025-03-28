package cl.cw.errors;

/**
 * Company: [CrossWave SPA]
 * Project: AFIP Authentication System
 * Author: [Ignacio Vegas Fernández]
 * Description: Custom exception for handling bad request errors.
 */

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class BadRequestException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public BadRequestException(String message) {
        super(message);
    }
}