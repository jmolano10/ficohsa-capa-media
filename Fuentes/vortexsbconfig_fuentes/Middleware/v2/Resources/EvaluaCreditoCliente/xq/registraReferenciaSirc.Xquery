<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:local-element-parameter parameter="$rEFERENCES" type="ns1:evaluaCreditoClienteRequest/BUREAUS/BUREAU/REFERENCES" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_SIRC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_REFERENCIAS_SIRC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registraReferenciaSirc/";

declare function xf:registraReferenciaSirc($rEFERENCES as element())
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            {
                
			&lt;ns0:pv_NumeroEvaluacion>{ $rEFERENCES }&lt;/ns0:pv_NumeroEvaluacion>
               
            }
        &lt;/ns0:InputParameters>
};

declare variable $rEFERENCES as element() external;

xf:registraReferenciaSirc($rEFERENCES)</con:xquery>
    <con:dependency location="../xsd/evaluaCreditoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/EvaluaCreditoCliente/xsd/evaluaCreditoClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_SIRC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_SIRC_sp"/>
    </con:dependency>
</con:xqueryEntry>