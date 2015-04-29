/**
 * 
 */
package se.face.movieweb.service;

import java.util.Map;

/**
 * @author Samuel
 *
 */
public interface MovieService {
	Map<String, Object> searchMoviesByTitle(String title);
	
	Map<String, Object> getMovieById(int id);
}
