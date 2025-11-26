xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/ActualizaEstadoTransaccion/xsd/actualizaEstadoTransaccion_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamoCB/xq/actualizaEstadoTransaccionPrestamo/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaEstadoTransaccion";

declare function xf:actualizaEstadoTransaccionPrestamo($tipoTransaccion as xs:string,
    $tipoConsulta as xs:integer,
    $codigoOperacion as xs:string,
    $estadoTransaccion as xs:string,
    $FT as xs:string,
    $refT24 as xs:string,
    $tipoActualizacion as xs:string)
as element(ns0:InputParameters) {
     <ns0:InputParameters>
            <ns0:PV_TIPO_TRANSACCION>{ $tipoTransaccion }</ns0:PV_TIPO_TRANSACCION>
            <ns0:PN_TIPO_CONSULTA>{ $tipoConsulta }</ns0:PN_TIPO_CONSULTA>
            <ns0:PV_CODIGO>{ $codigoOperacion }</ns0:PV_CODIGO>
            <ns0:PV_ESTADO_TRANSACCION>{ $estadoTransaccion }</ns0:PV_ESTADO_TRANSACCION>
            <ns0:PV_FT>{ $FT }</ns0:PV_FT>
            <ns0:PV_REF_T24>{ $refT24 }</ns0:PV_REF_T24>
            <ns0:PV_TIPO_ACTUALIZACION>{ $tipoActualizacion }</ns0:PV_TIPO_ACTUALIZACION>
        </ns0:InputParameters>
};

declare variable $tipoTransaccion as xs:string external;
declare variable $tipoConsulta as xs:integer external;
declare variable $codigoOperacion as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $FT as xs:string external;
declare variable $refT24 as xs:string external;
declare variable $tipoActualizacion as xs:string external;
xf:actualizaEstadoTransaccionPrestamo($tipoTransaccion,
    $tipoConsulta,
    $codigoOperacion,
    $estadoTransaccion,
    $FT,
    $refT24,
    $tipoActualizacion)