(:: pragma bea:global-element-parameter parameter="$simulapagodechqporcompensacionResponse1" element="ns0:SimulapagodechqporcompensacionResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:simulaPagoChequeCompensacionResponse" location="simulaPagoChequeCompensacionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/simulaPagoChequeCompensacionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/simulaPagoChequeCompensacion/simulaPagoChequeCompensacionOut/";

declare function xf:simulaPagoChequeCompensacionOut($simulapagodechqporcompensacionResponse1 as element(ns0:SimulapagodechqporcompensacionResponse))
    as element(ns1:simulaPagoChequeCompensacionResponse) {
        <ns1:simulaPagoChequeCompensacionResponse>
            <ns1:simulaPagoChequeCompensacionResponseType>
                <ns1:simulaPagoChequeCompensacionResponseRecordType>
                    {
                        for $REJECTIONTYPE in $simulapagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/REJECTIONTYPE
                        return
                            <REJECTION_TYPE>{ data($REJECTIONTYPE) }</REJECTION_TYPE>
                    }
                    {
                        for $REJECTIONCODE in $simulapagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/REJECTIONCODE
                        return
                            <REJECTION_CODE>{ data($REJECTIONCODE) }</REJECTION_CODE>
                    }
                    {
                        for $REJECTIONREASON in $simulapagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/REJECTIONREASON
                        return
                            <REJECTION_MOTIVE>{ data($REJECTIONREASON) }</REJECTION_MOTIVE>
                    }
                    {
                        for $CLGACCOUNTNUMBER in $simulapagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/CLGACCOUNTNUMBER
                        return
                            <ACCOUNT_NUMBER>{ data($CLGACCOUNTNUMBER) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $CHEQUENUMBER in $simulapagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/CHEQUENUMBER
                        return
                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                    }
                </ns1:simulaPagoChequeCompensacionResponseRecordType>
            </ns1:simulaPagoChequeCompensacionResponseType>
        </ns1:simulaPagoChequeCompensacionResponse>
};

declare variable $simulapagodechqporcompensacionResponse1 as element(ns0:SimulapagodechqporcompensacionResponse) external;

xf:simulaPagoChequeCompensacionOut($simulapagodechqporcompensacionResponse1)