<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaTipoTarjeta1" element="ns1:sjConsultaTipoTarjeta" location="../xsd/sjConsultaTipoTarjeta.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABK/consultarBinesTC/xsd/consultarBinesTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjeta";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarBines";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/xq/sjConsultaBinesTCIn/";

declare function xf:sjConsultaBinesTCIn($sjConsultaTipoTarjeta1 as element(ns1:sjConsultaTipoTarjeta))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_BIN>{ fn:string($sjConsultaTipoTarjeta1/ns1:BIN_NUMBER/text()) }&lt;/ns0:PV_BIN>
        &lt;/ns0:InputParameters>
};

declare variable $sjConsultaTipoTarjeta1 as element(ns1:sjConsultaTipoTarjeta) external;

xf:sjConsultaBinesTCIn($sjConsultaTipoTarjeta1)</con:xquery>
    <con:dependency location="../xsd/sjConsultaTipoTarjeta.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/xsd/sjConsultaTipoTarjeta"/>
    </con:dependency>
    <con:dependency location="../../../ABK/consultarBinesTC/xsd/consultarBinesTC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultarBinesTC/xsd/consultarBinesTC_sp"/>
    </con:dependency>
</con:xqueryEntry>