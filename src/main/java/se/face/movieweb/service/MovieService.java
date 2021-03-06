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
	
	Map<String, Object> searchMoviesByTitleExternally(String title);
	
	Map<String, Object> getMovieByIdExternally(String imdbId);

	Map<String, Object> saveMovieByExternalId(String id);
}
