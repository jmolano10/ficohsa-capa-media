(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaGeneralPrestamo/xsd/consultaGeneralPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGeneralPrestamo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClientePA/xq/validaProductoClientePTMPAOut/";

declare function xf:validaProductoClientePTMPAOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:validaProductoClienteResponse) {
        <ns0:validaProductoClienteResponse>
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
        </ns0:validaProductoClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:validaProductoClientePTMPAOut($outputParameters)