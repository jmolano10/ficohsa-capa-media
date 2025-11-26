(:: pragma bea:global-element-parameter parameter="$envioCorreoElectronico1" element="ns0:envioCorreoElectronico" location="../../EnvioCorreoElectronico/xsd/envioCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/enviaOTP/xsd/enviaOTP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/envioCorreoElectronicoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/enviaOTP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioCorreoElectronicoGT/xq/enviaOTPIn/";

declare function xf:enviaOTPIn($envioCorreoElectronico1 as element(ns0:envioCorreoElectronico))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_DOCUMENT_TYPE>{ data($envioCorreoElectronico1/DOCUMENT_TYPE) }</ns1:PV_DOCUMENT_TYPE>
            <ns1:PV_DOCUMENT_NUMBER>{ data($envioCorreoElectronico1/DOCUMENT_NUMBER) }</ns1:PV_DOCUMENT_NUMBER>
            <ns1:PN_CODIGO_OTP>{ data($envioCorreoElectronico1/OTP_CODE) }</ns1:PN_CODIGO_OTP>
            <ns1:PV_HASH_LINK>{ data($envioCorreoElectronico1/URL_ID) }</ns1:PV_HASH_LINK>
        </ns1:InputParameters>
};

declare variable $envioCorreoElectronico1 as element(ns0:envioCorreoElectronico) external;

xf:enviaOTPIn($envioCorreoElectronico1)
