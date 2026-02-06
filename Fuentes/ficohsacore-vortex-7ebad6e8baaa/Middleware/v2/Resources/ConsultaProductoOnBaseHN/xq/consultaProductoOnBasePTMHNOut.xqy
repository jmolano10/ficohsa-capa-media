xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductoOnBaseResponse" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBasePTMHNOut/";

declare function xf:consultaProductoOnBasePTMHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaProductoOnBaseResponse) {
        <ns0:consultaProductoOnBaseResponse>
            {
                for $LOAN_CUSTOMER_NAME in $outputParameters/ns1:LOAN_CUSTOMER_NAME
                return
                    <PRODUCT_NAME>{ data($LOAN_CUSTOMER_NAME) }</PRODUCT_NAME>
            }
            {
                for $CURRENCY in $outputParameters/ns1:CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $EFFECTIVE_DATE in $outputParameters/ns1:EFFECTIVE_DATE
                return
                    <OPENING_DATE>{ data($EFFECTIVE_DATE) }</OPENING_DATE>
            }
        </ns0:consultaProductoOnBaseResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaProductoOnBasePTMHNOut($outputParameters)