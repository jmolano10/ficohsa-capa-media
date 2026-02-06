xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/validaDepositoReferenciado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaDepositoReferenciado";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/xq/validaDepositoReferenciadoIn/";

declare function xf:validaDepositoReferenciadoIn($numeroCuenta as xs:string, $tipoDocumento as xs:string, $documento as xs:string)
    as element(ns0:InputParameters) {
if ($tipoDocumento = "DEBTOR_CODE") then (    
<ns0:InputParameters>
    	<ns0:PV_NUMERO_CUENTA>{ $numeroCuenta }</ns0:PV_NUMERO_CUENTA>
    	<ns0:PV_TIPO_DOCUMENTO>1</ns0:PV_TIPO_DOCUMENTO>
    	<ns0:PV_DOCUMENTO>{ $documento }</ns0:PV_DOCUMENTO>
    </ns0:InputParameters>
) else (
<ns0:InputParameters>
    	<ns0:PV_NUMERO_CUENTA>{ $numeroCuenta }</ns0:PV_NUMERO_CUENTA>
    	<ns0:PV_TIPO_DOCUMENTO>2</ns0:PV_TIPO_DOCUMENTO>
    	<ns0:PV_DOCUMENTO>{ $documento }</ns0:PV_DOCUMENTO>
    </ns0:InputParameters>
)
};

declare variable $numeroCuenta as xs:string external;
declare variable $tipoDocumento as xs:string external;
declare variable $documento as xs:string external;

xf:validaDepositoReferenciadoIn($numeroCuenta, $tipoDocumento, $documento)