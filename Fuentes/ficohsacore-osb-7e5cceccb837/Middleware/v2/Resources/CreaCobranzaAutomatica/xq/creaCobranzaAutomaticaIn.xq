(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/creaCobranzaAutomatica/xsd/creaCobranzaAutomatica_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/creaCobranzaAutomatica";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCobranzaAutomatica/xq/creaCobranzaAutomaticaIn/";

declare function xf:creaCobranzaAutomaticaIn($customerId as xs:string,
    $accountNumber as xs:string,
    $collectionContract as xs:string,
    $currency as xs:string,
    $accountStatus as xs:string,
    $accountName as xs:string,
    $userId as xs:string,
    $branchCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CUSTOMER_ID>{ $customerId }</ns0:PV_CUSTOMER_ID>
            <ns0:PV_ACCOUNT_NUMBER>{ $accountNumber }</ns0:PV_ACCOUNT_NUMBER>
            <ns0:PV_COLLECTION_CONTRACT>{ $collectionContract }</ns0:PV_COLLECTION_CONTRACT>
            <ns0:PV_CURRENCY>{ $currency }</ns0:PV_CURRENCY>
            <ns0:PV_ACCOUNT_NAME>{ $accountName }</ns0:PV_ACCOUNT_NAME>
            <ns0:PV_ACCOUNT_STATUS>{ $accountStatus }</ns0:PV_ACCOUNT_STATUS>
            <ns0:PV_USER_ID>{ $userId }</ns0:PV_USER_ID>
            <ns0:PV_BRANCH_CODE>{ $branchCode }</ns0:PV_BRANCH_CODE>
        </ns0:InputParameters>
};

declare variable $customerId as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $collectionContract as xs:string external;
declare variable $currency as xs:string external;
declare variable $accountStatus as xs:string external;
declare variable $accountName as xs:string external;
declare variable $userId as xs:string external;
declare variable $branchCode as xs:string external;

xf:creaCobranzaAutomaticaIn($customerId,
    $accountNumber,
    $collectionContract,
    $currency,
    $accountStatus,
    $accountName,
    $userId,
    $branchCode)
