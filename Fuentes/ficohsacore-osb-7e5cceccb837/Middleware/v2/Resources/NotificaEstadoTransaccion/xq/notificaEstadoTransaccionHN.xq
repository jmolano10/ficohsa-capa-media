(:: pragma bea:global-element-parameter parameter="$notificaEstadoTransaccion1" element="ns0:notificaEstadoTransaccion" location="../xsd/notificaEstadoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:envioMensajeSMS" location="../../envioMensajeSMS/xsd/envioMensajeSMSTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/envioMensajeSMSTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoTransaccion/xq/notificaEstadoTransaccionHN/";

declare function xf:notificaEstadoTransaccionHN($notificaEstadoTransaccion1 as element(ns0:notificaEstadoTransaccion))
    as element(ns1:envioMensajeSMS) {
        <ns1:envioMensajeSMS>
            <MOBILE_NUMBER>{ data($notificaEstadoTransaccion1/ns0:MOBILE_NUMBER) }</MOBILE_NUMBER>
            <MESSAGE>{ data($notificaEstadoTransaccion1/ns0:MESSAGE) }</MESSAGE>
            <MESSAGE_TYPE>{ data($notificaEstadoTransaccion1/ns0:MESSAGE_TYPE) }</MESSAGE_TYPE>
            <SERVICE>{ data($notificaEstadoTransaccion1/ns0:SERVICE) }</SERVICE>
            <MESSAGE_SOURCE>
                <COMPANY>{ data($notificaEstadoTransaccion1/ns0:MESSAGE_SOURCE/ns0:COMPANY) }</COMPANY>
                <DEPT_CODE>{ data($notificaEstadoTransaccion1/ns0:MESSAGE_SOURCE/ns0:DEPT_CODE) }</DEPT_CODE>
                {
                    for $APPLICATION in $notificaEstadoTransaccion1/ns0:MESSAGE_SOURCE/ns0:APPLICATION
                    return
                        <APPLICATION>{ data($APPLICATION) }</APPLICATION>
                }
            </MESSAGE_SOURCE>
            {
                for $ERROR_CODE in $notificaEstadoTransaccion1/ns0:ERROR_CODE
                return
                    <ERROR_CODE>{ data($ERROR_CODE) }</ERROR_CODE>
            }
        </ns1:envioMensajeSMS>
};

declare variable $notificaEstadoTransaccion1 as element(ns0:notificaEstadoTransaccion) external;

xf:notificaEstadoTransaccionHN($notificaEstadoTransaccion1)
