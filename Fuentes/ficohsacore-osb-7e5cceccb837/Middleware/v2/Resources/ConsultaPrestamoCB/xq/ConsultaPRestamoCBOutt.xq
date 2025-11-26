(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamoResponse1" element="ns0:consultaGeneralPrestamoResponse" location="../../../BusinessServices/OSB/ConsultaGeneralPrestamo_v2/xsd/XMLSchema_754391297.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaGeneralPrestamoResponse" location="../xsd/XMLSchema_754139365.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPrestamoCB/xq/ConsultaPRestamoCBOutt/";

declare function xf:ConsultaPRestamoCBOutt($consultaGeneralPrestamoResponse1 as element(ns0:consultaGeneralPrestamoResponse),
    $loan_number as xs:string)
    as element(ns0:consultaGeneralPrestamoResponse) {
        <ns0:consultaGeneralPrestamoResponse>
            <ns0:consultaGeneralPrestamoResponseType>
                <ns0:consultaGeneralPrestamoResponseRecordType>
                    <LOAN_NUMBER>{ $loan_number }</LOAN_NUMBER>
                    {
                        for $LOAN_CUSTOMER_NAME in $consultaGeneralPrestamoResponse1/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/LOAN_CUSTOMER_NAME
                        return
                            <LOAN_CUSTOMER_NAME>{ data($LOAN_CUSTOMER_NAME) }</LOAN_CUSTOMER_NAME>
                    }
                    {
                        for $NEXT_PAYMNT_ID in $consultaGeneralPrestamoResponse1/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_ID
                        return
                            <NEXT_PAYMNT_ID>{ data($NEXT_PAYMNT_ID) }</NEXT_PAYMNT_ID>
                    }
                    {
                        for $NEXT_PAYMNT_MATURITY_DATE in $consultaGeneralPrestamoResponse1/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_MATURITY_DATE
                        return
                            <NEXT_PAYMNT_MATURITY_DATE>{ data($NEXT_PAYMNT_MATURITY_DATE) }</NEXT_PAYMNT_MATURITY_DATE>
                    }
                    {
                        for $NEXT_PAYMNT_TOTAL_AMT in $consultaGeneralPrestamoResponse1/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_TOTAL_AMT
                        return
                            <NEXT_PAYMNT_TOTAL_AMT>{ data($NEXT_PAYMNT_TOTAL_AMT) }</NEXT_PAYMNT_TOTAL_AMT>
                    }
                    {
                        for $CURRENCY in $consultaGeneralPrestamoResponse1/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/CURRENCY
                        return
                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    }
                </ns0:consultaGeneralPrestamoResponseRecordType>
            </ns0:consultaGeneralPrestamoResponseType>
        </ns0:consultaGeneralPrestamoResponse>
};

declare variable $consultaGeneralPrestamoResponse1 as element(ns0:consultaGeneralPrestamoResponse) external;
declare variable $loan_number as xs:string external;

xf:ConsultaPRestamoCBOutt($consultaGeneralPrestamoResponse1,
    $loan_number)