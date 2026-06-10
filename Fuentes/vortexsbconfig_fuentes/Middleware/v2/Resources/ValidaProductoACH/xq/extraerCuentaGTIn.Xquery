<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/extraerCuentaIBAN/xsd/extraerCuentaIBAN_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/extraerCuentaIBAN";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/extraerCuentaGTIn/";

declare function xf:extraerCuentaGTIn($validaProductoACH as element(ns0:validaProductoACH))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_CUENTA_IBAN>{ data($validaProductoACH/PRODUCT_NUMBER) }&lt;/ns1:PV_CUENTA_IBAN>
        &lt;/ns1:InputParameters>
};

declare variable $validaProductoACH as element(ns0:validaProductoACH) external;

xf:extraerCuentaGTIn($validaProductoACH)</con:xquery>
    <con:dependency location="../xsd/validaProductoACHTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoACH/xsd/validaProductoACHTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/extraerCuentaIBAN/xsd/extraerCuentaIBAN_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/extraerCuentaIBAN/xsd/extraerCuentaIBAN_sp"/>
    </con:dependency>
</con:xqueryEntry>