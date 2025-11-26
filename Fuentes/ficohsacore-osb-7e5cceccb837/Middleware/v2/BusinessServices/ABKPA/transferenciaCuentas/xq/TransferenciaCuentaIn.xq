(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/transferenciaCuentas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaCuentas";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ABKPA/transferenciaCuentas/xq/TransfereneciaCuentaIn/";

declare function xf:TransfereneciaCuentaIn($DebitAccount as xs:string,
    $CreditAccount as xs:string,
    $Currency as xs:string,
    $TransferAmount as xs:string,
    $DebitOrCredit as xs:string,
    $Description as xs:string,
    $TransferDetails as xs:string,
    $InterfaceRefNum as xs:string,
    $Category as xs:string,
    $SubCategory as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:DEBIT_ACCOUNT>{ $DebitAccount }</ns0:DEBIT_ACCOUNT>
            <ns0:CREDIT_ACCOUNT>{ $CreditAccount }</ns0:CREDIT_ACCOUNT>
            <ns0:CURRENCY>{ $Currency }</ns0:CURRENCY>
            <ns0:TRANSFER_AMOUNT>{ $TransferAmount }</ns0:TRANSFER_AMOUNT>
            <ns0:DEBIT_CREDIT>{ $DebitOrCredit }</ns0:DEBIT_CREDIT>
            <ns0:DESCRIPTION>{ $Description }</ns0:DESCRIPTION>
            <ns0:TRANSFER_DETAILS>{ $TransferDetails }</ns0:TRANSFER_DETAILS>
            <ns0:INTERFACE_REFERENCE_NO>{ $InterfaceRefNum }</ns0:INTERFACE_REFERENCE_NO>
            <ns0:FINANCIAL_SECTOR_CATEGORY>{ $Category }</ns0:FINANCIAL_SECTOR_CATEGORY>
            <ns0:FINANCIAL_SECTOR_SUBCATEGORY>{ $SubCategory }</ns0:FINANCIAL_SECTOR_SUBCATEGORY>
        </ns0:InputParameters>
};

declare variable $DebitAccount as xs:string external;
declare variable $CreditAccount as xs:string external;
declare variable $Currency as xs:string external;
declare variable $TransferAmount as xs:string external;
declare variable $DebitOrCredit as xs:string external;
declare variable $Description as xs:string external;
declare variable $TransferDetails as xs:string external;
declare variable $InterfaceRefNum as xs:string external;
declare variable $Category as xs:string external;
declare variable $SubCategory as xs:string external;

xf:TransfereneciaCuentaIn($DebitAccount,
    $CreditAccount,
    $Currency,
    $TransferAmount,
    $DebitOrCredit,
    $Description,
    $TransferDetails,
    $InterfaceRefNum,
    $Category,
    $SubCategory)
