package test;

import java.math.BigDecimal;

import co.com.cidenet.calcularcuota.Application;

public class Test {

	public static void main(String[] args) {

		Application ap = new Application();		
		System.out.println(ap.calcularCuotaFinanciamientoTC(48, 120000 , 10,0.001430, 0.2,"YES"));

	}
}
