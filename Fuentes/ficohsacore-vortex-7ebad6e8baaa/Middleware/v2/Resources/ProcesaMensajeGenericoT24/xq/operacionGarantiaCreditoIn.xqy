xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PWS/operacionGarantiaCredito/xsd/operacionGarantiaCredito_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/operacionGarantiaCreditoIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/operacionGarantiaCredito";

declare function xf:operacionGarantiaCreditoIn($message as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
             {
	            let $messageList := fn:tokenize($message,"@FM")
	            return (
		            <ns0:LV_DETALLE_VINCULACION>{ $messageList[1] }</ns0:LV_DETALLE_VINCULACION>,
		            <ns0:LV_NUMERO_CUENTA>{ $messageList[2] }</ns0:LV_NUMERO_CUENTA>,
		            <ns0:LV_COD_PRODUCTO>{ $messageList[3] }</ns0:LV_COD_PRODUCTO>,
		            <ns0:LV_OPERACION>{ $messageList[4] }</ns0:LV_OPERACION>,
		            <ns0:LN_VALOR>{ $messageList[5] }</ns0:LN_VALOR>,
		            <ns0:LV_MONEDA>{ $messageList[6] }</ns0:LV_MONEDA>
	            )
	        }
        </ns0:InputParameters>
};

declare variable $message as xs:string external;

xf:operacionGarantiaCreditoIn($message)