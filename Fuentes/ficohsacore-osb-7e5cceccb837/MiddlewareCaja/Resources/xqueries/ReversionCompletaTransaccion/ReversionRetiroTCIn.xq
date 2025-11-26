(:: pragma bea:global-element-parameter parameter="$usuarioCaja" element="ns2:OutputParameters" location="../../xsds/ObtenerUsuarioCaja/ObtenerUsuarioCaja_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionCompletaTransaccion" element="ns1:reversionCompletaTransaccion" location="../../xsds/ReversionCompletaTransaccion/reversionCompletaTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversionpagoTC" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerUsuarioCaja";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionCompletaTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionCompletaTransaccion/ReversionpagoTCIn/";

declare function xf:ReversionpagoTCIn($usuarioCaja as element(ns2:OutputParameters),
    $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion),
    $uuid as xs:string)
    as element(ns0:ReversionpagoTC) {
        <ns0:ReversionpagoTC>
            <WebRequestCommon>
                <userName>{ data($usuarioCaja/ns2:PV_USUARIO) }</userName>
                <password>{ data($usuarioCaja/ns2:PV_PASSWORD) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOCCARDPAYMENTREVType id = "{ data($reversionCompletaTransaccion/TRANSACTION_ID) }"/>
        </ns0:ReversionpagoTC>
};

declare variable $usuarioCaja as element(ns2:OutputParameters) external;
declare variable $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion) external;
declare variable $uuid as xs:string external;

xf:ReversionpagoTCIn($usuarioCaja,
    $reversionCompletaTransaccion,
    $uuid)