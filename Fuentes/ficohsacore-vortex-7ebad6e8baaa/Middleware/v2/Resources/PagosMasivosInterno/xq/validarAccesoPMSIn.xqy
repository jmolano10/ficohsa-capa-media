xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagosMasivos" element="ns1:pagosMasivos" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/validaAccesoPMS/xsd/validaAccesoPMS_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoPMS";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/validarAccesoPMSIn/";

declare function xf:validarAccesoPMSIn($pagosMasivos as element(ns1:pagosMasivos),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ data($pagosMasivos/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:USER_NAME>{ data($requestHeader/Authentication/UserName) }</ns0:USER_NAME>
        </ns0:InputParameters>
};

declare variable $pagosMasivos as element(ns1:pagosMasivos) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:validarAccesoPMSIn($pagosMasivos,
    $requestHeader)