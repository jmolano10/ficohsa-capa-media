xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/obtenerTipoProgramaLealtad/xsd/obtenerTipoProgramaLealtad_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/obtenerTipoPorgramaLealtadInPA/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoProgramaLealtad";

declare function xf:obtenerTipoPorgramaLealtadInPA($BinPA as xs:string,
    $ProductoTarjetaPA as xs:string,
    $GrupoAfinidadPA as xs:decimal)
as element(ns0:InputParameters) {
     <ns0:InputParameters>
            <ns0:PV_BIN>{ $BinPA }</ns0:PV_BIN>
            <ns0:PV_PRODUCTO>{ $ProductoTarjetaPA }</ns0:PV_PRODUCTO>
            <ns0:PN_GRUPO_AFINIDAD>{ $GrupoAfinidadPA }</ns0:PN_GRUPO_AFINIDAD>
    </ns0:InputParameters>
};
 declare variable $BinPA as xs:string external;
 declare variable $ProductoTarjetaPA as xs:string external;
 declare variable $GrupoAfinidadPA as xs:decimal external;

xf:obtenerTipoPorgramaLealtadInPA($BinPA,
    $ProductoTarjetaPA,
    $GrupoAfinidadPA)