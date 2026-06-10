<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:convertirImagen" location="../../../BusinessServices/ABKGT/consultaImagenCheque/xsd/XMLSchema_-131460889.xsd" ::)

declare namespace ns0 = "http://ConsultaImagen.ficohsa.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaMultipleImagenesChequeConvertirImagenGTIn/";

declare function xf:consultaMultipleImagenesChequeConvertirImagenGTIn($ruta as xs:string,
    $nombreArchivo as xs:string)
    as element(ns0:convertirImagen) {
        <ns0:convertirImagen>
            <NombreImagen>{ $nombreArchivo }</NombreImagen>
            <Ruta>{ $ruta }</Ruta>
            <FormatoOrigen>tif</FormatoOrigen>
            <FormatoDestino>BASE64</FormatoDestino>
        </ns0:convertirImagen>
};

declare variable $ruta as xs:string external;
declare variable $nombreArchivo as xs:string external;

xf:consultaMultipleImagenesChequeConvertirImagenGTIn($ruta,
    $nombreArchivo)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaImagenCheque/xsd/XMLSchema_-131460889.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaImagenCheque/xsd/XMLSchema_-131460889"/>
    </con:dependency>
</con:xqueryEntry>