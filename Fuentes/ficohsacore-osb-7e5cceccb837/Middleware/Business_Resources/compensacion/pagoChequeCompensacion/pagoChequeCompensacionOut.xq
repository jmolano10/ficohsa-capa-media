(:: pragma bea:global-element-parameter parameter="$pagodechqporcompensacionResponse1" element="ns0:PagodechqporcompensacionResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoChequeCompensacionResponse" location="pagoChequeCompensacionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoChequeCompensacionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/pagoChequeCompensacion/pagoChequeCompensacionOut/";

declare function xf:pagoChequeCompensacionOut($pagodechqporcompensacionResponse1 as element(ns0:PagodechqporcompensacionResponse))
    as element(ns1:pagoChequeCompensacionResponse) {
        <ns1:pagoChequeCompensacionResponse>
            <ns1:pagoChequeCompensacionResponseType>
                <ns1:pagoChequeCompensacionResponseRecordType>
                    {
                        for $CLGACCOUNTNUMBER in $pagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/CLGACCOUNTNUMBER
                        return
                            <ACCOUNT_NUMBER>{ data($CLGACCOUNTNUMBER) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $CHEQUENUMBER in $pagodechqporcompensacionResponse1/FICOINWARDCLEARINGType/CHEQUENUMBER
                        return
                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                    }
                </ns1:pagoChequeCompensacionResponseRecordType>
            </ns1:pagoChequeCompensacionResponseType>
        </ns1:pagoChequeCompensacionResponse>
};

declare variable $pagodechqporcompensacionResponse1 as element(ns0:PagodechqporcompensacionResponse) external;

xf:pagoChequeCompensacionOut($pagodechqporcompensacionResponse1)