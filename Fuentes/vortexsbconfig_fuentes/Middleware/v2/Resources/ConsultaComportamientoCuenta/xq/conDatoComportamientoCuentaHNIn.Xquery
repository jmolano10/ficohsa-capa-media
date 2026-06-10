<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComportamientoCuenta" element="ns0:consultaComportamientoCuenta" location="../xsd/consultaComportamientoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataHN/conDatoComportamientoCuenta/xsd/conDatoComportamientoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComportamientoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoComportamientoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComportamientoCuenta/xq/conDatoComportamientoCuentaHNIn/";

declare function xf:conDatoComportamientoCuentaHNIn($consultaComportamientoCuenta as element(ns0:consultaComportamientoCuenta),
    $countryCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $countryCode }</ns1:Pais>
            {
                for $ORG in $consultaComportamientoCuenta/ORG
                return
                if(string($ORG/text()) != "")then(
                    <ns1:Org>{ data($ORG) }</ns1:Org>
                )else ()
            }
            <ns1:NumCuenta>{ data($consultaComportamientoCuenta/CARD_NUMBER) }</ns1:NumCuenta>
        </ns1:InputParameters>
};

declare variable $consultaComportamientoCuenta as element(ns0:consultaComportamientoCuenta) external;
declare variable $countryCode as xs:string external;

xf:conDatoComportamientoCuentaHNIn($consultaComportamientoCuenta,
    $countryCode)]]></con:xquery>
    <con:dependency location="../xsd/consultaComportamientoCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaComportamientoCuenta/xsd/consultaComportamientoCuentaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MasterDataHN/conDatoComportamientoCuenta/xsd/conDatoComportamientoCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataHN/conDatoComportamientoCuenta/xsd/conDatoComportamientoCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>