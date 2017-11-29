package com.miracle.jsw.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.jsw.service.InterCommuteService;

@Controller
@Component

public class CommuteController {
	
	//@Autowired
	//private InterCommuteService service;
	
	@RequestMapping(value="/commute.mr", method={RequestMethod.GET})
	public String commute(){
		
		
		
		return "jsw/commute.all";
	}
	
	
	
}
