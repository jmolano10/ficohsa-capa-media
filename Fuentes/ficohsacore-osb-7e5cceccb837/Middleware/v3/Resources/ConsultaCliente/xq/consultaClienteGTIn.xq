(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaCliente/xsd/consultaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/abanksGT/consultaCliente/xq/consultaClienteIn2/";

declare function xf:consultaClienteIn2($tipoBusqueda as xs:string, $idCliente as xs:string)
    as element(ns0:InputParameters) {
    if ($tipoBusqueda = "CUSTOMER_ID") then (
        <ns0:InputParameters>
            <ns0:PV_CUSTOMER_ID>{ $idCliente }</ns0:PV_CUSTOMER_ID>
        </ns0:InputParameters>
    ) else (
        <ns0:InputParameters>
            <ns0:PV_LEGAL_ID>{ $idCliente }</ns0:PV_LEGAL_ID>
        </ns0:InputParameters>    
    )
	
};

declare variable $idCliente as xs:string external;
declare variable $tipoBusqueda as xs:string external;

xf:consultaClienteIn2($tipoBusqueda, $idCliente)