xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../../../../../../CommonResources/XSD/CommonTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamo";
(:: import schema at "../../../../../../MWBanking/Loans/RequestorServices/XSD/getLoanDetails.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace dyn = "http://www.ficohsa.com.hn/middleware.services/dynamoTypes";

declare variable $errorInfo as element() (:: schema-element(ns2:ErrorInfo) ::) external;

declare function xq:Tx_ErrorInfo_ToGetLoanDetailsResponse($errorInfo as element() (:: schema-element(ns2:ErrorInfo) ::)) as element() (:: schema-element(ns1:getLoanDetailsResponse) ::) {
    <ns1:getLoanDetailsResponse>
        <ns1:ErrorInfo>
            {
                if ($errorInfo/ns2:Code)
                then <dyn:Code>{fn:data($errorInfo/ns2:Code)}</dyn:Code>
                else ()
            }
            {
                if ($errorInfo/ns2:Error)
                then <dyn:Error>{fn:data($errorInfo/ns2:Error)}</dyn:Error>
                else ()
            }
            {
                if ($errorInfo/ns2:Description)
                then <dyn:Description>{fn:data($errorInfo/ns2:Description)}</dyn:Description>
                else ()
            }
            {
                if ($errorInfo/ns2:ShortDescription)
                then <dyn:ShortDescription>{fn:data($errorInfo/ns2:ShortDescription)}</dyn:ShortDescription>
                else ()
            }
            {
                if ($errorInfo/ns2:DateTime)
                then <dyn:DateTime>{fn:data($errorInfo/ns2:DateTime)}</dyn:DateTime>
                else ()
            }
            {
                if ($errorInfo/ns2:GlobalId)
                then <dyn:GlobalId>{fn:data($errorInfo/ns2:GlobalId)}</dyn:GlobalId>
                else ()
            }
            {
                for $Details in $errorInfo/ns2:Details
                return 
                <dyn:Details>
                    {
                        if ($Details/ns2:SystemId)
                        then <dyn:SystemId>{fn:data($Details/ns2:SystemId)}</dyn:SystemId>
                        else ()
                    }
                    {
                        if ($Details/ns2:SystemStatus)
                        then <dyn:SystemStatus>{fn:data($Details/ns2:SystemStatus)}</dyn:SystemStatus>
                        else ()
                    }
                    {
                        if ($Details/ns2:MessageId)
                        then <dyn:MessageId>{fn:data($Details/ns2:MessageId)}</dyn:MessageId>
                        else ()
                    }
                    {
                        if ($Details/ns2:Messages)
                        then <dyn:Messages>{fn:data($Details/ns2:Messages)}</dyn:Messages>
                        else ()
                    }</dyn:Details>
            }</ns1:ErrorInfo>
    </ns1:getLoanDetailsResponse>
};

xq:Tx_ErrorInfo_ToGetLoanDetailsResponse($errorInfo)