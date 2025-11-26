(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24IN" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:envioMensajeSMS" location="../../envioMensajeSMS/xsd/envioMensajeSMSTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/envioMensajeSMSTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioMensajeSMSFacade/xq/EnvioMensajeSMSIN/";

declare function xf:EnvioMensajeSMSIN($procesaMensajeGenericoT24IN as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:envioMensajeSMS) {
        <ns1:envioMensajeSMS>
        {
        		let $message := fn:tokenize(data($procesaMensajeGenericoT24IN/MESSAGE),"@FM")
        		return (
            <MOBILE_NUMBER>{ normalize-space($message[1]) }</MOBILE_NUMBER>,
            <MESSAGE>{ normalize-space($message[2]) }</MESSAGE>,
            <MESSAGE_TYPE>{  normalize-space($message[3]) }</MESSAGE_TYPE>,
            <SERVICE>{  normalize-space($message[4])  }</SERVICE>,
             <MESSAGE_SOURCE>
                    <COMPANY>{  normalize-space($message[5]) }</COMPANY>
                    <DEPT_CODE>{  normalize-space($message[6]) }</DEPT_CODE>
                     <APPLICATION>{  normalize-space($message[7]) }</APPLICATION>
              </MESSAGE_SOURCE>,
             <ERROR_CODE>{ normalize-space($message[8]) }</ERROR_CODE>
         )
            }
        </ns1:envioMensajeSMS>
};

declare variable $procesaMensajeGenericoT24IN as element(ns0:procesaMensajeGenericoT24) external;

xf:EnvioMensajeSMSIN($procesaMensajeGenericoT24IN)