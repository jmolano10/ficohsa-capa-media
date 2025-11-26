(:: pragma bea:local-element-parameter parameter="$tRANSACTION_DETAIL1" type="ns0:transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasRequest" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/creditoCuentaIn/";

declare function xf:creditoCuentaIn($tRANSACTION_DETAIL1 as element(),
    $debitAccount as xs:string)
    as element(ns1:transferenciaCuentasRequest) {
        <ns1:transferenciaCuentasRequest>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ data($tRANSACTION_DETAIL1/DESTINATION) }</CREDIT_ACCOUNT>
            <CURRENCY>{ data($tRANSACTION_DETAIL1/CURRENCY) }</CURRENCY>
            <TRANSFER_AMOUNT>{ data($tRANSACTION_DETAIL1/AMOUNT) }</TRANSFER_AMOUNT>
            {
                for $ACCOUNT in $tRANSACTION_DETAIL1/ORIGINATOR_INFO/ACCOUNT,
                    $REFERENCE_NUMBER in $tRANSACTION_DETAIL1/ORIGINATOR_INFO/REFERENCE_NUMBER
                return
                    <DESCRIPTION>{ concat($tRANSACTION_DETAIL1/ORIGINATOR_INFO/BANK_ID ,"." ,$ACCOUNT , "." ,$REFERENCE_NUMBER) }</DESCRIPTION>
            }
        </ns1:transferenciaCuentasRequest>
};

declare variable $tRANSACTION_DETAIL1 as element() external;
declare variable $debitAccount as xs:string external;

xf:creditoCuentaIn($tRANSACTION_DETAIL1,
    $debitAccount)