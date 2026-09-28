xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/obtenerTipoProgramaLealtad/xsd/obtenerTipoProgramaLealtad_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/obtenerTipoPorgramaLealtadInGT/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoProgramaLealtad";

declare function xf:obtenerTipoPorgramaLealtadInGT($BinGT as xs:string,
    $ProductoTarjetaGT as xs:string,
    $GrupoAfinidadGT as xs:decimal)
   as element(ns0:InputParameters) {
   <ns0:InputParameters>
            <ns0:PV_BIN>{ $BinGT }</ns0:PV_BIN>
            <ns0:PV_PRODUCTO>{ $ProductoTarjetaGT }</ns0:PV_PRODUCTO>
            <ns0:PN_GRUPO_AFINIDAD>{ $GrupoAfinidadGT }</ns0:PN_GRUPO_AFINIDAD>
    </ns0:InputParameters>
};

 declare variable $BinGT as xs:string external;
 declare variable $ProductoTarjetaGT as xs:string external;
 declare variable $GrupoAfinidadGT as xs:decimal external;

 xf:obtenerTipoPorgramaLealtadInGT($BinGT,
    $ProductoTarjetaGT,
    $GrupoAfinidadGT)