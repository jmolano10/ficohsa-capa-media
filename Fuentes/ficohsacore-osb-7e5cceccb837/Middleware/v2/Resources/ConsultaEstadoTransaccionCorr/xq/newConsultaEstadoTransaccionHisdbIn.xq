(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion" element="ns1:consultaEstadoTransaccion" location="../xsd/consultaEstadoTransaccionCorrTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ConsultarEstadoTransaccionHisCB/xsd/consultaEstadoTransaccionHis_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransaccionTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEstadoTransaccionHis";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/newConsultaEstadoTransaccionHisdbIn/";

declare function xf:newConsultaEstadoTransaccionHisdbIn($usuario as xs:string,
    $consultaEstadoTransaccion as element(ns1:consultaEstadoTransaccion))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_TRANSACCION>{ data($consultaEstadoTransaccion/TIPO_TRANSACCION) }</ns0:PV_TIPO_TRANSACCION>
            <ns0:PN_TIPO_CONSULTA>{ data($consultaEstadoTransaccion/TIPO_CONSULTA) }</ns0:PN_TIPO_CONSULTA>
            <ns0:PV_CODIGO>{ data($consultaEstadoTransaccion/CODIGO_UNICO_TRANSACCION) }</ns0:PV_CODIGO>
            <ns0:PV_USUARIO>{ $usuario }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};

declare variable $usuario as xs:string external;
declare variable $consultaEstadoTransaccion as element(ns1:consultaEstadoTransaccion) external;

xf:newConsultaEstadoTransaccionHisdbIn($usuario,
    $consultaEstadoTransaccion)
