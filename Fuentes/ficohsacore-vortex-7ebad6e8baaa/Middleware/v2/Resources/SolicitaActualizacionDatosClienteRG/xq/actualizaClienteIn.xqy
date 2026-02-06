xquery version "2004-draft";
(:: pragma  parameter="$request" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/actualizaCliente/xsd/actualizaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaActualizacionDatosClienteRG/xq/actualizaClienteIn/";

declare function xf:actualizaClienteIn($request as element(*))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_ACTUALIZADATOS>{ fn-bea:serialize($request) }</ns0:PN_ACTUALIZADATOS>
        </ns0:InputParameters>
};

declare variable $request as element(*) external;

xf:actualizaClienteIn($request)