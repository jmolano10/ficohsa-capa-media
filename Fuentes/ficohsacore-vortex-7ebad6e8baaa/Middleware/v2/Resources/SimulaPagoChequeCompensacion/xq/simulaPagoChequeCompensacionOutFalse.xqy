xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$simulapagodechqporcompensacionResponse" element="ns0:Simulapagodechqporcompensacion_ValidateResponse" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:simulaPagoChequeCompensacionResponse" location="../xsd/simulaPagoChequeCompensacionTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/simulaPagoChequeCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SimulaPagoChequeCompensacion/xq/simulaPagoChequeCompensacionOutFalse/";

declare function xf:simulaPagoChequeCompensacionOutFalse($simulapagodechqporcompensacionResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse))
    as element(ns1:simulaPagoChequeCompensacionResponse) {
    	<ns1:simulaPagoChequeCompensacionResponse>
    	{
    	for $FICOINWARDCLEARINGType in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType
    	return(
    		<ns1:simulaPagoChequeCompensacionResponseType>
                <ns1:simulaPagoChequeCompensacionResponseRecordType>
                    {
                        for $REJECTIONTYPE in $FICOINWARDCLEARINGType/REJECTIONTYPE
                        return
                            <REJECTION_TYPE>{ data($REJECTIONTYPE) }</REJECTION_TYPE>
                    }
                    {
                        for $REJECTIONCODE in $FICOINWARDCLEARINGType/REJECTIONCODE
                        return
                            <REJECTION_CODE>{ data($REJECTIONCODE) }</REJECTION_CODE>
                    }
                    {
                        for $REJECTIONREASON in $FICOINWARDCLEARINGType/REJECTIONREASON
                        return
                            <REJECTION_MOTIVE>{ data($REJECTIONREASON) }</REJECTION_MOTIVE>
                    }
                    {
                        for $CLGACCOUNTNUMBER in $FICOINWARDCLEARINGType/CLGACCOUNTNUMBER
                        return
                            <ACCOUNT_NUMBER>{ data($CLGACCOUNTNUMBER) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $CHEQUENUMBER in $FICOINWARDCLEARINGType/CHEQUENUMBER
                        return
                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                    }
                    {
                        for $CHEQUETYPE in $FICOINWARDCLEARINGType/CHEQUETYPE
                        return
                            <CHEQUE_TYPE>{ data($CHEQUETYPE) }</CHEQUE_TYPE>
                    }
                    {
                        let $result :=
                            for $DATETIME in $FICOINWARDCLEARINGType/gDATETIME/DATETIME
                            return
                                <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
                        return
                            $result[1]
                    }
                </ns1:simulaPagoChequeCompensacionResponseRecordType>
            </ns1:simulaPagoChequeCompensacionResponseType>
    	)
    	}
        </ns1:simulaPagoChequeCompensacionResponse>
};

declare variable $simulapagodechqporcompensacionResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse) external;

xf:simulaPagoChequeCompensacionOutFalse($simulapagodechqporcompensacionResponse)