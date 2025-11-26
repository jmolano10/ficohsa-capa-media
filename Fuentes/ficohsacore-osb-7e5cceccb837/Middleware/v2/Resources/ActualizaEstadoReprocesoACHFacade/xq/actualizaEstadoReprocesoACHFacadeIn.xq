(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizaEstadoReprocesoACH" location="../../ActualizaEstadoReprocesoACH/xsd/actualizaEstadoReprocesoACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoReprocesoACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoReprocesoACHFacade/xq/actualizaEstadoReprocesoACHFacadeIn/";

declare function xf:actualizaEstadoReprocesoACHFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:actualizaEstadoReprocesoACH) {
    <ns1:actualizaEstadoReprocesoACH>
    	{
        let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return (
                <REF_CONTROL_T24>{ $messageList[1] }</REF_CONTROL_T24>,
                <CUSTOMER_ID>{ $messageList[2] }</CUSTOMER_ID>,
                <IS_LBTR>{ $messageList[3] }</IS_LBTR>,
                <FT_TRANSACTION>{ $messageList[4] }</FT_TRANSACTION>,
                <STATUS>{ $messageList[5] }</STATUS>,
                <LEGEND_BANK_ISSUER>{ $messageList[6] }</LEGEND_BANK_ISSUER>,
                <REJECTION_CODE>{ $messageList[7] }</REJECTION_CODE>,
                <REJECTION_MESSAGE>{ $messageList[8] }</REJECTION_MESSAGE>,
                <TRANSACTION_TYPE>{ $messageList[9] }</TRANSACTION_TYPE>
                )
         }
    </ns1:actualizaEstadoReprocesoACH>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:actualizaEstadoReprocesoACHFacadeIn($procesaMensajeGenericoT24)
