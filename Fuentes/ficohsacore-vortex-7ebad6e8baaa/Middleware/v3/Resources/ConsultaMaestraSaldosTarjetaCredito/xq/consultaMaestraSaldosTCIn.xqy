xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CLIENTDATA/consultaMaestraSaldosTC/xsd/consultaMaestraSaldosTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldosTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/consultaMaestraSaldosTC/";

declare function xf:consultaMaestraSaldosTCIn($requestHeader as element(ns1:RequestHeader),
    $cardNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_CARD_NUMBER>{ $cardNumber }</ns0:PV_CARD_NUMBER>
        </ns0:InputParameters>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $cardNumber as xs:string external;

xf:consultaMaestraSaldosTCIn($requestHeader,
    $cardNumber)