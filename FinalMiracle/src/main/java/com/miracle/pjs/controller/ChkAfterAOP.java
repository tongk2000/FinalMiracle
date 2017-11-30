package com.miracle.pjs.controller;

import org.aopalliance.intercept.Joinpoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class ChkAfterAOP {
	@Pointcut("execution(public * com.miracle.pjs.*.*.afterAOP_*(..))")
	public void beforeAOP(){}

	@After("beforeAOP()")
	public void before(Joinpoint joinpoint) {
		
	}
	
}
