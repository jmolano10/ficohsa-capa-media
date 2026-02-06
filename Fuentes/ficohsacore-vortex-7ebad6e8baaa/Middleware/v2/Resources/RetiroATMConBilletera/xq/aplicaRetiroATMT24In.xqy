xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroATMConBilletera1" element="ns0:retiroATMConBilletera" location="../xsd/retiroATMConBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:aplicaRetiroATMT24" location="../../../BusinessServices/AplicaRetiroATMT24/xsd/XMLSchema_478686049.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroATMConBilleteraTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aplicaRetiroATMT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroATMConBilletera/xq/aplicaRetiroATMT24In/";

declare function xf:aplicaRetiroATMT24In($retiroATMConBilletera1 as element(ns0:retiroATMConBilletera),
    $accountNumber as xs:string,
    $atmDate as xs:string,
    $tengoRef as xs:string,
    $osbRef as xs:string,
    $trxCode as xs:string)
    as element(ns1:aplicaRetiroATMT24) {
        <ns1:aplicaRetiroATMT24>
            <TRANSACTION_CODE>{ $trxCode }</TRANSACTION_CODE>
            <DEBIT_ACCOUNT>{ $accountNumber }</DEBIT_ACCOUNT>
            <ATM_DATE>{ $atmDate }</ATM_DATE>
            {
                for $TERMINAL_ID in $retiroATMConBilletera1/TERMINAL_ID
                return
                    <ATM_ID>{ data($TERMINAL_ID) }</ATM_ID>
            }
            {
                for $WALLET in $retiroATMConBilletera1/WALLET
                return
                    <PAY_CODE>{ data($WALLET) }</PAY_CODE>
            }
            {
                for $CURRENCY in $retiroATMConBilletera1/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $AMOUNT in $retiroATMConBilletera1/AMOUNT
                return
                    <AMOUNT>{ data($AMOUNT) }</AMOUNT>
            }
            {
                for $TERMINAL_REFERENCE in $retiroATMConBilletera1/TERMINAL_REFERENCE
                return
                    <ATM_REFERENCE>{ data($TERMINAL_REFERENCE) }</ATM_REFERENCE>
            }
            <TENGO_REFERENCE>{ $tengoRef }</TENGO_REFERENCE>
            <OSB_REFERENCE>{ $osbRef }</OSB_REFERENCE>
            <WITHDRAWAL_TYPE>BILLETERA</WITHDRAWAL_TYPE>
        </ns1:aplicaRetiroATMT24>
};

declare variable $retiroATMConBilletera1 as element(ns0:retiroATMConBilletera) external;
declare variable $accountNumber as xs:string external;
declare variable $atmDate as xs:string external;
declare variable $tengoRef as xs:string external;
declare variable $osbRef as xs:string external;
declare variable $trxCode as xs:string external;

xf:aplicaRetiroATMT24In($retiroATMConBilletera1,
    $accountNumber,
    $atmDate,
    $tengoRef,
    $osbRef,
    $trxCode)