xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductoOnBase" element="ns0:consultaProductoOnBase" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseCGPTMHNIn/";

declare function xf:consultaProductoOnBaseCGPTMHNIn($consultaProductoOnBase as element(ns0:consultaProductoOnBase))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($consultaProductoOnBase/PRODUCT_NUMBER) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $consultaProductoOnBase as element(ns0:consultaProductoOnBase) external;

xf:consultaProductoOnBaseCGPTMHNIn($consultaProductoOnBase)