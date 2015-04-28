/**
 * 
 */
package se.face.movieweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @author Samuel
 *
 */
@Controller
@RequestMapping(value = MovieController.PATH)
public class MovieController {
	public static final String PATH = "movie";
	
	@RequestMapping("/start")
	public String start(){
		return "hello";
	}
}
