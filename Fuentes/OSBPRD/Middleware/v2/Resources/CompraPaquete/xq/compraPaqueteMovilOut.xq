(:: pragma bea:global-element-parameter parameter="$pagoDePaquetesMovilesFTResponse" element="ns1:PagoDePaquetesMovilesFTResponse" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)
(:: pragma bea:global-element-return element="ns0:compraPaqueteResponse" location="../xsd/compraPaqueteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraPaqueteTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/compraPaqueteMovilClaroOut/";

declare function xf:compraPaqueteMovilClaroOut($pagoDePaquetesMovilesFTResponse as element(ns1:PagoDePaquetesMovilesFTResponse))
    as element(ns0:compraPaqueteResponse) {
        <ns0:compraPaqueteResponse>
            {
                let $result :=
                    for $INPUTTER in $pagoDePaquetesMovilesFTResponse/FUNDSTRANSFERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ data($INPUTTER) }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $pagoDePaquetesMovilesFTResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ fn:concat(year-from-date(xs:date( fn:current-date())), fn:substring($DATETIME, 3)) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                for $LROTHEROFFCER in $pagoDePaquetesMovilesFTResponse/FUNDSTRANSFERType/LROTHEROFFCER
                return
                    <BRANCH_NAME>{ data($LROTHEROFFCER) }</BRANCH_NAME>
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>ACCT_DEBIT</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoDePaquetesMovilesFTResponse/FUNDSTRANSFERType/DEBITCURRENCY) }</PAYMENT_CURRENCY>
                {
                    for $DEBITAMOUNT in $pagoDePaquetesMovilesFTResponse/FUNDSTRANSFERType/DEBITAMOUNT
                    return
                        <PAYMENT_AMOUNT>{ data($DEBITAMOUNT) }</PAYMENT_AMOUNT>
                }
                {
                    for $DEBITACCTNO in $pagoDePaquetesMovilesFTResponse/FUNDSTRANSFERType/DEBITACCTNO
                    return
                        <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
                }
            </PAYMENT_INFORMATION>
        </ns0:compraPaqueteResponse>
};

declare variable $pagoDePaquetesMovilesFTResponse as element(ns1:PagoDePaquetesMovilesFTResponse) external;

xf:compraPaqueteMovilClaroOut($pagoDePaquetesMovilesFTResponse)