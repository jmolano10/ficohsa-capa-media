xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../../../../../../CommonResources/XSD/CommonTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCustomerFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getCustomerFinancing.xsd" ::)

declare variable $errorInfo as element() (:: schema-element(ns2:ErrorInfo) ::) external;

declare function local:func($errorInfo as element() (:: schema-element(ns2:ErrorInfo) ::)) as element() (:: schema-element(ns1:getCustomerFinancingResponse) ::) {
    <ns1:getCustomerFinancingResponse>
        <ns1:ErrorInfo>
            {
                if ($errorInfo/ns2:Code)
                then <ns2:Code>{fn:data($errorInfo/ns2:Code)}</ns2:Code>
                else ()
            }
            {
                if ($errorInfo/ns2:Error)
                then <ns2:Error>{fn:data($errorInfo/ns2:Error)}</ns2:Error>
                else ()
            }
            {
                if ($errorInfo/ns2:Description)
                then <ns2:Description>{fn:data($errorInfo/ns2:Description)}</ns2:Description>
                else ()
            }
            {
                if ($errorInfo/ns2:ShortDescription)
                then <ns2:ShortDescription>{fn:data($errorInfo/ns2:ShortDescription)}</ns2:ShortDescription>
                else ()
            }
            {
                if ($errorInfo/ns2:DateTime)
                then <ns2:DateTime>{fn:data($errorInfo/ns2:DateTime)}</ns2:DateTime>
                else ()
            }
            {
                if ($errorInfo/ns2:GlobalId)
                then <ns2:GlobalId>{fn:data($errorInfo/ns2:GlobalId)}</ns2:GlobalId>
                else ()
            }
            <ns2:Details>
                {
                    if ($errorInfo/ns2:Details/ns2:SystemId)
                    then <ns2:SystemId>{fn:data($errorInfo/ns2:Details/ns2:SystemId)}</ns2:SystemId>
                    else ()
                }
                {
                    if ($errorInfo/ns2:Details/ns2:SystemStatus)
                    then <ns2:SystemStatus>{fn:data($errorInfo/ns2:Details/ns2:SystemStatus)}</ns2:SystemStatus>
                    else ()
                }
                {
                    if ($errorInfo/ns2:Details/ns2:MessageId)
                    then <ns2:MessageId>{fn:data($errorInfo/ns2:Details/ns2:MessageId)}</ns2:MessageId>
                    else ()
                }
                {
                    if ($errorInfo/ns2:Details/ns2:Messages)
                    then <ns2:Messages>{fn:data($errorInfo/ns2:Details/ns2:Messages)}</ns2:Messages>
                    else ()
                }
            </ns2:Details>
        </ns1:ErrorInfo>
    </ns1:getCustomerFinancingResponse>
};

local:func($errorInfo)