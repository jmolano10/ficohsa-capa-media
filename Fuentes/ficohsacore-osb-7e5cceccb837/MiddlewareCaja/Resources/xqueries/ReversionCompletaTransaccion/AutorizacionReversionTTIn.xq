(:: pragma bea:global-element-parameter parameter="$usuarioCaja" element="ns2:OutputParameters" location="../../xsds/ObtenerUsuarioCaja/ObtenerUsuarioCaja_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionCompletaTransaccion" element="ns1:reversionCompletaTransaccion" location="../../xsds/ReversionCompletaTransaccion/reversionCompletaTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AutorizacionreversionTT" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerUsuarioCaja";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionCompletaTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionCompletaTransaccion/AutorizacionReversionTTIn/";

declare function xf:AutorizacionReversionTTIn($usuarioCaja as element(ns2:OutputParameters),
    $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion))
    as element(ns0:AutorizacionreversionTT) {
        <ns0:AutorizacionreversionTT>
            <WebRequestCommon>
                <userName>{ data($usuarioCaja/ns2:PV_USUARIO) }</userName>
                <password>{ data($usuarioCaja/ns2:PV_PASSWORD) }</password>
            </WebRequestCommon>
            <TELLERREVERSEType>
                <transactionId>{ data($reversionCompletaTransaccion/TRANSACTION_ID) }</transactionId>
            </TELLERREVERSEType>
        </ns0:AutorizacionreversionTT>
};

declare variable $usuarioCaja as element(ns2:OutputParameters) external;
declare variable $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion) external;

xf:AutorizacionReversionTTIn($usuarioCaja,
    $reversionCompletaTransaccion)