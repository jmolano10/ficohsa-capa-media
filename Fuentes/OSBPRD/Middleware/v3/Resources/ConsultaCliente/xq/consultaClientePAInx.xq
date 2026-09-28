(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaCliente/xsd/consultaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClientePAInx/";

declare function xf:consultaClientePAInx($tipoBusqueda as xs:string,
    $idCliente as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CUSTOMER_ID>{ $idCliente }</ns0:PV_CUSTOMER_ID>
        </ns0:InputParameters>
};

declare variable $tipoBusqueda as xs:string external;
declare variable $idCliente as xs:string external;

xf:consultaClientePAInx($tipoBusqueda,
    $idCliente)