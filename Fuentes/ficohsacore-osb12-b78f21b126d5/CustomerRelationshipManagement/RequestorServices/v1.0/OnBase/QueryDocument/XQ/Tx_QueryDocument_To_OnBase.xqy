xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $queryDocument as element() (:: schema-element(ns1:documentQueryRequest) ::) external;

declare function xq:Tx_QueryDocument_To_OnBase($queryDocument as element() (:: schema-element(ns1:documentQueryRequest) ::)) as element() (:: schema-element(ns2:documentQueryRequestOnBase) ::) {
    <ns2:documentQueryRequestOnBase>
        {
            for $DocumentTypes in $queryDocument/ns1:DocumentQueryInfo/ns1:DocumentTypes
            return 
            <ns2:DocumentTypes>{fn:data($queryDocument/ns1:DocumentQueryInfo/ns1:DocumentTypes)}</ns2:DocumentTypes>
        }
        <ns2:CustomQueryName>{fn:data($queryDocument/ns1:DocumentQueryInfo/ns1:CustomQueryName)}</ns2:CustomQueryName>
        {
            for $Keywords_Query in $queryDocument/ns1:DocumentQueryInfo/ns1:Keywords_Query
            return 
            <ns2:Keywords_Query>
                <ns2:Name>{fn:data($Keywords_Query/ns1:Name)}</ns2:Name>
                <ns2:Condition>{fn:data($Keywords_Query/ns1:Condition)}</ns2:Condition>
                <ns2:Operator>{fn:data($Keywords_Query/ns1:Operator)}</ns2:Operator>
                <ns2:Value>{fn:data($Keywords_Query/ns1:Value)}</ns2:Value></ns2:Keywords_Query>
        }
        {
            for $KTGs_Query in $queryDocument/ns1:DocumentQueryInfo/ns1:KTGs_Query
            return 
            <ns2:KTGs_Query>
                {
                    if ($KTGs_Query/ns1:Name)
                    then <ns2:Name>{fn:data($KTGs_Query/ns1:Name)}</ns2:Name>
                    else ()
                }
                {
                    if ($KTGs_Query/ns1:Condition)
                    then <ns2:Condition>{fn:data($KTGs_Query/ns1:Condition)}</ns2:Condition>
                    else ()
                }
                {
                    if ($KTGs_Query/ns1:Operator)
                    then <ns2:Operator>{fn:data($KTGs_Query/ns1:Operator)}</ns2:Operator>
                    else ()
                }
                {
                    if ($KTGs_Query/ns1:Value)
                    then <ns2:Value>{fn:data($KTGs_Query/ns1:Value)}</ns2:Value>
                    else ()
                }</ns2:KTGs_Query>
        }
        {
            if ($queryDocument/ns1:DocumentQueryInfo/ns1:LoadKeywords)
            then <ns2:LoadKeywords>{fn:data($queryDocument/ns1:DocumentQueryInfo/ns1:LoadKeywords)}</ns2:LoadKeywords>
            else ()
        }
        {
            if ($queryDocument/ns1:DocumentQueryInfo/ns1:LoadPages)
            then <ns2:LoadPages>{fn:data($queryDocument/ns1:DocumentQueryInfo/ns1:LoadPages)}</ns2:LoadPages>
            else ()
        }
        {
            for $KeywordFilterNames in $queryDocument/ns1:DocumentQueryInfo/ns1:KeywordFilterNames
            return 
            <ns2:KeywordFilterNames>{fn:data($queryDocument/ns1:DocumentQueryInfo/ns1:KeywordFilterNames)}</ns2:KeywordFilterNames>
        }</ns2:documentQueryRequestOnBase>
};

xq:Tx_QueryDocument_To_OnBase($queryDocument)