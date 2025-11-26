(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion1" element="ns1:consultaEstadoTransaccion" location="../xsd/consultaEstadoTransaccionCorrTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TENGO/RuteoConsultaTransaccionesHistCB/xsd/ruteoConsultaTrxCBHist_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransaccionTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ruteoConsultaTrxCBHist";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/ruteoConsultaTrxHistCBIn/";

declare function xf:ruteoConsultaTrxHistCBIn($usuario as xs:string,
    $consultaEstadoTransaccion1 as element(ns1:consultaEstadoTransaccion))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_TRANSACCION>{ data($consultaEstadoTransaccion1/TIPO_TRANSACCION) }</ns0:PV_TIPO_TRANSACCION>
            <ns0:PN_TIPO_CONSULTA>{ data($consultaEstadoTransaccion1/TIPO_CONSULTA) }</ns0:PN_TIPO_CONSULTA>
            <ns0:PV_CODIGO_TRX>{ data($consultaEstadoTransaccion1/CODIGO_UNICO_TRANSACCION) }</ns0:PV_CODIGO_TRX>
            <ns0:PV_USUARIO>{ $usuario }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};

declare variable $usuario as xs:string external;
declare variable $consultaEstadoTransaccion1 as element(ns1:consultaEstadoTransaccion) external;

xf:ruteoConsultaTrxHistCBIn($usuario,
    $consultaEstadoTransaccion1)
