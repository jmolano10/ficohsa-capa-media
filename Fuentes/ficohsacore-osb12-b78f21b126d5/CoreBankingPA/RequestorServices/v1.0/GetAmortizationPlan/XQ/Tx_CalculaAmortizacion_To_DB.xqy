xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamo";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/getLoanDetails.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AmortizationSchedule_BS";
(:: import schema at "../../../../../LegacyCoreBankingHN/ProviderServices/XSD/CalculateAmortizationSchedule/AmortizationSchedule_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $calculaAmortizacion as element() (:: schema-element(ns1:amortizationScheduleRequest) ::) external;

declare function xq:Tx_CalculaAmortizacion_To_DB($calculaAmortizacion as element() (:: schema-element(ns1:amortizationScheduleRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($calculaAmortizacion/ns1:Amount)
            then <ns2:AMOUNT>{fn:data($calculaAmortizacion/ns1:Amount)}</ns2:AMOUNT>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:Currency)
            then <ns2:CURRENCY>{fn:data($calculaAmortizacion/ns1:Currency)}</ns2:CURRENCY>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:AnnualRate)
            then <ns2:ANNUAL_RATE>{fn:data($calculaAmortizacion/ns1:AnnualRate)}</ns2:ANNUAL_RATE>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:AmortizationType)
            then <ns2:AMORTIZATION_TYPE>{fn:data($calculaAmortizacion/ns1:AmortizationType)}</ns2:AMORTIZATION_TYPE>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:Term)
            then <ns2:TERM>{fn:data($calculaAmortizacion/ns1:Term)}</ns2:TERM>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:ClearingType)
            then <ns2:CLEARING_TYPE>{fn:data($calculaAmortizacion/ns1:ClearingType)}</ns2:CLEARING_TYPE>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:FormalizationExpense)
            then <ns2:FORMALIZATION_EXPENSE>{fn:data($calculaAmortizacion/ns1:FormalizationExpense)}</ns2:FORMALIZATION_EXPENSE>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:InsuranceInfo/ns1:LifeDebt)
            then <ns2:INSURANCE_LIFE_DEBT>{fn:data($calculaAmortizacion/ns1:InsuranceInfo/ns1:LifeDebt)}</ns2:INSURANCE_LIFE_DEBT>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:InsuranceInfo/ns1:Unemployment)
            then <ns2:INSURANCE_UNEMPLOYMENT>{fn:data($calculaAmortizacion/ns1:InsuranceInfo/ns1:Unemployment)}</ns2:INSURANCE_UNEMPLOYMENT>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:DisbursementInfo/ns1:Date)
            then <ns2:DISBURSEMENT_DATE>{fn:replace(fn:data($calculaAmortizacion/ns1:DisbursementInfo/ns1:Date),'-','')}</ns2:DISBURSEMENT_DATE>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:DisbursementInfo/ns1:Rate)
            then <ns2:DISBURSEMENT_RATE>{fn:data($calculaAmortizacion/ns1:DisbursementInfo/ns1:Rate)}</ns2:DISBURSEMENT_RATE>
            else ()
        }
        {
            if ($calculaAmortizacion/ns1:FirstPaymentDate)
            then <ns2:FIRST_PAYMENT_DATE>{fn:replace(fn:data($calculaAmortizacion/ns1:FirstPaymentDate),'-','')}</ns2:FIRST_PAYMENT_DATE>
            else ()
        }
    </ns2:InputParameters>
};

xq:Tx_CalculaAmortizacion_To_DB($calculaAmortizacion)