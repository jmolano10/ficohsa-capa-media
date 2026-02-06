xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaCuentaTC/xsd/consultaCuentaTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuentaTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaTC/xq/consultaCuentaTCIn/";

declare function xf:consultaCuentaTCIn($accountNumber as xs:string,
    $requestHeader as element(ns1:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_NUMERO_CUENTA>{ $accountNumber }</ns0:PV_NUMERO_CUENTA>
        </ns0:InputParameters>
};

declare variable $accountNumber as xs:string external;
declare variable $requestHeader as element(ns1:RequestHeader) external;

xf:consultaCuentaTCIn($accountNumber,
    $requestHeader)