/**
 * 
 */
package se.face.movieweb.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import se.face.movieweb.controller.ControllerPackage;
import se.face.movieweb.service.ServicePackage;

/**
 * @author Samuel
 *
 */
@EnableWebMvc
@Configuration
@ComponentScan(basePackageClasses = {ControllerPackage.class, ServicePackage.class})
public class AppConfig {	
}
