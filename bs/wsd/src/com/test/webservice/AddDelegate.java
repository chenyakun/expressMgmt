package com.test.webservice;

@javax.jws.WebService(targetNamespace = "http://webservice.test.com/", serviceName = "AddService", portName = "80")
public class AddDelegate {

	com.test.webservice.Add add = new com.test.webservice.Add();

	public String sayHello() {
		return add.sayHello();
	}

}