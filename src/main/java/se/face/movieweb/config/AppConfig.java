/**
 * 
 */
package se.face.movieweb.config;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import se.face.movieweb.controller.ControllerPackage;
import se.face.movieweb.service.ServicePackage;

/**
 * @author Samuel
 *
 */
@EnableWebMvc
@Configuration
@ComponentScan(basePackageClasses = {ControllerPackage.class, ServicePackage.class})
public class AppConfig extends WebMvcConfigurerAdapter {	
	
	@Bean
	@Autowired
	public ContentNegotiatingViewResolver contentNegotiatingViewResolver(
			UrlBasedViewResolver urlBasedViewResolver, 
			MappingJackson2JsonView mappingJackson2JsonView, 
			ContentNegotiationManager contentNegotiationManager){
		ContentNegotiatingViewResolver contentNegotiatingViewResolver = new ContentNegotiatingViewResolver();
		contentNegotiatingViewResolver.setContentNegotiationManager(contentNegotiationManager);		
		contentNegotiatingViewResolver.setViewResolvers(Arrays.asList(urlBasedViewResolver));
		contentNegotiatingViewResolver.setDefaultViews(Arrays.asList(mappingJackson2JsonView));
		return contentNegotiatingViewResolver;
	}
	
	@Bean
	public UrlBasedViewResolver urlBasedViewResolver(){
		UrlBasedViewResolver urlBasedViewResolver = new UrlBasedViewResolver();
		urlBasedViewResolver.setViewClass(JstlView.class);
		urlBasedViewResolver.setPrefix("/WEB-INF/jsp/");
		urlBasedViewResolver.setSuffix(".jsp");
		return urlBasedViewResolver;		
	}
	@Bean
	public MappingJackson2JsonView mappingJackson2JsonView(){
		MappingJackson2JsonView mappingJackson2JsonView = new MappingJackson2JsonView();
		return mappingJackson2JsonView;		
	}
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/js/");
    }
	
	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer){
		configurer.
        	mediaType("text/html", MediaType.TEXT_HTML).
        	mediaType("json", MediaType.APPLICATION_JSON);
	}
}
