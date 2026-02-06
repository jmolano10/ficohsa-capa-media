xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$simulapagodechqporcompensacionResponse" element="ns0:Simulapagodechqporcompensacion_ValidateResponse" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:simulaPagoChequeCompensacionResponse" location="../xsd/simulaPagoChequeCompensacionTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/simulaPagoChequeCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SimulaPagoChequeCompensacion/xq/simulaPagoChequeCompensacionOut/";

declare function xf:simulaPagoChequeCompensacionOut($simulapagodechqporcompensacionResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse))
    as element(ns1:simulaPagoChequeCompensacionResponse) {
        <ns1:simulaPagoChequeCompensacionResponse>
            <ns1:simulaPagoChequeCompensacionResponseType>
                <ns1:simulaPagoChequeCompensacionResponseRecordType>
                    {
                        for $CLGACCOUNTNUMBER in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/CLGACCOUNTNUMBER
                        return
                            <ACCOUNT_NUMBER>{ data($CLGACCOUNTNUMBER) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $CHEQUENUMBER in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/CHEQUENUMBER
                        return
                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                    }
                    {
                        for $CHEQUETYPE in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/CHEQUETYPE
                        return
                            <CHEQUE_TYPE>{ data($CHEQUETYPE) }</CHEQUE_TYPE>
                    }
                </ns1:simulaPagoChequeCompensacionResponseRecordType>
            </ns1:simulaPagoChequeCompensacionResponseType>
        </ns1:simulaPagoChequeCompensacionResponse>
};

declare variable $simulapagodechqporcompensacionResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse) external;

xf:simulaPagoChequeCompensacionOut($simulapagodechqporcompensacionResponse)