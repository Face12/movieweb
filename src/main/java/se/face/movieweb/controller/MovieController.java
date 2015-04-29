/**
 * 
 */
package se.face.movieweb.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import se.face.movieweb.service.MovieService;
/**
 * @author Samuel
 *
 */
@Controller
@RequestMapping(value = MovieController.PATH)
public class MovieController {
	public static final String PATH = "movie";
	
	@Autowired
	private MovieService movieService;
	
	@RequestMapping("/start")
	public String start(){
		return "movie";
	}
		
	@RequestMapping("/search")
	public @ResponseBody Map<String, Object> search(@RequestParam("q") String query){
		System.out.println("Searching for: "+query);
		return movieService.searchMoviesByTitle(query);
	}
	
	@RequestMapping("/get")
	public @ResponseBody Map<String, Object> search(@RequestParam("id") int id){
		System.out.println("Getting movie: "+id);
		return movieService.getMovieById(id);
	}
}
