xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns1:consultaPasivosClienteRequest" location="../xsd/consultaPasivosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conDatosTarjetaCliente/xsd/conDatosTarjetaCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/conDatosTarjetaClienteGTIn/";

declare function xf:conDatosTarjetaClienteGTIn($consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
    let $customerId := data($consultaPasivosClienteRequest1/CUSTOMER_ID)
    return
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:NumCliente>{ fn-bea:pad-left($customerId, 19, '0') }</ns0:NumCliente>
        </ns0:InputParameters>
};

declare variable $consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest) external;
declare variable $codigoPais as xs:string external;

xf:conDatosTarjetaClienteGTIn($consultaPasivosClienteRequest1,
    $codigoPais)