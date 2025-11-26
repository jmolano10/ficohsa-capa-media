(:: pragma bea:global-element-parameter parameter="$confirmaciondechequesResponse" element="ns1:ConfirmaciondechequesResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reservaFondosChequeResponse" location="reservaFondosChequeTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reservaFondosChequeTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/reservaFondosCheque/ReservaFondosCheque/reservaFondosChequeOut/";

declare function xf:reservaFondosChequeOut($confirmaciondechequesResponse as element(ns1:ConfirmaciondechequesResponse))
    as element(ns0:reservaFondosChequeResponse) {
        <ns0:reservaFondosChequeResponse>
            <ns0:reservaFondosChequeResponseType>
                <ns0:reservaFondosChequeResponseRecordType>
                    {
                        for $CHQACCOUNT in $confirmaciondechequesResponse/LATAMAGCHEQUECONFIRMDATAType/CHQACCOUNT
                        return
                            <DEBIT_ACCOUNT>{ data($CHQACCOUNT) }</DEBIT_ACCOUNT>
                    }
                    {
                        for $AMOUNT in $confirmaciondechequesResponse/LATAMAGCHEQUECONFIRMDATAType/AMOUNT
                        return
                            <AMOUNT_RESERVED>{ data($AMOUNT) }</AMOUNT_RESERVED>
                    }
                    {
                        for $CHEQUENO in $confirmaciondechequesResponse/LATAMAGCHEQUECONFIRMDATAType/CHEQUENO
                        return
                            <CHEQUE_NUMBER>{ data($CHEQUENO) }</CHEQUE_NUMBER>
                    }
                    {
                        let $result :=
                            for $DATETIME in $confirmaciondechequesResponse/LATAMAGCHEQUECONFIRMDATAType/gDATETIME/DATETIME
                            return
                                <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
                        return
                            $result[1]
                    }
                </ns0:reservaFondosChequeResponseRecordType>
            </ns0:reservaFondosChequeResponseType>
        </ns0:reservaFondosChequeResponse>
};

declare variable $confirmaciondechequesResponse as element(ns1:ConfirmaciondechequesResponse) external;

xf:reservaFondosChequeOut($confirmaciondechequesResponse)