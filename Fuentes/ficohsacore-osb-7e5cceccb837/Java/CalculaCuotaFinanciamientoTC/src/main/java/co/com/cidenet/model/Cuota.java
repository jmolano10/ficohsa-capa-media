package co.com.cidenet.model;


import java.math.RoundingMode;

public class Cuota {
	private double cuotaMensual;
	private double valorSeguro;
	private double valorDesembolso;
	private double tasaAnual;
	private double tasaMensual;
        private String banderaSumaSeguro;

	/**
	 * Constructor de la clase
	 * @param plazo
	 * @param monto
	 * @param tasaAnual
	 * @param tasaSeguro
	 * @param tasaDesembolso
         * @param banderaSumaSeguro
	 */
	public Cuota(int plazo, double monto, double tasaAnual, double tasaSeguro, double tasaDesembolso, String banderaSumaSeguro) {
		this.banderaSumaSeguro = banderaSumaSeguro;
                this.tasaAnual = tasaAnual;
		this.tasaMensual = tasaAnual / 12;
		this.valorSeguro = monto*(tasaSeguro);
		this.valorDesembolso = monto*(tasaDesembolso);
                if (this.getBanderaSumaSeguro().equals("YES")) {
                    this.cuotaMensual = monto * (this.getTasaMensual()/100)
				* (1 / (1 - Math.pow((1 / (1 + (this.getTasaMensual()/100))), plazo))) + this.getValorSeguro();
                } else {
                    this.cuotaMensual = monto * (this.getTasaMensual()/100)
				* (1 / (1 - Math.pow((1 / (1 + (this.getTasaMensual()/100))), plazo)));
                }
		
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

        public String getBanderaSumaSeguro() {
            return banderaSumaSeguro;
        }

        public void setBanderaSumaSeguro(String banderaSumaSeguro) {
            this.banderaSumaSeguro = banderaSumaSeguro;
        }

}
