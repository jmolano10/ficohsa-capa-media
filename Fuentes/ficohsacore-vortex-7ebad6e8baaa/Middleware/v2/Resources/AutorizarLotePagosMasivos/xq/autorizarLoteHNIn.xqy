xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autorizarLote" element="ns1:autorizarLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/PMSV/autorizaLote/xsd/autorizarLote_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/autorizarLote";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteHNIn/";

declare function xf:autorizarLoteHNIn($autorizarLote as element(ns1:autorizarLote),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PT_AUDITORIAINFO>
                <ns2:CODIGO_CLIENTE>{ data($autorizarLote/CUSTOMER_ID) }</ns2:CODIGO_CLIENTE>
                <ns2:CODIGO_USUARIO>{ data($autorizarLote/USER_ID) }</ns2:CODIGO_USUARIO>
                <ns2:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns2:USUARIO_SERVICIO>
            </ns2:PT_AUDITORIAINFO>
            <ns2:PT_NUMEROLOTE>
                {
                    for $BATCH in $autorizarLote/BATCHES/BATCH
                    return
                        <ns2:ITEM>{ data($BATCH/BANK_BATCH_ID) }</ns2:ITEM>
                }
            </ns2:PT_NUMEROLOTE>
            <ns2:PT_FECHAINGRESO>
                {
                    for $BATCH in $autorizarLote/BATCHES/BATCH
                    return
                        <ns2:ITEM>{ data($BATCH/UPLOAD_DATE) }</ns2:ITEM>
                }
            </ns2:PT_FECHAINGRESO>
            <ns2:PT_FECHAAPLICACION>
                {
                    for $BATCH in $autorizarLote/BATCHES/BATCH
                    return
                        <ns2:ITEM>{ data($BATCH/APPLICATION_DATE) }</ns2:ITEM>
                }
            </ns2:PT_FECHAAPLICACION>
        </ns2:InputParameters>
};

declare variable $autorizarLote as element(ns1:autorizarLote) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:autorizarLoteHNIn($autorizarLote,
    $requestHeader)