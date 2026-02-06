xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoTengoResponse" element="ns0:PagoTarjetaCreditoTengoResponse" location="../../../../v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoHNCorrOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";

declare function xf:pagoTarjetaCreditoHNCorrOut($pagoTarjetaCreditoTengoResponse as element(ns0:PagoTarjetaCreditoTengoResponse))
    as element(ns1:pagoTarjetaCreditoResponse) {
        let $TELLERFINANCIALSERVICESType := $pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType
      	 return
	    	if(exists($TELLERFINANCIALSERVICESType)) then (
		        <ns1:pagoTarjetaCreditoResponse>
		            <LCY_PAYMENT>{ data($pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/AMOUNTDR) }</LCY_PAYMENT>
		            <PAYMENT_CURRENCY>{ data($pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/CURRENCYDR) }</PAYMENT_CURRENCY>
		            <BALANCE_PAYMENT>{ data($pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/LROTHAMT) }</BALANCE_PAYMENT>
		            <BALANCE_CURRENCY>{ data($pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/LRCRCCY) }</BALANCE_CURRENCY>
		            <EXCHANGE_RATE>{ data($pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/gLR.ECONOMIC.ACT/mLR.ECONOMIC.ACT[1]/LRCUSTRATE) }</EXCHANGE_RATE>
		            <DEBIT_ACCOUNT>{ data($pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/ACCOUNTDR) }</DEBIT_ACCOUNT>
		            <DATE_TIME>{ concat("20",data($pagoTarjetaCreditoTengoResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1])) }</DATE_TIME>
		        </ns1:pagoTarjetaCreditoResponse>
	        ) else (
		         	 <ns1:pagoTarjetaCreditoResponse/>
		         )
};

declare variable $pagoTarjetaCreditoTengoResponse as element(ns0:PagoTarjetaCreditoTengoResponse) external;

xf:pagoTarjetaCreditoHNCorrOut($pagoTarjetaCreditoTengoResponse)