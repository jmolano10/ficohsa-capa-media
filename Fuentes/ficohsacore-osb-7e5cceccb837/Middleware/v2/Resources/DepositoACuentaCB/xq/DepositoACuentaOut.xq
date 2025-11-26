(:: pragma bea:global-element-parameter parameter="$transfmodelbankentrecuentasResponse1" element="ns0:TransfmodelbankentrecuentasResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:depositoACuentaResponse" location="../xsd/depositoACuentaCBTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/DepositoACuentaOut/";

declare function xf:DepositoACuentaOut($transfmodelbankentrecuentasResponse1 as element(ns0:TransfmodelbankentrecuentasResponse),
    $DepositType as xs:string)
    as element(ns1:depositoACuentaResponse) {
        <ns1:depositoACuentaResponse>
            {
                for $CREDITACCTNO in $transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <ACCOUNT_NUMBER>{ data($CREDITACCTNO) }</ACCOUNT_NUMBER>
            }
            {
                for $DEBITCURRENCY in $transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <CURRENCY>{ data($DEBITCURRENCY) }</CURRENCY>
            }
            <DEPOSIT_ITEMS>
                <DEPOSIT_ITEM>
                    <DEPOSIT_TYPE>{ $DepositType }</DEPOSIT_TYPE>
                    <AMOUNT>{ data($transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/DEBITAMOUNT) }</AMOUNT>
                    {
                        let $result :=
                            for $BENBANK in $transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/gBENBANK/BENBANK
                            return
                                <BANK_CODE>{ data($BENBANK) }</BANK_CODE>
                        return
                            $result[1]
                    }
                </DEPOSIT_ITEM>
            </DEPOSIT_ITEMS>
            {
                let $result :=
                    for $PAYMENTDETAILS in $transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/gPAYMENTDETAILS/PAYMENTDETAILS
                    return
                         data($PAYMENTDETAILS) 
                return
                    <DESCRIPTION>{ fn:string-join($result,",") }</DESCRIPTION>
            }
            {
                for $CREDITVALUEDATE in $transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/CREDITVALUEDATE
                return
                    <DATE_TIME>{ data($CREDITVALUEDATE) }</DATE_TIME>
            }
        </ns1:depositoACuentaResponse>
};

declare variable $transfmodelbankentrecuentasResponse1 as element(ns0:TransfmodelbankentrecuentasResponse) external;
declare variable $DepositType as xs:string external;

xf:DepositoACuentaOut($transfmodelbankentrecuentasResponse1,
    $DepositType)