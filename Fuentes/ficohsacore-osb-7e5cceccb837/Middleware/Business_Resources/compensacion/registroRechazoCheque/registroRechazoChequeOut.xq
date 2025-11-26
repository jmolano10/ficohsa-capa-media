(:: pragma bea:global-element-parameter parameter="$registroderechazodechequeResponse1" element="ns1:RegistroderechazodechequeResponse" location="../resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registroRechazoChequeCompensacionResponse" location="registroRechazoChequeCompensacionTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroRechazoChequeCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/registroRechazoCheque/registroRechazoChequeOut/";

declare function xf:registroRechazoChequeOut($registroderechazodechequeResponse1 as element(ns1:RegistroderechazodechequeResponse))
    as element(ns0:registroRechazoChequeCompensacionResponse) {
        <ns0:registroRechazoChequeCompensacionResponse>
            <ns0:registroRechazoChequeCompensacionResponseType>
                {
                    for $FICOINWARDCLEARINGType in $registroderechazodechequeResponse1/FICOINWARDCLEARINGType
                    return
                        <ns0:registroRechazoChequeCompensacionResponseRecordType>
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
                                for $CHEQUEAMOUNT in $FICOINWARDCLEARINGType/CHEQUEAMOUNT
                                return
                                    <CHEQUE_AMOUNT>{ data($CHEQUEAMOUNT) }</CHEQUE_AMOUNT>
                            }
                            {
                                for $TOTALCOMMISSION in $FICOINWARDCLEARINGType/TOTALCOMMISSION
                                return
                                    <CHARGE_AMOUNT>{ data($TOTALCOMMISSION) }</CHARGE_AMOUNT>
                            }
                        </ns0:registroRechazoChequeCompensacionResponseRecordType>
                }
            </ns0:registroRechazoChequeCompensacionResponseType>
        </ns0:registroRechazoChequeCompensacionResponse>
};

declare variable $registroderechazodechequeResponse1 as element(ns1:RegistroderechazodechequeResponse) external;

xf:registroRechazoChequeOut($registroderechazodechequeResponse1)