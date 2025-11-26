(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion1" element="ns0:consultaEstadoTransaccion" location="../xsd/consultaEstadoTransaccionCorrTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TENGO/RuteoConsultaTransaccionCB/xsd/ruteoConsultaTrxCB_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ruteoConsultaTrxCB";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/ruteoConsultaTrxCBIn/";

declare function xf:ruteoConsultaTrxCBIn($usuario as xs:string,
    $consultaEstadoTransaccion1 as element(ns0:consultaEstadoTransaccion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TIPO_TRANSACCION>{ data($consultaEstadoTransaccion1/TIPO_TRANSACCION) }</ns1:PV_TIPO_TRANSACCION>
            <ns1:PN_TIPO_CONSULTA>{ data($consultaEstadoTransaccion1/TIPO_CONSULTA) }</ns1:PN_TIPO_CONSULTA>
            <ns1:PV_CODIGO_TRX>{ data($consultaEstadoTransaccion1/CODIGO_UNICO_TRANSACCION) }</ns1:PV_CODIGO_TRX>
            <ns1:PV_USUARIO>{ $usuario }</ns1:PV_USUARIO>
        </ns1:InputParameters>
};

declare variable $usuario as xs:string external;
declare variable $consultaEstadoTransaccion1 as element(ns0:consultaEstadoTransaccion) external;

xf:ruteoConsultaTrxCBIn($usuario,
    $consultaEstadoTransaccion1)
