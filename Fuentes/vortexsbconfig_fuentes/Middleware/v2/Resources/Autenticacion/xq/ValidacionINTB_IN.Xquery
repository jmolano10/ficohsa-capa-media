<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionBasica1" element="ns0:validacionBasica" location="../xsd/autenticacionInternaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ITB/validaCredenciales/xsd/validarCredencialesITINTB_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarCredencialesITINTB";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autenticacionInternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Autenticacion/xq/ValidacionINTB_IN/";

declare function xf:ValidacionINTB_IN($validacionBasica1 as element(ns0:validacionBasica))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_USUARIO>{ data($validacionBasica1/USERNAME) }</ns1:PV_USUARIO>
            <ns1:PV_PASSWORD>{ data($validacionBasica1/PASSWORD) }</ns1:PV_PASSWORD>
        </ns1:InputParameters>
};

declare variable $validacionBasica1 as element(ns0:validacionBasica) external;

xf:ValidacionINTB_IN($validacionBasica1)]]></con:xquery>
    <con:dependency location="../xsd/autenticacionInternaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/Autenticacion/xsd/autenticacionInternaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ITB/validaCredenciales/xsd/validarCredencialesITINTB_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ITB/validaCredenciales/xsd/validarCredencialesITINTB_sp"/>
    </con:dependency>
</con:xqueryEntry>