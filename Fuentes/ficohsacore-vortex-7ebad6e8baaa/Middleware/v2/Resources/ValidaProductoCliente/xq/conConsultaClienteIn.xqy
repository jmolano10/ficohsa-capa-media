xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoCliente/xq/conConsultaClienteIn/";

declare function xf:conConsultaClienteIn($productNumber as xs:string,
    $countryCode as xs:string,
    $customerId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $countryCode }</ns0:Pais>
            <ns0:NumCliente>{ $customerId }</ns0:NumCliente>
            <ns0:NumTarjeta>{ $productNumber }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $productNumber as xs:string external;
declare variable $countryCode as xs:string external;
declare variable $customerId as xs:string external;

xf:conConsultaClienteIn($productNumber,
    $countryCode,
    $customerId)