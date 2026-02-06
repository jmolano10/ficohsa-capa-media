xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PWS/consultaGarantiasCredito/xsd/consultaGarantiasCredito_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaGarantiasCreditoIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGarantiasCredito";

declare function xf:consultaGarantiasCreditoIn($message as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
             {
	            let $messageList := fn:tokenize($message,"@FM")
	            return (
	            <ns0:LN_CODIGO_CLIENTE>{ $messageList[1] }</ns0:LN_CODIGO_CLIENTE>,
	            <ns0:LV_CODIGO_PRODUCTO>{ $messageList[2] }</ns0:LV_CODIGO_PRODUCTO>
	            )
	        }
        </ns0:InputParameters>
};

declare variable $message as xs:string external;

xf:consultaGarantiasCreditoIn($message)