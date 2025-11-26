(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/responseHeader/";

declare function xf:responseHeader($successIndicator as xs:string,
    $message as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $successIndicator }</successIndicator>
            { if ($message != "") then
            <messages>{ $message }</messages>
            else ()
            }
        </ns0:ResponseHeader>
};

declare variable $successIndicator as xs:string external;
declare variable $message as xs:string external;

xf:responseHeader($successIndicator,
    $message)