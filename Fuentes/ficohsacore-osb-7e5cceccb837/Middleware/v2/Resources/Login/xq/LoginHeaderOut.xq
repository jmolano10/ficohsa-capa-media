(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/LoginHeaderOut/";

declare function xf:LoginHeaderOut($SuccessIndicator as xs:string,
    $Message as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ data($SuccessIndicator) }</successIndicator>
            <messages>{ data($Message) }</messages>
        </ns0:ResponseHeader>
};

declare variable $SuccessIndicator as xs:string external;
declare variable $Message as xs:string external;

xf:LoginHeaderOut($SuccessIndicator,
    $Message)
