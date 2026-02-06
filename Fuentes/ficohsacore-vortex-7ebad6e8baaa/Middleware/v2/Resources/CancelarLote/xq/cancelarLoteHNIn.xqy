xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelarLote" element="ns2:cancelarLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/cancelarLote/xsd/cancelarLote_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cancelarLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLoteHNIn/";

declare function xf:cancelarLoteHNIn($cancelarLote as element(ns2:cancelarLote),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_AUDITORIAINFO>
                <ns1:CODIGO_CLIENTE>{ data($cancelarLote/CUSTOMER_ID) }</ns1:CODIGO_CLIENTE>
                <ns1:CODIGO_USUARIO>{ data($cancelarLote/USER_ID) }</ns1:CODIGO_USUARIO>
                <ns1:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:USUARIO_SERVICIO>
            </ns1:PT_AUDITORIAINFO>
            <ns1:PN_NUMEROLOTE>{ data($cancelarLote/BANK_BATCH_ID) }</ns1:PN_NUMEROLOTE>
            <ns1:PD_FECHAINGRESO>{ data($cancelarLote/UPLOAD_DATE) }</ns1:PD_FECHAINGRESO>
        </ns1:InputParameters>
};

declare variable $cancelarLote as element(ns2:cancelarLote) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:cancelarLoteHNIn($cancelarLote,
    $requestHeader)