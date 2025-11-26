(:: pragma bea:global-element-parameter parameter="$usuarioCaja" element="ns2:OutputParameters" location="../../xsds/ObtenerUsuarioCaja/ObtenerUsuarioCaja_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionCompletaTransaccion" element="ns1:reversionCompletaTransaccion" location="../../xsds/ReversionCompletaTransaccion/reversionCompletaTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversiondePagodeCheques" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerUsuarioCaja";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionCompletaTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionCompletaTransaccion/ReversionPagoChequesIn/";

declare function xf:ReversionPagoChequesIn($usuarioCaja as element(ns2:OutputParameters),
    $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion),
    $uuid as xs:string)
    as element(ns0:ReversiondePagodeCheques) {
        <ns0:ReversiondePagodeCheques>
            <WebRequestCommon>
                <userName>{ data($usuarioCaja/ns2:PV_USUARIO) }</userName>
                <password>{ data($usuarioCaja/ns2:PV_PASSWORD) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FICOHCHQTRANREVERSEINPUTType>
                <Transactionid>{ data($reversionCompletaTransaccion/TRANSACTION_ID) }</Transactionid>
            </FICOHCHQTRANREVERSEINPUTType>
        </ns0:ReversiondePagodeCheques>
};

declare variable $usuarioCaja as element(ns2:OutputParameters) external;
declare variable $reversionCompletaTransaccion as element(ns1:reversionCompletaTransaccion) external;
declare variable $uuid as xs:string external;

xf:ReversionPagoChequesIn($usuarioCaja,
    $reversionCompletaTransaccion,
    $uuid)