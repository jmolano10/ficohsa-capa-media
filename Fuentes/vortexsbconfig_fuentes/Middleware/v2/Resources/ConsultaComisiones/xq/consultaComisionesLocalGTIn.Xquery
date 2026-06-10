<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaComisiones/xsd/consultaComisiones_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesLocalGTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisiones";

declare function xf:consultaComisionesLocalGTIn($consultaComisiones as element(ns0:consultaComisiones))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
        	&lt;ns1:ACCOUNT_NUMBER>{ data($consultaComisiones/ADDITIONAL_INFO/INFO[NAME="ACCOUNT_NUMBER"]/VALUE) }&lt;/ns1:ACCOUNT_NUMBER>
        &lt;/ns1:InputParameters>
};

declare variable $consultaComisiones as element(ns0:consultaComisiones) external;
xf:consultaComisionesLocalGTIn($consultaComisiones)</con:xquery>
    <con:dependency location="../xsd/consultaComisionesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaComisiones/xsd/consultaComisionesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaComisiones/xsd/consultaComisiones_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaComisiones/xsd/consultaComisiones_sp"/>
    </con:dependency>
</con:xqueryEntry>