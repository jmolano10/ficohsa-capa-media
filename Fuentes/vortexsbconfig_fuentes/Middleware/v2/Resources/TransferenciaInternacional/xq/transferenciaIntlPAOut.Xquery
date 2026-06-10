<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaInternacionalResponse" location="../../../../Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalType.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaInternacional";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace xf = "http://tempuri.org/Middleware/transferenciaInternacionalOut/";

declare function xf:transferenciaInternacionalOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:transferenciaInternacionalResponse) {
        &lt;ns1:transferenciaInternacionalResponse>
            &lt;ORDERING_CUSTOMER>{ data($outputParameters1/ns0:ORDERING_CUSTOMER) }&lt;/ORDERING_CUSTOMER>
        &lt;/ns1:transferenciaInternacionalResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:transferenciaInternacionalOut($outputParameters1)</con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalType.xsd">
        <con:schema ref="Middleware/Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalType"/>
    </con:dependency>
</con:xqueryEntry>