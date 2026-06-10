<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DCP/regitroBitacoraVtaMenor/xsd/registroBitacoraVtaMenor_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroBitacoraVtaMenor";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/registroBitacoraVtaMenor/";

declare function xf:registroBitacoraVtaMenor($solicitud as xs:string,
    $Respuesta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SOLICITUD>{ $solicitud }</ns0:PV_SOLICITUD>
            <ns0:PV_RESPUESTA>{ $Respuesta }</ns0:PV_RESPUESTA>
        </ns0:InputParameters>
};

declare variable $solicitud as xs:string external;
declare variable $Respuesta as xs:string external;

xf:registroBitacoraVtaMenor($solicitud,
    $Respuesta)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/DCP/regitroBitacoraVtaMenor/xsd/registroBitacoraVtaMenor_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DCP/regitroBitacoraVtaMenor/xsd/registroBitacoraVtaMenor_sp"/>
    </con:dependency>
</con:xqueryEntry>