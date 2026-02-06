xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:login" location="../../../BusinessServices/SALESFORCE/enterprise/wsdl/ENTERPRISE.wsdl" ::)

declare namespace ns0 = "urn:enterprise.soap.sforce.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarTarjetaCredito/xq/loginIn/";

declare function xf:loginIn($userName as xs:string,
    $password as xs:string)
    as element(ns0:login) {
        <ns0:login>
            <ns0:username>{ $userName }</ns0:username>
            <ns0:password>{ $password }</ns0:password>
        </ns0:login>
};

declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:loginIn($userName,
    $password)