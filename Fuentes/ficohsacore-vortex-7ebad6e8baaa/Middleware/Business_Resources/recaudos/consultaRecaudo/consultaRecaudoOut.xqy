xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadedetallederecaudoResponse" element="ns0:ConsultadedetallederecaudoResponse" location="../Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="consultaRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoOut/";

declare function xf:consultaRecaudoOut($consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse))
    as element(ns1:consultaRecaudoResponse) {
        <ns1:consultaRecaudoResponse>
            {
                for $SERVICEID in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
                return
                    <CONTRACT_ID>{ data($SERVICEID) }</CONTRACT_ID>
            }
            {
                for $SERVICENAME in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICENAME
                return
                    <CONTRACT_NAME>{ data($SERVICENAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTORCODE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORCODE
                return
                    <DEBTOR_CODE>{ data($DEBTORCODE) }</DEBTOR_CODE>
            }
            {
                for $DEBTORNAME in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORNAME
                return
                    <DEBTOR_NAME>{ data($DEBTORNAME) }</DEBTOR_NAME>
            }
            <BILL_DETAIL></BILL_DETAIL>
            {
                let $result :=
                    for $LATAMAGWSPENDINGBILLSType in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType
                    return
                        <BILLS>
                            {
                                for $mLATAMAGWSPENDINGBILLSDetailType in $LATAMAGWSPENDINGBILLSType/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType
                                return
                                    <BILL_RECORD>
                                        {
                                            for $BILLNUMBER in $mLATAMAGWSPENDINGBILLSDetailType/BILLNUMBER
                                            return
                                                <BILL_NUMBER>{ data($BILLNUMBER) }</BILL_NUMBER>
                                        }
                                        {
                                            for $CURRENCY in $mLATAMAGWSPENDINGBILLSDetailType/CURRENCY
                                            return
                                                <BILL_CURRENCY>{ data($CURRENCY) }</BILL_CURRENCY>
                                        }
                                        {
                                            for $BILLDATE in $mLATAMAGWSPENDINGBILLSDetailType/BILLDATE
                                            return
                                                <BILL_DATE>{ data($BILLDATE) }</BILL_DATE>
                                        }
                                        {
                                            for $DUEDATE in $mLATAMAGWSPENDINGBILLSDetailType/DUEDATE
                                            return
                                                <DUE_DATE>{ data($DUEDATE) }</DUE_DATE>
                                        }
                                        {
                                            for $BILLAMOUNT in $mLATAMAGWSPENDINGBILLSDetailType/BILLAMOUNT
                                            return
                                                <BILL_AMOUNT>{ data($BILLAMOUNT) }</BILL_AMOUNT>
                                        }
                                        {
                                            for $LATEFEE in $mLATAMAGWSPENDINGBILLSDetailType/LATEFEE
                                            return
                                                <LATE_FEE>{ data($LATEFEE) }</LATE_FEE>
                                        }
                                        {
                                            for $TOTALAMOUNT in $mLATAMAGWSPENDINGBILLSDetailType/TOTALAMOUNT
                                            return
                                                <TOTAL_AMOUNT>{ data($TOTALAMOUNT) }</TOTAL_AMOUNT>
                                        }
                                    </BILL_RECORD>
                            }
                        </BILLS>
                return
                    $result[1]
            }
        </ns1:consultaRecaudoResponse>
};

declare variable $consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse) external;

xf:consultaRecaudoOut($consultadedetallederecaudoResponse)