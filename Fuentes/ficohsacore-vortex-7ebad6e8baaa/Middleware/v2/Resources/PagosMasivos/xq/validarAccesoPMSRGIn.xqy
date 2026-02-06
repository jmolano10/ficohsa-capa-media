xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:validaAccesoPMSRequest" location="../../../BusinessServices/MTR/validaAccesoPMS/wsdl/validaAccesoPMS.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/pms/accessCheck";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSRGIn/";

declare function xf:validarAccesoPMSRGIn($customerId as xs:string,
    $userName as xs:string)
    as element(ns0:validaAccesoPMSRequest) {
        <ns0:validaAccesoPMSRequest>
            <customerId>{ $customerId }</customerId>
            <userName>{ $userName }</userName>
        </ns0:validaAccesoPMSRequest>
};

declare variable $customerId as xs:string external;
declare variable $userName as xs:string external;

xf:validarAccesoPMSRGIn($customerId,
    $userName)