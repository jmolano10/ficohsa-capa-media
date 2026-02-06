xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:registrarBitacoraOSBResponse" location="../xsd/registrarBitacoraOSBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarBitacoraOSBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/registrarBitacoraOSBOut/";

declare function xf:registrarBitacoraOSBOut($codigoError as xs:string,
    $mensajeError as xs:string)
    as element(ns0:registrarBitacoraOSBResponse) {
        <ns0:registrarBitacoraOSBResponse>
            <CODIGO_ERROR>{ $codigoError }</CODIGO_ERROR>
            <DESCRIPCION_ERROR>{ $mensajeError }</DESCRIPCION_ERROR>
        </ns0:registrarBitacoraOSBResponse>
};

declare variable $codigoError as xs:string external;
declare variable $mensajeError as xs:string external;

xf:registrarBitacoraOSBOut($codigoError,
    $mensajeError)