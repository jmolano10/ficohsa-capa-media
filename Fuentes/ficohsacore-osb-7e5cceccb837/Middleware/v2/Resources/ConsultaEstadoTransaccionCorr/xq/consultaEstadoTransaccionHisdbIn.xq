(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion" element="ns0:consultaEstadoTransaccion" location="../xsd/consultaEstadoTransaccionCorrTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/consultaEstadoTransaccionHis/xsd/histConsultaEstadoTransaccion_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransaccionTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/histConsultaEstadoTransaccion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/consultaEstadoTransaccionHisdbIn/";

declare function xf:consultaEstadoTransaccionHisdbIn($usuario as xs:string,
$consultaEstadoTransaccion as element(ns0:consultaEstadoTransaccion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TIPO_TRANSACCION>{ data($consultaEstadoTransaccion/TIPO_TRANSACCION) }</ns1:PV_TIPO_TRANSACCION>
            <ns1:PN_TIPO_CONSULTA>{ data($consultaEstadoTransaccion/TIPO_CONSULTA) }</ns1:PN_TIPO_CONSULTA>
            <ns1:PV_CODIGO>{ data($consultaEstadoTransaccion/CODIGO_UNICO_TRANSACCION) }</ns1:PV_CODIGO>
            <ns1:PV_USUARIO>{ $usuario }</ns1:PV_USUARIO>
        </ns1:InputParameters>
};

declare variable $consultaEstadoTransaccion as element(ns0:consultaEstadoTransaccion) external;

declare variable $usuario as xs:string external;
xf:consultaEstadoTransaccionHisdbIn($usuario,
$consultaEstadoTransaccion)