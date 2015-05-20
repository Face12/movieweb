/**
 * 
 */
package se.face.movieweb.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView startInternal(){
		return start("internal");
	}
	
	@RequestMapping("/startexternal")
	public ModelAndView startExternal(){
		return start("external");
	}
	
	private ModelAndView start(String type){
		ModelAndView mav = new ModelAndView("movie");
		mav.addObject("type", type);
		return mav;
	}
		
	@RequestMapping("/search")
	public @ResponseBody Map<String, Object> search(@RequestParam("q") String query){
		System.out.println("Searching for: "+query);
		return movieService.searchMoviesByTitle(query);
	}
	
	@RequestMapping("/get")
	public @ResponseBody Map<String, Object> get(@RequestParam("id") int id){
		System.out.println("Getting movie: "+id);
		return movieService.getMovieById(id);
	}
	
	@RequestMapping("/searchext")
	public @ResponseBody Map<String, Object> searchExternal(@RequestParam("q") String query){
		System.out.println("Searching externally for: "+query);
		return movieService.searchMoviesByTitleExternally(query);
	}
	
	@RequestMapping("/getext")
	public @ResponseBody Map<String, Object> getExternal(@RequestParam("id") String id){
		System.out.println("Getting external movie: "+id);
		return movieService.getMovieByIdExternally(id);
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> save(@RequestParam("id") String id){
		System.out.println("Saving movie: "+id);
		return movieService.saveMovieByExternalId(id);
	}
}
