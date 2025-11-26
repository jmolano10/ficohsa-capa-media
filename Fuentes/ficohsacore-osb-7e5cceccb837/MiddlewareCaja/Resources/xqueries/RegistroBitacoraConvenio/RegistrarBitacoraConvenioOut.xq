(:: pragma  parameter="$response" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:registroBitacoraConvenioResponse" location="../../xsds/RegistroBitacoraConvenio/RegistroBitacoraConvenio.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistroBitacoraConvenio/RegistrarBitacoraConvenioOut/";

declare function xf:RegistrarBitacoraConvenioOut($response as element(*))
    as element(ns0:registroBitacoraConvenioResponse) {
        <ns0:registroBitacoraConvenioResponse>
            <ERROR_CODE>{ fn:string($response//P_CODIGO_ERROR/text()) }</ERROR_CODE>
            <ERROR_MESSAGE>{ fn:string($response//P_MENSAJE_ERROR/text()) }</ERROR_MESSAGE>
        </ns0:registroBitacoraConvenioResponse>
};

declare variable $response as element(*) external;

xf:RegistrarBitacoraConvenioOut($response)