xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaFirmaDigital" element="ns1:validaFirmaDigital" location="../../OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:verifyLAURequest" location="../../../BusinessServices/LAUCalculator/wsdl/lauCalculator.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/lauCalculatorTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesPagosGlobalesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaFirmaDigital/xq/verifyLAUIn/";

declare function xf:verifyLAUIn($validaFirmaDigital as element(ns1:validaFirmaDigital),
    $lauKey as xs:string)
    as element(ns0:verifyLAURequest) {
        <ns0:verifyLAURequest>
            <LAUApplicationID>{ data($validaFirmaDigital/LAU_APPLICATION_ID) }</LAUApplicationID>
            <LAUCallTime>{ data($validaFirmaDigital/LAU_CALLTIME) }</LAUCallTime>
            <LAURequestNonce>{ data($validaFirmaDigital/LAU_REQUEST_NONCE) }</LAURequestNonce>
            <LAUResponseNonce>{ data($validaFirmaDigital/LAU_RESPONSE_NONCE) }</LAUResponseNonce>
            <LAUVersion>{ data($validaFirmaDigital/LAU_VERSION) }</LAUVersion>
            <LAUSignature>{ data($validaFirmaDigital/LAU_SIGNATURE) }</LAUSignature>
            <LAUKey>{ $lauKey }</LAUKey>
            <responseBody>{ data($validaFirmaDigital/MESSAGE) }</responseBody>
        </ns0:verifyLAURequest>
};

declare variable $validaFirmaDigital as element(ns1:validaFirmaDigital) external;
declare variable $lauKey as xs:string external;

xf:verifyLAUIn($validaFirmaDigital,
    $lauKey)