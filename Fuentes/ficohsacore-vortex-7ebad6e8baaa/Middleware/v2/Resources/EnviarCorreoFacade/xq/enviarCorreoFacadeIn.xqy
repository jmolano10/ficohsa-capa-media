xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:enviarCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviaCorreoFacade/xq/enviarCorreoFacadeIn/";

declare function xf:enviarCorreoFacadeIn($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:enviarCorreo) {
    <ns0:enviarCorreo>
     {
        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return
        (
          <MODULE_CODE>{$messageListFM[1]}</MODULE_CODE>,
          <PROCESS_CODE>{$messageListFM[2]}</PROCESS_CODE>,
          <TYPE_SEND_EMAIL>{$messageListFM[3]}</TYPE_SEND_EMAIL>,
          <FROM>{$messageListFM[4]}</FROM>,
          <TO>{$messageListFM[5]}</TO>,
          <CC>{$messageListFM[6]}</CC>,
          <SUBJECT_PARAMETERS>{$messageListFM[7]}</SUBJECT_PARAMETERS>,
          <MESSAGE_PARAMETERS>{$messageListFM[8]}</MESSAGE_PARAMETERS>
        )      
      }
    </ns0:enviarCorreo>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:enviarCorreoFacadeIn($procesaMensajeGenericoT24)