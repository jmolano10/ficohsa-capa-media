(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentaTCRequest" element="ns1:consultaCuentaTCRequest" location="../xsd/consultaCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaCuentaTC/xsd/consultaCuentaTC_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaTCTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuentaTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaTC/xq/consultarCuentaTCIn/";

declare function xf:consultarCuentaTCIn($requestHeader as element(ns2:RequestHeader),
    $consultaCuentaTCRequest as element(ns1:consultaCuentaTCRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_NUMERO_CUENTA>{ data($consultaCuentaTCRequest/ACCOUNT_NUMBER) }</ns0:PV_NUMERO_CUENTA>
            <ns0:PV_ORG>{ data($consultaCuentaTCRequest/ORG) }</ns0:PV_ORG>
        </ns0:InputParameters>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaCuentaTCRequest as element(ns1:consultaCuentaTCRequest) external;

xf:consultarCuentaTCIn($requestHeader,
    $consultaCuentaTCRequest)