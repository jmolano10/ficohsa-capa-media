(:: pragma bea:global-element-parameter parameter="$consultaFinanciamientosClienteResponse" element="ns0:consultaFinanciamientosClienteResponse" location="../../../../../../Middleware/v2/Resources/ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creditCardPayment" element="ns2:creditCardPayment" location="../../../../../v1/Resources/CreditCardOperations/xsd/CreditCardOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/creditCardOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v2/Resources/CreditCardOperations/CreditCardPayment/xq/financiamientosGTIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/creditCardTypes";

declare function xf:financiamientosGTIn($consultaFinanciamientosClienteResponse as element(ns0:consultaFinanciamientosClienteResponse),
    $creditCardPayment as element(ns2:creditCardPayment))
    as xs:string {
		for $row in $consultaFinanciamientosClienteResponse/consultaFinanciamientosClienteResponseRecordType[fn-bea:trim(FINANCING_REFERENCE) = $creditCardPayment/ns2:PAYMENT_TARGET/ns3:REFERENCE/text()]
		return
			fn:string($row/PLAN_SEQUENCE/text())    
};

declare variable $consultaFinanciamientosClienteResponse as element(ns0:consultaFinanciamientosClienteResponse) external;
declare variable $creditCardPayment as element(ns2:creditCardPayment) external;

xf:financiamientosGTIn($consultaFinanciamientosClienteResponse,
    $creditCardPayment)
