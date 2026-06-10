<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductoOnBase" element="ns0:consultaProductoOnBase" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseCGPTMHNIn/";

declare function xf:consultaProductoOnBaseCGPTMHNIn($consultaProductoOnBase as element(ns0:consultaProductoOnBase))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:LOAN_ID>{ data($consultaProductoOnBase/PRODUCT_NUMBER) }&lt;/ns1:LOAN_ID>
        &lt;/ns1:InputParameters>
};

declare variable $consultaProductoOnBase as element(ns0:consultaProductoOnBase) external;

xf:consultaProductoOnBaseCGPTMHNIn($consultaProductoOnBase)</con:xquery>
    <con:dependency location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO"/>
    </con:dependency>
</con:xqueryEntry>