<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorCliente1" element="ns1:consultaTarjetasCreditoPorCliente" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataPA/conDatosTarjetasActivasCliente/xsd/conDatosTarjetasActivasCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetasActivasCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xq/conDatosTarjetasActivasClientePAIn/";

declare function xf:conDatosTarjetasActivasClientePAIn($codigoPais as xs:string,
    $consultaTarjetasCreditoPorCliente1 as element(ns1:consultaTarjetasCreditoPorCliente))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:NumCliente>{ data($consultaTarjetasCreditoPorCliente1/CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</ns0:NumCliente>
            <ns0:Tipo>{ data($consultaTarjetasCreditoPorCliente1/CUSTOMER_FILTER/CUSTOMER_ID_TYPE) }</ns0:Tipo>
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $consultaTarjetasCreditoPorCliente1 as element(ns1:consultaTarjetasCreditoPorCliente) external;

xf:conDatosTarjetasActivasClientePAIn($codigoPais,
    $consultaTarjetasCreditoPorCliente1)]]></con:xquery>
    <con:dependency location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MasterDataPA/conDatosTarjetasActivasCliente/xsd/conDatosTarjetasActivasCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataPA/conDatosTarjetasActivasCliente/xsd/conDatosTarjetasActivasCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>