package com.test.webservice;

public class test {

	public static void main(String[] args) {
		CounterService service = new CounterService();
		CounterDelegate delegate = service.get1989();
		System.out.println(delegate.add(1, 1));
	}
}
