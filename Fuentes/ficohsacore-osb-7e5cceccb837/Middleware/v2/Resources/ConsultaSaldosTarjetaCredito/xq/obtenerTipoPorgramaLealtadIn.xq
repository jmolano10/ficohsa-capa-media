(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/obtenerTipoProgramaLealtad/xsd/obtenerTipoProgramaLealtad_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoProgramaLealtad";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/obtenerTipoPorgramaLealtadIn/";

declare function xf:obtenerTipoPorgramaLealtadIn($Bin as xs:string,
    $productoTarjeta as xs:string,
    $grupoAfinidad as xs:decimal)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BIN>{ $Bin }</ns0:PV_BIN>
            <ns0:PV_PRODUCTO>{ $productoTarjeta }</ns0:PV_PRODUCTO>
            <ns0:PN_GRUPO_AFINIDAD>{ $grupoAfinidad }</ns0:PN_GRUPO_AFINIDAD>
        </ns0:InputParameters>
};

declare variable $Bin as xs:string external;
declare variable $productoTarjeta as xs:string external;
declare variable $grupoAfinidad as xs:decimal external;

xf:obtenerTipoPorgramaLealtadIn($Bin,
    $productoTarjeta,
    $grupoAfinidad)