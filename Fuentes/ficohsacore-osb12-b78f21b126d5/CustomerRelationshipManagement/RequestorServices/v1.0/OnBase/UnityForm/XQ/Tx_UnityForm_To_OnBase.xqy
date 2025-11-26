xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $request as element() (:: schema-element(ns1:unityFormRequest) ::) external;

declare function xq:Tx_UnityForm_To_OnBase($request as element() (:: schema-element(ns1:unityFormRequest) ::)) as element() (:: schema-element(ns2:UnityFormRequest) ::) {
    <ns2:UnityFormRequest>
        <ns2:UnityFormId>{fn:data($request/ns1:UnityFormInfo/ns1:UnityForm)}</ns2:UnityFormId>
        {
            for $Keywords in $request/ns1:UnityFormInfo/ns1:Keywords
            return 
            <ns2:Keywords>
                <ns2:Name>{fn:data($Keywords/ns1:Name)}</ns2:Name>
                <ns2:Value>{fn:data($Keywords/ns1:Value)}</ns2:Value></ns2:Keywords>
        }
        {
            for $KTGs in $request/ns1:UnityFormInfo/ns1:KTGs
            return 
            <ns2:KTGs>
                <ns2:Name>{fn:data($KTGs/ns1:Name)}</ns2:Name>
                {
                    for $Keywords1 in $KTGs/ns1:Keywords
                    return 
                    <ns2:Keywords>
                        <ns2:Name>{fn:data($Keywords1/ns1:Name)}</ns2:Name>
                        <ns2:Value>{fn:data($Keywords1/ns1:Value)}</ns2:Value></ns2:Keywords>
                }</ns2:KTGs>
        }
    </ns2:UnityFormRequest>
};

xq:Tx_UnityForm_To_OnBase($request)
