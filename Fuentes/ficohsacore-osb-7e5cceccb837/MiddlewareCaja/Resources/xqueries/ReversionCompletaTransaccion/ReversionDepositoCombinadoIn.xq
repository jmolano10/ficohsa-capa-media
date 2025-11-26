(:: pragma bea:global-element-parameter parameter="$usuarioCaja" element="ns2:OutputParameters" location="../../xsds/ObtenerUsuarioCaja/ObtenerUsuarioCaja_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionCompletaTransaccion" element="ns1:reversionCompletaTransaccion" location="../../xsds/ReversionCompletaTransaccion/reversionCompletaTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Reversiondepositocombinado" location="../../xsds/ReversaTransaccion2/XMLSchema_-704599497.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerUsuarioCaja";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionCompletaTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionCompletaTransaccion/ReversionDepositoCombinadoIn/";

declare function xf:ReversionDepositoCombinadoIn($usuarioCaja as element(ns2:OutputParameters),
    $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion),
    $uuid as xs:string)
    as element(ns0:Reversiondepositocombinado) {
        <ns0:Reversiondepositocombinado>
            <WebRequestCommon>
                <userName>{ data($usuarioCaja/ns2:PV_USUARIO) }</userName>
                <password>{ data($usuarioCaja/ns2:PV_PASSWORD) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOTFSREVERSEType id = "{ data($reversionCompletaTransaccion/TRANSACTION_ID) }"/>
        </ns0:Reversiondepositocombinado>
};

declare variable $usuarioCaja as element(ns2:OutputParameters) external;
declare variable $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion) external;
declare variable $uuid as xs:string external;

xf:ReversionDepositoCombinadoIn($usuarioCaja,
    $reversionCompletaTransaccion,
    $uuid)