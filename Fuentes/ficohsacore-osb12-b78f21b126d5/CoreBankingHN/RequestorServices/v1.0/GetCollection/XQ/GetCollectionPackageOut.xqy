xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetMobilePackeages/GetMobilePackeages.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;

declare variable $GetMobilePackeagesResponse as element() (:: schema-element(ns2:ConsultaPaquetesMovilesResponse) ::) external;
declare variable $contractName as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::), 
                            $GetMobilePackeagesResponse as element() (:: schema-element(ns2:ConsultaPaquetesMovilesResponse) ::), 
                            $contractName as xs:string, 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns1:getCollectionResponse) ::) {
    <ns1:getCollectionResponse>
        <ns1:StatusInfo>
            {
                if ($GetMobilePackeagesResponse/Status/successIndicator)
                then <com:Status>{fn:data($GetMobilePackeagesResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($GetMobilePackeagesResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($GetMobilePackeagesResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns1:StatusInfo>
        <ns1:ContractId>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns1:ContractId>
        <ns1:ContractName>{fn:data($contractName)}</ns1:ContractName>
        <ns1:DebtorCode>{fn:data($GetCollectionRequest/ns1:DebtorCode)}</ns1:DebtorCode>
        <ns1:Bills>
            {
                for $mWSFICOPARAMPACKAGEDetailType in $GetMobilePackeagesResponse/WSFICOPARAMPACKAGEType[1]/gWSFICOPARAMPACKAGEDetailType/mWSFICOPARAMPACKAGEDetailType
                where $mWSFICOPARAMPACKAGEDetailType/PACKOPERCODE = fn:data($GetCollectionRequest/ns1:AdditionalInfo/ns1:Data[1])
                return 
                <ns1:BillRecord>
                    {
                        if ($mWSFICOPARAMPACKAGEDetailType/PACKOPERCODE)
                        then <ns1:BillNumber>{fn:data($mWSFICOPARAMPACKAGEDetailType/PACKOPERCODE)}</ns1:BillNumber>
                        else ()
                    }
                    <ns1:BillCurrency>HNL</ns1:BillCurrency>
                    <ns1:BillDate>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns1:BillDate>
                    <ns1:DueDate>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns1:DueDate>
                    {
                        if ($mWSFICOPARAMPACKAGEDetailType/PACKPRICE)
                        then <ns1:BillAmount>{fn:data($mWSFICOPARAMPACKAGEDetailType/PACKPRICE)}</ns1:BillAmount>
                        else ()
                    }
                    {
                        if ($mWSFICOPARAMPACKAGEDetailType/PACKPRICE)
                        then <ns1:TotalAmountLOC>{fn:data($mWSFICOPARAMPACKAGEDetailType/PACKPRICE)}</ns1:TotalAmountLOC>
                        else ()
                    }
                    {
                        if ($mWSFICOPARAMPACKAGEDetailType/PACKNAME)
                        then <ns1:BillDescription>{fn:data($mWSFICOPARAMPACKAGEDetailType/PACKNAME)}</ns1:BillDescription>
                        else ()
                    }
                </ns1:BillRecord>
            }
        </ns1:Bills>
    </ns1:getCollectionResponse>
};

local:func($GetCollectionRequest, $GetMobilePackeagesResponse, $contractName, $uuid)