(:: pragma bea:local-element-parameter parameter="$pagoResult1" type="ns0:PagoResponse/ns0:PagoResult" location="../../../BusinessServices/RecaudoPOSws/xsd/svcTGR1_GD.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="../xsd/pagoRecaudoTGRPOSTypes.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/svcTGR1_GD";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPOS/xq/pagoRecaudoTGRPOSOut/";

declare function xf:pagoRecaudoTGRPOSOut($pagoResult1 as element(),
    $contract_name as xs:string,
    $debtor_name as xs:string,
    $branch_name as xs:string,
    $payment_method as xs:string,
    $payment_currancy as xs:string,
    $debit_account as xs:string,
    $payment_amount as xs:string,
    $inputter as xs:string)
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            <CONTRACT_NAME>{ data($contract_name) }</CONTRACT_NAME>
            <DEBTOR_NAME>{ data($debtor_name) }</DEBTOR_NAME>
            <INPUTTER>{ data($inputter) }</INPUTTER>
            <DATE_TIME>{ fn:concat(fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()),fn-bea:dateTime-to-string-with-format("HHmm", fn:adjust-dateTime-to-timezone(current-dateTime(),()))) }</DATE_TIME>
            <BRANCH_NAME>{ data($branch_name) }</BRANCH_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($payment_method) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($payment_currancy) }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ data($payment_amount) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ data($debit_account) }</DEBIT_ACCOUNT>
            </PAYMENT_INFORMATION>
        </ns1:pagoRecaudoResponse>
};

declare variable $pagoResult1 as element() external;
declare variable $contract_name as xs:string external;
declare variable $debtor_name as xs:string external;
declare variable $branch_name as xs:string external;
declare variable $payment_method as xs:string external;
declare variable $payment_currancy as xs:string external;
declare variable $debit_account as xs:string external;
declare variable $payment_amount as xs:string external;
declare variable $inputter as xs:string external;

xf:pagoRecaudoTGRPOSOut($pagoResult1,
    $contract_name,
    $debtor_name,
    $branch_name,
    $payment_method,
    $payment_currancy,
    $debit_account,
    $payment_amount,
    $inputter)
