(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoReprocesoACHFacade/xq/ActualizaEstadoReprocesoACHFacadeOut/";

declare function xf:ActualizaEstadoReprocesoACHFacadeOut($TRANSACTION_ID as xs:string,
    $SESSION_ID as xs:string,
    $RSPHactualizaEstadoReprocesoACH as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $TRANSACTION_ID }</TRANSACTION_ID>
            <SESSION_ID>{ $SESSION_ID }</SESSION_ID>
            {
            if (fn:upper-case($RSPHactualizaEstadoReprocesoACH) = "SUCCESS") then
            (
            	<MESSAGE>{ "Success" }</MESSAGE>
            ) else (
            	<MESSAGE>{ "Error" }</MESSAGE>
            )
            }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $TRANSACTION_ID as xs:string external;
declare variable $SESSION_ID as xs:string external;
declare variable $RSPHactualizaEstadoReprocesoACH as xs:string external;

xf:ActualizaEstadoReprocesoACHFacadeOut($TRANSACTION_ID,
    $SESSION_ID,
    $RSPHactualizaEstadoReprocesoACH)
