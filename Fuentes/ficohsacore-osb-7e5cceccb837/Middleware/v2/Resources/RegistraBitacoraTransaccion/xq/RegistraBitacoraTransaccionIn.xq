(:: pragma bea:global-element-parameter parameter="$registroBitacoraTransaccion" element="ns1:registroBitacoraTransaccion" location="../xsd/RegistraBitacoraTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OSB/RegistraBitacoraTransaccion/xsd/RegistraBitacoraTransaccion_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraTransaccionTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistraBitacoraTransaccion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraBitacoraTransaccion/xq/RegistraBitacoraTransaccionIn/";

declare function xf:RegistraBitacoraTransaccionIn($registroBitacoraTransaccion as element(ns1:registroBitacoraTransaccion))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ data($registroBitacoraTransaccion/UUID) }</ns0:PV_UUID>
            <ns0:PN_TIPO_TRANSACCION>{ data($registroBitacoraTransaccion/TRANSACTION_TYPE) }</ns0:PN_TIPO_TRANSACCION>
            {
                for $ERROR_CODE in $registroBitacoraTransaccion/ERROR_CODE
                return
                    <ns0:PN_CODIGO_ERROR>{ data($ERROR_CODE) }</ns0:PN_CODIGO_ERROR>
            }
            {
                for $ERROR_MESSAGE in $registroBitacoraTransaccion/ERROR_MESSAGE
                return
                    <ns0:PV_MENSAJE_ERROR>{ data($ERROR_MESSAGE) }</ns0:PV_MENSAJE_ERROR>
            }
            {
                for $USER in $registroBitacoraTransaccion/USER
                return
                    <ns0:PV_USUARIO>{ data($USER) }</ns0:PV_USUARIO>
            }
            {
                for $DATE_TIME in $registroBitacoraTransaccion/DATE_TIME
                return
                    <ns0:PD_FECHA>{ data($DATE_TIME) }</ns0:PD_FECHA>
            }
            {
                for $XML_REQUEST in $registroBitacoraTransaccion/XML_REQUEST
                return
                    <ns0:PC_XML_REQUEST>{ data($XML_REQUEST) }</ns0:PC_XML_REQUEST>
            }
            {
                for $XML_RESPONSE in $registroBitacoraTransaccion/XML_RESPONSE
                return
                    <ns0:PC_XML_RESPONSE>{ data($XML_RESPONSE) }</ns0:PC_XML_RESPONSE>
            }
        </ns0:InputParameters>
};

declare variable $registroBitacoraTransaccion as element(ns1:registroBitacoraTransaccion) external;

xf:RegistraBitacoraTransaccionIn($registroBitacoraTransaccion)