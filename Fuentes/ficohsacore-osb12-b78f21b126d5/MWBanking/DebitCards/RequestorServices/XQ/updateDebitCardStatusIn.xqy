xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../XSD/debitCardsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/updateDebitCardStatusIn";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $debitCard as xs:string external;
declare variable $updateDebitCardStatusRequest as element() (:: schema-element(ns2:updateDebitCardStatusRequest) ::) external;

declare function ns1:updateDebitCardStatusIn($debitCard as xs:string, 
                                             $updateDebitCardStatusRequest as element() (:: schema-element(ns2:updateDebitCardStatusRequest) ::)) 
                                             as element() (:: schema-element(ns2:updateDebitCardStatusRequest) ::) {
    <ns2:updateDebitCardStatusRequest>
        {
            if ($updateDebitCardStatusRequest/ns2:GeneralInfo)
            then 
                <ns2:GeneralInfo>
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:SourceBank)
                        then <com:SourceBank>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:SourceBank)}</com:SourceBank>
                        else ()
                    }
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:DestinationBank)
                        then <com:DestinationBank>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:DestinationBank)}</com:DestinationBank>
                        else ()
                    }
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:GlobalId)
                        then <com:GlobalId>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:GlobalId)}</com:GlobalId>
                        else ()
                    }
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:ApplicationId)
                        then <com:ApplicationId>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:ApplicationId)}</com:ApplicationId>
                        else ()
                    }
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:ApplicationUser)
                        then <com:ApplicationUser>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:ApplicationUser)}</com:ApplicationUser>
                        else ()
                    }
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:BranchId)
                        then <com:BranchId>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:BranchId)}</com:BranchId>
                        else ()
                    }
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:TransactionDate)
                        then <com:TransactionDate>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:TransactionDate)}</com:TransactionDate>
                        else ()
                    }
                    {
                        if ($updateDebitCardStatusRequest/ns2:GeneralInfo/com:Language)
                        then <com:Language>{fn:data($updateDebitCardStatusRequest/ns2:GeneralInfo/com:Language)}</com:Language>
                        else ()
                    }
                </ns2:GeneralInfo>
            else ()
        }
        {
            if ($debitCard)
            then <ns2:cardNumber>{fn:data($debitCard)}</ns2:cardNumber>
            else ()
        }
        {
            if ($updateDebitCardStatusRequest/ns2:InterfaceUser)
            then <ns2:InterfaceUser>{fn:data($updateDebitCardStatusRequest/ns2:InterfaceUser)}</ns2:InterfaceUser>
            else ()
        }
        {
            if ($updateDebitCardStatusRequest/ns2:CustomerId)
            then <ns2:CustomerId>{fn:data($updateDebitCardStatusRequest/ns2:CustomerId)}</ns2:CustomerId>
            else ()
        }
        {
            if ($updateDebitCardStatusRequest/ns2:CardStatus)
            then <ns2:CardStatus>{fn:data($updateDebitCardStatusRequest/ns2:CardStatus)}</ns2:CardStatus>
            else ()
        }
        {
            for $AdditionalData in $updateDebitCardStatusRequest/ns2:AdditionalData
            return 
            <ns2:AdditionalData>
                {
                    if ($AdditionalData/ns2:KeyValue)
                    then <ns2:KeyValue>{fn:data($AdditionalData/ns2:KeyValue)}</ns2:KeyValue>
                    else ()
                }
                {
                    if ($AdditionalData/ns2:Value)
                    then <ns2:Value>{fn:data($AdditionalData/ns2:Value)}</ns2:Value>
                    else ()
                }
            </ns2:AdditionalData>
        }
    </ns2:updateDebitCardStatusRequest>
};

ns1:updateDebitCardStatusIn($debitCard, $updateDebitCardStatusRequest)
