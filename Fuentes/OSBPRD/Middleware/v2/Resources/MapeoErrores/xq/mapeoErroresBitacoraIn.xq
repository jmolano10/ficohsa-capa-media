(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/guardarBitacoraMapeoErrores/xsd/guardarBitacoraMapeoErrores_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/guardarBitacoraMapeoErrores";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresBitacoraIn/";

declare function xf:mapeoErroresBitacoraIn($codigoError as xs:string,
    $codigoRetorno as xs:string,
    $mensajeOriginal as xs:string,
    $mensajeDevuelto as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_SERVICIO>{ fn:substring-before($mensajeOriginal, "$#$") }</ns0:PV_ID_SERVICIO>
            <ns0:PV_CODIGO_ERROR>{ $codigoError }</ns0:PV_CODIGO_ERROR>
            <ns0:PV_CODIGO_RETORNO>{ $codigoRetorno }</ns0:PV_CODIGO_RETORNO>
            <ns0:PV_MENSAJE_ORIGINAL>{ $mensajeOriginal }</ns0:PV_MENSAJE_ORIGINAL>
            <ns0:PV_MENSAJE_DEVUELTO>{ $mensajeDevuelto }</ns0:PV_MENSAJE_DEVUELTO>
        </ns0:InputParameters>
};

declare variable $codigoError as xs:string external;
declare variable $codigoRetorno as xs:string external;
declare variable $mensajeOriginal as xs:string external;
declare variable $mensajeDevuelto as xs:string external;

xf:mapeoErroresBitacoraIn($codigoError,
    $codigoRetorno,
    $mensajeOriginal,
    $mensajeDevuelto)