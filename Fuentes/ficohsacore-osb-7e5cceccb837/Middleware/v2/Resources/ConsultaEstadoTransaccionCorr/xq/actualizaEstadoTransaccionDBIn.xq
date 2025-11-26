(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion" element="ns0:consultaEstadoTransaccion" location="../xsd/consultaEstadoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/ActualizaEstadoTransaccion/xsd/actualizaEstadoTransaccion_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransaccionTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaEstadoTransaccion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/actualizaEstadoTransaccionDBIn/";

declare function xf:actualizaEstadoTransaccionDBIn($FT as xs:string,
    $refT24 as xs:string,
    $tipoActualizacion as xs:string,
    $estadoTransaccion as xs:string,
    $consultaEstadoTransaccion as element(ns0:consultaEstadoTransaccion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TIPO_TRANSACCION>{ data($consultaEstadoTransaccion/TIPO_TRANSACCION) }</ns1:PV_TIPO_TRANSACCION>
            <ns1:PN_TIPO_CONSULTA>{ data($consultaEstadoTransaccion/TIPO_CONSULTA) }</ns1:PN_TIPO_CONSULTA>
            <ns1:PV_CODIGO>{ data($consultaEstadoTransaccion/CODIGO_UNICO_TRANSACCION) }</ns1:PV_CODIGO>
            <ns1:PV_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns1:PV_ESTADO_TRANSACCION>
            <ns1:PV_FT>{ $FT }</ns1:PV_FT>
            <ns1:PV_REF_T24>{ $refT24 }</ns1:PV_REF_T24>
            <ns1:PV_TIPO_ACTUALIZACION>{ $tipoActualizacion }</ns1:PV_TIPO_ACTUALIZACION>
        </ns1:InputParameters>
};

declare variable $FT as xs:string external;
declare variable $refT24 as xs:string external;
declare variable $tipoActualizacion as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $consultaEstadoTransaccion as element(ns0:consultaEstadoTransaccion) external;

xf:actualizaEstadoTransaccionDBIn($FT,
    $refT24,
    $tipoActualizacion,
    $estadoTransaccion,
    $consultaEstadoTransaccion)
