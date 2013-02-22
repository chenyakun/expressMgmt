package com.test.webservice;

@javax.jws.WebService(targetNamespace = "http://webservice.test.com/", serviceName = "CounterService", portName = "1989")
public class CounterDelegate {

	com.test.webservice.Counter counter = new com.test.webservice.Counter();

	public int add(int num1, int num2) {
		return counter.add(num1, num2);
	}

}