<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma  parameter="$RSPAltaSeguros" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:ingresaVentaSegurosResponse" location="../xsd/ingresaVentaSegurosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ingresaVentaSegurosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguro/xq/ingresaVentaSegurosHNOut/";

declare function xf:ingresaVentaSegurosHNOut($RSPAltaSeguros as element(*))
    as element(ns0:ingresaVentaSegurosResponse) {
        <ns0:ingresaVentaSegurosResponse>
            <INSURANCE_POLICY_CODE>{ $RSPAltaSeguros/codigoPolizaMadre/text() }</INSURANCE_POLICY_CODE>
            <CERTIFICATE_NUMBER>{ $RSPAltaSeguros/numeroCertificado/text() }</CERTIFICATE_NUMBER>
            <CERTIFICATE_SERIE>{ $RSPAltaSeguros/serieCertificado/text() }</CERTIFICATE_SERIE>
        </ns0:ingresaVentaSegurosResponse>
};

declare variable $RSPAltaSeguros as element(*) external;

xf:ingresaVentaSegurosHNOut($RSPAltaSeguros)]]></con:xquery>
    <con:dependency location="../xsd/ingresaVentaSegurosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/IngresaVentaSeguros/xsd/ingresaVentaSegurosTypes"/>
    </con:dependency>
</con:xqueryEntry>