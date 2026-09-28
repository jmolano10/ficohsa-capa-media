(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ITB/validarDepositoRef/xsd/validarDepositoRef_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarDepositoRef";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/DepRefIn/";

declare function xf:DepRefIn($message as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
            let $messageList := fn:tokenize($message,"@FM")
            return (
	            <ns0:PV_NUMEROCUENTA>{ $messageList[3] }</ns0:PV_NUMEROCUENTA>,
	            <ns0:PV_IDDEUDOR>{ $messageList[4] }</ns0:PV_IDDEUDOR>,
	            if ($messageList[1] = "I" and 
	            	$messageList[2] = "N") then (
	            	<ns0:PV_ACCION>A</ns0:PV_ACCION>
	            ) else (
	            	<ns0:PV_ACCION>C</ns0:PV_ACCION>
	            )
	        )
        }
        </ns0:InputParameters>
};

declare variable $message as xs:string external;

xf:DepRefIn($message)