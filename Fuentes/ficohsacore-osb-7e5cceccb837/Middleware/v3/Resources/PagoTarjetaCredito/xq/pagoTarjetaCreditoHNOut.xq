(:: pragma bea:global-element-parameter parameter="$pagodetarjetadecreditoResponse" element="ns0:PagodetarjetadecreditoResponse" location="../../../../Business_Resources/tarjetaCredito/Resources/XMLSchema_-604480245.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoHNOut/";

declare function xf:pagoTarjetaCreditoHNOut($pagodetarjetadecreditoResponse as element(ns0:PagodetarjetadecreditoResponse))
    as element(ns1:pagoTarjetaCreditoResponse) {
   		 let $TELLERFINANCIALSERVICESType := $pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType
      	 return
	    	if(exists($TELLERFINANCIALSERVICESType)) then (
		        <ns1:pagoTarjetaCreditoResponse>
		            <LCY_PAYMENT>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/AMOUNTDR) }</LCY_PAYMENT>
		            <PAYMENT_CURRENCY>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/CURRENCYDR) }</PAYMENT_CURRENCY>
		            <BALANCE_PAYMENT>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/LROTHAMT) }</BALANCE_PAYMENT>
		            <BALANCE_CURRENCY>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/LRCRCCY) }</BALANCE_CURRENCY>
		            <EXCHANGE_RATE>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gLR.ECONOMIC.ACT/mLR.ECONOMIC.ACT[1]/LRCUSTRATE) }</EXCHANGE_RATE>
		            <DEBIT_ACCOUNT>{ data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/ACCOUNTDR) }</DEBIT_ACCOUNT>
		            <DATE_TIME>{ concat("20",data($pagodetarjetadecreditoResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1])) }</DATE_TIME>
		        </ns1:pagoTarjetaCreditoResponse>
	        ) else (
		         	 <ns1:pagoTarjetaCreditoResponse/>
		         )
};

declare variable $pagodetarjetadecreditoResponse as element(ns0:PagodetarjetadecreditoResponse) external;

xf:pagoTarjetaCreditoHNOut($pagodetarjetadecreditoResponse)