xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../../../../../CommonResources/XSD/CommonTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/updateAccountTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/updateAccountTypes.xsd" ::)

declare variable $ErrorInfo as element() (:: schema-element(ns1:ErrorInfo) ::) external;

declare function local:func($ErrorInfo as element() (:: schema-element(ns1:ErrorInfo) ::)) as element() (:: schema-element(ns2:updateAccountResponse) ::) {
    <ns2:updateAccountResponse>
        <ns2:ErrorInfo>
            {
                if ($ErrorInfo/ns1:Code)
                then <ns1:Code>{fn:data($ErrorInfo/ns1:Code)}</ns1:Code>
                else ()
            }
            {
                if ($ErrorInfo/ns1:Error)
                then <ns1:Error>{fn:data($ErrorInfo/ns1:Error)}</ns1:Error>
                else ()
            }
            {
                if ($ErrorInfo/ns1:Description)
                then <ns1:Description>{fn:data($ErrorInfo/ns1:Description)}</ns1:Description>
                else ()
            }
            {
                if ($ErrorInfo/ns1:ShortDescription)
                then <ns1:ShortDescription>{fn:data($ErrorInfo/ns1:ShortDescription)}</ns1:ShortDescription>
                else ()
            }
            {
                if ($ErrorInfo/ns1:DateTime)
                then <ns1:DateTime>{fn:data($ErrorInfo/ns1:DateTime)}</ns1:DateTime>
                else ()
            }
            {
                if ($ErrorInfo/ns1:GlobalId)
                then <ns1:GlobalId>{fn:data($ErrorInfo/ns1:GlobalId)}</ns1:GlobalId>
                else ()
            }
            {
                for $Details in $ErrorInfo/ns1:Details
                return 
                <ns1:Details>
                    {
                        if ($Details/ns1:SystemId)
                        then <ns1:SystemId>{fn:data($Details/ns1:SystemId)}</ns1:SystemId>
                        else ()
                    }
                    {
                        if ($Details/ns1:SystemStatus)
                        then <ns1:SystemStatus>{fn:data($Details/ns1:SystemStatus)}</ns1:SystemStatus>
                        else ()
                    }
                    {
                        if ($Details/ns1:MessageId)
                        then <ns1:MessageId>{fn:data($Details/ns1:MessageId)}</ns1:MessageId>
                        else ()
                    }
                    {
                        if ($Details/ns1:Messages)
                        then <ns1:Messages>{fn:data($Details/ns1:Messages)}</ns1:Messages>
                        else ()
                    }
                </ns1:Details>
            }
        </ns2:ErrorInfo>
    </ns2:updateAccountResponse>
};

local:func($ErrorInfo)