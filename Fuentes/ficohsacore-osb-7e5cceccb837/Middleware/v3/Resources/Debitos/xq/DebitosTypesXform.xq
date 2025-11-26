(:: pragma bea:local-element-complex-parameter parameter="$RegionalDetails" type="RegionalDetails/SOURCE" location="../../ArtefactosGenerales/xsd/KeyValuePair.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Debitos" location="../xsd/DebitosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/DebitosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/DebitosTypesXform/";

declare function xf:DebitosTypesXform($UserName as xs:string,
    $Password as xs:string,
    $SourceAccount as xs:string,
    $SourceAccountCurrency as xs:string,
    $Amount as xs:string,
    $DestinationAccount as xs:string,
    $PaidProductId as xs:string,
    $InterfaceReferenceNumber as xs:string,
    $RegionalDetails as element())
    as element(ns0:Debitos) {
        <ns0:Debitos>
            <USER_NAME>{ $UserName }</USER_NAME>
            <PASSWORD>{ $Password }</PASSWORD>
            <SOURCE_ACCOUNT>{ $SourceAccount }</SOURCE_ACCOUNT>
            <SOURCE_ACCOUNT_CURRENCY>{ $SourceAccountCurrency }</SOURCE_ACCOUNT_CURRENCY>
            <AMOUNT>{ $Amount }</AMOUNT>
            <DESTINATION_ACCOUNT>{ $DestinationAccount }</DESTINATION_ACCOUNT>
            <PAID_PRODUCT_ID>{ $PaidProductId }</PAID_PRODUCT_ID>
            <INTERFACE_REFERENCE_NUMBER>{ $InterfaceReferenceNumber }</INTERFACE_REFERENCE_NUMBER>
            <REGIONAL_DETAILS>
                <SOURCE>{ $RegionalDetails/@* , $RegionalDetails/node() }</SOURCE>
            </REGIONAL_DETAILS>
        </ns0:Debitos>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $SourceAccount as xs:string external;
declare variable $SourceAccountCurrency as xs:string external;
declare variable $Amount as xs:string external;
declare variable $DestinationAccount as xs:string external;
declare variable $PaidProductId as xs:string external;
declare variable $InterfaceReferenceNumber as xs:string external;
declare variable $RegionalDetails as element() external;

xf:DebitosTypesXform($UserName,
    $Password,
    $SourceAccount,
    $SourceAccountCurrency,
    $Amount,
    $DestinationAccount,
    $PaidProductId,
    $InterfaceReferenceNumber,
    $RegionalDetails)
