xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroATMConCupon1" element="ns1:retiroATMConCupon" location="../xsd/retiroATMConCuponTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:aplicaRetiroATMT24" location="../../../BusinessServices/AplicaRetiroATMT24/xsd/XMLSchema_478686049.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aplicaRetiroATMT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroATMConCuponTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConCupon/xq/AplicaRetiroATMT24In/";

declare function xf:AplicaRetiroATMT24In($retiroATMConCupon1 as element(ns1:retiroATMConCupon),
    $accountNumber as xs:string,
    $atmDate as xs:string,
    $tengoRef as xs:string,
    $osbRef as xs:string,
    $trxCode as xs:string)
    as element(ns0:aplicaRetiroATMT24) {
        <ns0:aplicaRetiroATMT24>
            <TRANSACTION_CODE>{ $trxCode }</TRANSACTION_CODE>
            <DEBIT_ACCOUNT>{ $accountNumber }</DEBIT_ACCOUNT>
            <ATM_DATE>{ $atmDate }</ATM_DATE>
            {
                for $TERMINAL_ID in $retiroATMConCupon1/TERMINAL_ID
                return
                    <ATM_ID>{ data($TERMINAL_ID) }</ATM_ID>
            }
            {
                for $COUPON_ID in $retiroATMConCupon1/COUPON_ID
                return
                    <PAY_CODE>{ data($COUPON_ID) }</PAY_CODE>
            }
            {
                for $CURRENCY in $retiroATMConCupon1/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            <AMOUNT>{ data($retiroATMConCupon1/AMOUNT) }</AMOUNT>
            {
                for $TERMINAL_REFERENCE in $retiroATMConCupon1/TERMINAL_REFERENCE
                return
                    <ATM_REFERENCE>{ data($TERMINAL_REFERENCE) }</ATM_REFERENCE>
            }
            <TENGO_REFERENCE>{ $tengoRef }</TENGO_REFERENCE>
            <OSB_REFERENCE>{ $osbRef }</OSB_REFERENCE>
            <WITHDRAWAL_TYPE>CUPON</WITHDRAWAL_TYPE>
        </ns0:aplicaRetiroATMT24>
};

declare variable $retiroATMConCupon1 as element(ns1:retiroATMConCupon) external;
declare variable $accountNumber as xs:string external;
declare variable $atmDate as xs:string external;
declare variable $tengoRef as xs:string external;
declare variable $osbRef as xs:string external;
declare variable $trxCode as xs:string external;

xf:AplicaRetiroATMT24In($retiroATMConCupon1,
    $accountNumber,
    $atmDate,
    $tengoRef,
    $osbRef,
    $trxCode)