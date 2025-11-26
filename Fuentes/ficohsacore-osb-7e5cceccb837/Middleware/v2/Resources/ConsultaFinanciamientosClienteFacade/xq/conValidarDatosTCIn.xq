(:: pragma bea:global-element-parameter parameter="$consultaFinanciamientosCliente" element="ns0:consultaFinanciamientosCliente" location="../../ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/MasterDataHN/conValidarDatosTC/xsd/conValidarDatosTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conValidarDatosTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosClienteFacade/xq/conValidarDatosTCIn/";

declare function xf:conValidarDatosTCIn($consultaFinanciamientosCliente as element(ns0:consultaFinanciamientosCliente),
    $codigoPais as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:Pais>{ $codigoPais }</ns2:Pais>
            <ns2:NumCliente>{ data($consultaFinanciamientosCliente/KV_PAIRS/KV_PAIR[fn:upper-case(KEY) = "LEGAL_ID"]/VALUE) }</ns2:NumCliente>
			<ns2:NumTarjeta>{fn:substring(data(fn-bea:pad-left($consultaFinanciamientosCliente/SEARCH_VALUE, 19, '0')), 16) }</ns2:NumTarjeta>
        </ns2:InputParameters>
};
declare variable $consultaFinanciamientosCliente as element(ns0:consultaFinanciamientosCliente) external;
declare variable $codigoPais as xs:string external;

xf:conValidarDatosTCIn($consultaFinanciamientosCliente,
    $codigoPais)