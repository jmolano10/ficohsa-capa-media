xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../../../../../../CommonResources/XSD/CommonTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/loginSalesForceTypes";
(:: import schema at "../../LoginSalesforce/XSD/LoginSalesforceTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/loginSalesforceIn";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $createNewSession as xs:string external;
declare variable $generalInfo as element() (:: schema-element(ns2:GeneralInfo) ::) external;

declare function ns1:loginSalesforceIn($username as xs:string, 
                                       $password as xs:string, 
                                       $createNewSession as xs:string, 
                                       $generalInfo as element() (:: schema-element(ns2:GeneralInfo) ::)) 
                                       as element() (:: schema-element(ns3:loginSalesforceRequest) ::) {
    <ns3:loginSalesforceRequest>
        <ns3:GeneralInfo>
            {
                if ($generalInfo/ns2:SourceBank)
                then <ns2:SourceBank>{fn:data($generalInfo/ns2:SourceBank)}</ns2:SourceBank>
                else ()
            }
            {
                if ($generalInfo/ns2:DestinationBank)
                then <ns2:DestinationBank>{fn:data($generalInfo/ns2:DestinationBank)}</ns2:DestinationBank>
                else ()
            }
            {
                if ($generalInfo/ns2:GlobalId)
                then <ns2:GlobalId>{fn:data($generalInfo/ns2:GlobalId)}</ns2:GlobalId>
                else ()
            }
            {
                if ($generalInfo/ns2:ApplicationId)
                then <ns2:ApplicationId>{fn:data($generalInfo/ns2:ApplicationId)}</ns2:ApplicationId>
                else ()
            }
            {
                if ($generalInfo/ns2:ApplicationUser)
                then <ns2:ApplicationUser>{fn:data($generalInfo/ns2:ApplicationUser)}</ns2:ApplicationUser>
                else ()
            }
            {
                if ($generalInfo/ns2:BranchId)
                then <ns2:BranchId>{fn:data($generalInfo/ns2:BranchId)}</ns2:BranchId>
                else ()
            }
            {
                if ($generalInfo/ns2:TransactionDate)
                then <ns2:TransactionDate>{fn:data($generalInfo/ns2:TransactionDate)}</ns2:TransactionDate>
                else ()
            }
            {
                if ($generalInfo/ns2:Language)
                then <ns2:Language>{fn:data($generalInfo/ns2:Language)}</ns2:Language>
                else ()
            }
        </ns3:GeneralInfo>
        <ns3:SalesforceInfo>
            <ns3:ForceNewSession>{fn:data($createNewSession)}</ns3:ForceNewSession>
            <ns3:Username>{fn:data($username)}</ns3:Username>
            <ns3:Password>{fn:data($password)}</ns3:Password>
        </ns3:SalesforceInfo>
    </ns3:loginSalesforceRequest>
};

ns1:loginSalesforceIn($username, $password, $createNewSession, $generalInfo)
