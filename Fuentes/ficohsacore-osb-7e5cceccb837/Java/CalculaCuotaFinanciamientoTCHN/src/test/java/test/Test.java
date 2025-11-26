package test;

import co.com.cidenet.model.Cuota;

public class Test {

	public static void main(String[] args) {

		Cuota ap = new Cuota(12, 50000 , 40, 0.0011, 0.025,"YES","2024-12-05");		
		System.out.println(ap.getCuotaMensual());

	}
}
class Main {
    public static void main(String[] args) {
        Cuota ap = new Cuota(12, 50000 , 40, 0.0011, 0.025,"NO","2024-12-05");		
	System.out.println(ap.getCuotaMensual());
    }
}