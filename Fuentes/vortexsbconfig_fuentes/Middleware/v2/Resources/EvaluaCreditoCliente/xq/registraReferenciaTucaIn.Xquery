<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:local-element-parameter parameter="$rEFERENCES" type="ns0:evaluaCreditoClienteRequest/BUREAUS/BUREAU/REFERENCES" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_TUCA_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_REFERENCIAS_TUCA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registraReferenciaTucaIn/";

declare function xf:registraReferenciaTucaIn($rEFERENCES as element())
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            {
                &lt;ns1:pv_NumeroEvaluacion>{ $rEFERENCES }&lt;/ns1:pv_NumeroEvaluacion>
            }
        &lt;/ns1:InputParameters>
};

declare variable $rEFERENCES as element() external;

xf:registraReferenciaTucaIn($rEFERENCES)</con:xquery>
    <con:dependency location="../xsd/evaluaCreditoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/EvaluaCreditoCliente/xsd/evaluaCreditoClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_TUCA_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_TUCA_sp"/>
    </con:dependency>
</con:xqueryEntry>