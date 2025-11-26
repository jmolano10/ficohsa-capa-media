package co.com.cidenet.model;

import java.util.Calendar; 
import java.util.Date; 
import java.text.SimpleDateFormat; 
import java.text.ParseException;

public class Cuota {

    private double cuotaMensual;
    private double valorSeguro;
    private double valorDesembolso;
    private double tasaAnual;
    private double tasaMensual;
    private boolean sumaSeguro;
    private double factorDescuentoTotal;

    /**
     * Constructor de la clase
     *
     * @param plazo
     * @param monto
     * @param tasaAnual
     * @param tasaSeguro
     * @param tasaDesembolso
     * @param banderaSumaSeguro
     * @param ultimoCorte
     */
    public Cuota(int plazo, double monto, double tasaAnual, double tasaSeguro, double tasaDesembolso, String banderaSumaSeguro, String ultimoCorte) {
        this.sumaSeguro = "YES".equalsIgnoreCase(banderaSumaSeguro);
        this.tasaAnual = tasaAnual;
        this.tasaMensual = tasaAnual / 12;
        this.valorSeguro = monto * tasaSeguro;
        this.valorDesembolso = monto * tasaDesembolso;
        this.factorDescuentoTotal = this.calculaFactorDescuento(ultimoCorte, plazo);

        // Calcular cuota mensual con o sin seguro
        this.cuotaMensual = monto / this.factorDescuentoTotal + (this.sumaSeguro ? this.valorSeguro : 0);

    }
    private double calculaFactorDescuento (String ultimoCorte, int plazo){
        double factorDescuento = 1;
        double sumaFactorDescuento = 0;
        long diasMes = 0;
        try {
	        //Se extrae la fecha del ultimo corte devuelta en el nuevo campo del SP de Blaze
	        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
	        Date fechaUltimoCorte = formatoFecha.parse(ultimoCorte); 
	        Calendar calendario = Calendar.getInstance(); 
	        calendario.setTime(fechaUltimoCorte); 
	        
	        // Sumar un mes a la fecha de último corte 
	        calendario.add(Calendar.MONTH, 1); 
	        Date fechaCorte = calendario.getTime(); 
	        
	        // Sumar otro mes para obtener la fecha del siguiente corte 
	        calendario.add(Calendar.MONTH, 1); 
	        Date fechaSiguienteCorte = calendario.getTime(); 
	
	        //For para el calculo total del factor descuento
	        for (int i = 1; i <= plazo; i++) {
	        	// Calcular los días entre las dos fechas long diasMes; 
        		long diff = fechaSiguienteCorte.getTime() - fechaCorte.getTime(); 
        		diasMes = diff / (1000 * 60 * 60 * 24); // convertir milisegundos a días 
	        	//Calcula Tasa Efectiva por mes
	            double tasaEfectiva = ((diasMes / 360.0) * this.tasaAnual) / 100;
	            //Calcula Factor descuento del mes
	            factorDescuento *= (Math.pow(1 + tasaEfectiva, -1));

	            fechaCorte = fechaSiguienteCorte;
	            //Obtiene siguiente fecha de corte
	            calendario.setTime(fechaCorte); 
		        calendario.add(Calendar.MONTH, 1); 
		        fechaSiguienteCorte = calendario.getTime(); 

	            sumaFactorDescuento += factorDescuento;
	        }
        } catch (ParseException e) { 
        	e.printStackTrace(); 
        	sumaFactorDescuento = 0;
        }
        return sumaFactorDescuento;
    }

    public double getCuotaMensual() {
        return cuotaMensual;
    }

    public void setCuotaMensual(double cuotaMensual) {
        this.cuotaMensual = cuotaMensual;
    }

    public double getValorSeguro() {
        return valorSeguro;
    }

    public void setValorSeguro(double valorSeguro) {
        this.valorSeguro = valorSeguro;
    }

    public double getValorDesembolso() {
        return valorDesembolso;
    }

    public void setValorDesembolso(double valorDesembolso) {
        this.valorDesembolso = valorDesembolso;
    }

    public double getTasaAnual() {
        return tasaAnual;
    }

    public void setTasaAnual(double tasaAnual) {
        this.tasaAnual = tasaAnual;
    }

    public double getTasaMensual() {
        return tasaMensual;
    }

    public void setTasaMensual(double tasaMensual) {
        this.tasaMensual = tasaMensual;
    }
    
    public boolean isSumaSeguro() {
        return sumaSeguro;
    }

    public void setSumaSeguro(boolean sumaSeguro) {
        this.sumaSeguro = sumaSeguro;
    }
}
