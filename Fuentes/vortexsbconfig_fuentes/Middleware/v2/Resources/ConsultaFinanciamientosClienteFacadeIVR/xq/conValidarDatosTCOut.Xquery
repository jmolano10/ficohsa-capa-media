<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaFinanciamientosCliente" location="../../ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosClienteFacadeIVR/xq/conValidarDatosTCOut/";

declare function xf:conValidarDatosTCOut($searchValue as xs:string,
    $searchCriteria as xs:string)
    as element(ns0:consultaFinanciamientosCliente) {
        <ns0:consultaFinanciamientosCliente>
            <SEARCH_VALUE>{ $searchValue }</SEARCH_VALUE>
            <SEARCH_CRITERIA>{ data($searchCriteria) }</SEARCH_CRITERIA>
        </ns0:consultaFinanciamientosCliente>
};

declare variable $searchValue as xs:string external;
declare variable $searchCriteria as xs:string external;

xf:conValidarDatosTCOut($searchValue,
    $searchCriteria)]]></con:xquery>
    <con:dependency location="../../ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>