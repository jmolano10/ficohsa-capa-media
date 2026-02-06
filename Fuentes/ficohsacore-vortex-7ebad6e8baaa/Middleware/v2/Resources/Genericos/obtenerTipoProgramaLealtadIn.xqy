xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../BusinessServices/INTFC/obtenerTipoProgramaLealtad/xsd/obtenerTipoProgramaLealtad_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoProgramaLealtad";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/obtenerTipoProgramaLealtadIn/";

declare function xf:obtenerTipoProgramaLealtadIn($bin as xs:string,
    $producto as xs:string,
    $grupoAfinidad as xs:decimal)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BIN>{ $bin }</ns0:PV_BIN>
            <ns0:PV_PRODUCTO>{ $producto }</ns0:PV_PRODUCTO>
            <ns0:PN_GRUPO_AFINIDAD>{ $grupoAfinidad }</ns0:PN_GRUPO_AFINIDAD>
        </ns0:InputParameters>
};

declare variable $bin as xs:string external;
declare variable $producto as xs:string external;
declare variable $grupoAfinidad as xs:decimal external;

xf:obtenerTipoProgramaLealtadIn($bin,
    $producto,
    $grupoAfinidad)