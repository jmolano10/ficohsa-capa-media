(:: pragma bea:global-element-return element="ns0:getCustomerDetails" location="../../../../v2/BusinessServices/FPC/getCustomerDetails12c/xsd/getCustomerDetailsTypes.xsd" ::)

declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/getCustomerDetailsIn/";

declare function xf:getCustomerDetailsIn($customerIdType as xs:string,
    $customerIdValue as xs:string)
    as element(ns0:getCustomerDetails) {
        <ns0:getCustomerDetails>
            <GeneralInfo>
                <SourceBank>HN02</SourceBank>
                <DestinationBank>HN02</DestinationBank>
                <GlobalId></GlobalId>
                <ApplicationId></ApplicationId>
                <ApplicationUser></ApplicationUser>
                <BranchId></BranchId>
                <TransactionDate>{fn:current-date()}</TransactionDate>
                <Language>es</Language>
            </GeneralInfo>
            <CustomerIdType>{ $customerIdType }</CustomerIdType>
            <CustomerIdValue>{ $customerIdValue }</CustomerIdValue>
        </ns0:getCustomerDetails>
};

declare variable $customerIdType as xs:string external;
declare variable $customerIdValue as xs:string external;

xf:getCustomerDetailsIn($customerIdType,
    $customerIdValue)
