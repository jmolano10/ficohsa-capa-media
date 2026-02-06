xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadesaldodeprestamoResponse1" element="ns0:ConsultadesaldodeprestamoResponse" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaGeneralPrestamoResponse" location="../xsd/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaPrestamoT24Out/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:consultaPrestamoT24Out($consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse),
    $functionalityDisplayIndicator as xs:string)
    as element(ns1:consultaGeneralPrestamoResponse) {
                if ( fn:string($consultadesaldodeprestamoResponse1/Status/successIndicator/text()) = "Success" and 
            fn:string($consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CUSTOMERNAME/text()) != "" ) then (
            <ns1:consultaGeneralPrestamoResponse>
                <ns1:consultaGeneralPrestamoResponseType>
                    <ns1:consultaGeneralPrestamoResponseRecordType>
                        {
                            for $CUSTOMERNAME in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CUSTOMERNAME
                            return
                                <LOAN_CUSTOMER_NAME>{ data($CUSTOMERNAME) }</LOAN_CUSTOMER_NAME>
                        }
                        {
                            for $OPENINGDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/OPENINGDATE
                            return
                                <EFFECTIVE_DATE>{ data($OPENINGDATE) }</EFFECTIVE_DATE>
                        }
                        {
                            if ($functionalityDisplayIndicator = ('ALL')) then (
                                for $MATURITYDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/MATURITYDATE
                                return
                                    <MATURITY_DATE>{ data($MATURITYDATE) }</MATURITY_DATE>,
                                for $INTERESTRATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INTERESTRATE
                                return
                                    <INTEREST_RATE>{ data($INTERESTRATE) }</INTEREST_RATE>,
                                for $INITPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INITPRINAMT
                                return
                                    <PRINCIPAL_INITIAL_AMT>{ data($INITPRINAMT) }</PRINCIPAL_INITIAL_AMT>,
                                for $CURPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURPRINAMT
                                return
                                    <PRINCIPAL_DUE_AMT>{ data($CURPRINAMT) }</PRINCIPAL_DUE_AMT>,
                                for $PASTDUEPRIN in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/PASTDUEPRIN
                                return
                                    <PRINCIPAL_OVERDUE_AMT>{ data($PASTDUEPRIN) }</PRINCIPAL_OVERDUE_AMT>,
                                for $INTERESTAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INTERESTAMOUNT
                                return
                                    <INTEREST_AMOUNT>{ data($INTERESTAMOUNT) }</INTEREST_AMOUNT>,
                                for $ARRINTAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/ARRINTAMOUNT
                                return
                                    <OVERDUE_INTEREST_AMOUNT>{ data($ARRINTAMOUNT) }</OVERDUE_INTEREST_AMOUNT>,
                                for $COMMAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/COMMAMOUNT
                                return
                                    <COMISION_AMOUNT>{ data($COMMAMOUNT) }</COMISION_AMOUNT>,
                                for $TOTDEBITAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/TOTDEBITAMOUNT
                                return
                                    <TOTAL_DEBT>{ data($TOTDEBITAMOUNT) }</TOTAL_DEBT>,
                                for $PAIDINSNO in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/PAIDINSNO
                                return
                                    <NEXT_PAYMNT_ID>{ data($PAIDINSNO) }</NEXT_PAYMNT_ID>,
                                for $INSTDUEDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INSTDUEDATE
                                return
                                    <NEXT_PAYMNT_MATURITY_DATE>{ data($INSTDUEDATE) }</NEXT_PAYMNT_MATURITY_DATE>,
                                for $UNPAIDINSTNO in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/UNPAIDINSTNO
                                return
                                    <OVERDUE_PAYMENTS>{ data($UNPAIDINSTNO) }</OVERDUE_PAYMENTS>,
                                for $CURINSPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSPRINAMT
                                return
                                    <NEXT_PAYMNT_PRINCIPAL_AMT>{ data($CURINSPRINAMT) }</NEXT_PAYMNT_PRINCIPAL_AMT>,
                                for $CURINSINTEREST in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSINTEREST
                                return
                                    <NEXT_PAYMNT_INTEREST_AMT>{ data($CURINSINTEREST) }</NEXT_PAYMNT_INTEREST_AMT>
                            )else
                                (
                                )
                        }
                        {
                            for $CURINSINSUR in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSINSUR
                            return
                                <NEXT_PAYMNT_INSURANCE_AMT>{ data($CURINSINSUR) }</NEXT_PAYMNT_INSURANCE_AMT>
                        }
                        {
                            if ($functionalityDisplayIndicator = ('ALL')) then (
                                for $CURINSTOTAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSTOTAMT
                                return
                                    <NEXT_PAYMNT_TOTAL_AMT>{ data($CURINSTOTAMT) }</NEXT_PAYMNT_TOTAL_AMT>
                            )else
                                (
                                )
                        }
                        {
                            for $CURRENCY in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURRENCY
                            return
                                <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        }
                        <LAST_DISBURSEMENT_DATE></LAST_DISBURSEMENT_DATE>
                        <EXPIRED_INTEREST_AMOUNT>0</EXPIRED_INTEREST_AMOUNT>
                    </ns1:consultaGeneralPrestamoResponseRecordType>
                </ns1:consultaGeneralPrestamoResponseType>
            </ns1:consultaGeneralPrestamoResponse>
        ) else (
            <ns1:consultaGeneralPrestamoResponse/>
        )
};

declare variable $consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse) external;
declare variable $functionalityDisplayIndicator as xs:string external;

xf:consultaPrestamoT24Out($consultadesaldodeprestamoResponse1,$functionalityDisplayIndicator)