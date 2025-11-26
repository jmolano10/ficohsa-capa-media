xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoTCporACHRecibidaenLineaResponse" element="ns0:PagoTCporACHRecibidaenLineaResponse" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTCACHRecibidaResponse" location="../xsd/pagoTCACHRecibida.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTCACHRecibida/xq/pagoTCACHRecibidaOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTCACHRecibida";

declare function xf:pagoTCACHRecibidaOut($pagoTCporACHRecibidaenLineaResponse as element(ns0:PagoTCporACHRecibidaenLineaResponse))
    as element(ns1:pagoTCACHRecibidaResponse) {
    	let $TELLERFINANCIALSERVICESType := $pagoTCporACHRecibidaenLineaResponse/TELLERFINANCIALSERVICESType
        return
        	if(exists($TELLERFINANCIALSERVICESType)) then (
	            <ns1:pagoTCACHRecibidaResponse>
	                <LCY_PAYMENT>{ data($TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/AMOUNTDRLCY) }</LCY_PAYMENT>
	                <PAYMENT_CURRENCY>{ data($TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/CURRENCYDR) }</PAYMENT_CURRENCY>
	                <BALANCE_PAYMENT>{ data($TELLERFINANCIALSERVICESType/LROTHAMT) }</BALANCE_PAYMENT>
	                <BALANCE_CURRENCY>{ data($TELLERFINANCIALSERVICESType/LRCRCCY) }</BALANCE_CURRENCY>
	                <EXCHANGE_RATE>{ data($TELLERFINANCIALSERVICESType/gLR.ECONOMIC.ACT/mLR.ECONOMIC.ACT[1]/LRCUSTRATE) }</EXCHANGE_RATE>
	                <DEBIT_ACCOUNT>{ data($TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/ACCOUNTDR) }</DEBIT_ACCOUNT>
	                <DATE_TIME>{ concat("20",$pagoTCporACHRecibidaenLineaResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1]) }</DATE_TIME>
	            </ns1:pagoTCACHRecibidaResponse>
	         ) else (
	         	 <ns1:pagoTCACHRecibidaResponse/>
	         )
};

declare variable $pagoTCporACHRecibidaenLineaResponse as element(ns0:PagoTCporACHRecibidaenLineaResponse) external;

xf:pagoTCACHRecibidaOut($pagoTCporACHRecibidaenLineaResponse)