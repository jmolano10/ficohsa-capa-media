(:: pragma bea:global-element-parameter parameter="$ecs1" element="ns0:ecs" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCredito" location="../../../../Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoFicohsa/pagoTCFicohsaIn/";

declare function xf:pagoTCFicohsaIn($debitAccount as xs:string,
    $ecs1 as element(ns0:ecs))
    as element(ns1:pagoTarjetaCredito) {
        <ns1:pagoTarjetaCredito>
            <CREDIT_CARD_NUMBER>{ data($ecs1/ns0:numero_cuenta) }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY>
            { 
            	if (fn:string($ecs1/ns0:moneda/text()) = ("1","LPS")) then (
            		"HNL"
            	) else if (fn:string($ecs1/ns0:moneda/text()) = "2") then (
            		"USD"
            	) else (
            		fn:string($ecs1/ns0:moneda/text())
            	)
            }
            </BALANCE_CURRENCY>
            <PAYMENT_AMOUNT>{ data($ecs1/ns0:total) }</PAYMENT_AMOUNT>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            <INTERFACE_REFERENCE_NO>{ fn:string($ecs1/ns0:out_referencia/text()) }</INTERFACE_REFERENCE_NO>
        </ns1:pagoTarjetaCredito>
};

declare variable $debitAccount as xs:string external;
declare variable $ecs1 as element(ns0:ecs) external;

xf:pagoTCFicohsaIn($debitAccount,
    $ecs1)