xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$calculaAmortizacionPrestamoRequest1" element="ns1:calculaAmortizacionPrestamoRequest" location="../xsd/calculaAmortizacionPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PWS/calculaAmortizacionPrestamo/xsd/calculaAmortizacionPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/calculaAmortizacionPrestamo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/calculaAmortizacionPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaAmortizacionPrestamo/xq/calculaAmortizacionPrestamoIn/";

declare function xf:calculaAmortizacionPrestamoIn($calculaAmortizacionPrestamoRequest1 as element(ns1:calculaAmortizacionPrestamoRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:AMOUNT>{ data($calculaAmortizacionPrestamoRequest1/AMOUNT) }</ns0:AMOUNT>
            <ns0:CURRENCY>{ data($calculaAmortizacionPrestamoRequest1/CURRENCY) }</ns0:CURRENCY>
            <ns0:ANNUAL_RATE>{ data($calculaAmortizacionPrestamoRequest1/ANNUAL_RATE) }</ns0:ANNUAL_RATE>
            <ns0:AMORTIZATION_TYPE>{ data($calculaAmortizacionPrestamoRequest1/AMORTIZATION_TYPE) }</ns0:AMORTIZATION_TYPE>
            <ns0:TERM>{ data($calculaAmortizacionPrestamoRequest1/TERM) }</ns0:TERM>
            <ns0:CLEARING_TYPE>{ data($calculaAmortizacionPrestamoRequest1/CLEARING_TYPE) }</ns0:CLEARING_TYPE>
            {
                for $FORMALIZATION_EXPENSE in $calculaAmortizacionPrestamoRequest1/FORMALIZATION_EXPENSE
                return
                    <ns0:FORMALIZATION_EXPENSE>{ data($FORMALIZATION_EXPENSE) }</ns0:FORMALIZATION_EXPENSE>
            }
            {
                for $LIFE_DEBT in $calculaAmortizacionPrestamoRequest1/INSURANCE_INFO/LIFE_DEBT
                return
                    <ns0:INSURANCE_LIFE_DEBT>{ data($LIFE_DEBT) }</ns0:INSURANCE_LIFE_DEBT>
            }
            {
                for $UNEMPLOYMENT in $calculaAmortizacionPrestamoRequest1/INSURANCE_INFO/UNEMPLOYMENT
                return
                    <ns0:INSURANCE_UNEMPLOYMENT>{ data($UNEMPLOYMENT) }</ns0:INSURANCE_UNEMPLOYMENT>
            }
            <ns0:DISBURSEMENT_DATE>{ data($calculaAmortizacionPrestamoRequest1/DISBURSEMENT_INFO/DATE) }</ns0:DISBURSEMENT_DATE>
            <ns0:DISBURSEMENT_RATE>{ data($calculaAmortizacionPrestamoRequest1/DISBURSEMENT_INFO/RATE) }</ns0:DISBURSEMENT_RATE>
            <ns0:FIRST_PAYMENT_DATE>{ data($calculaAmortizacionPrestamoRequest1/FIRST_PAYMENT_DATE) }</ns0:FIRST_PAYMENT_DATE>
        </ns0:InputParameters>
};

declare variable $calculaAmortizacionPrestamoRequest1 as element(ns1:calculaAmortizacionPrestamoRequest) external;

xf:calculaAmortizacionPrestamoIn($calculaAmortizacionPrestamoRequest1)