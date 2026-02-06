xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$eliminarFactorCanje1" element="ns1:eliminarFactorCanje" location="../../GestionPuntosTarjetas/xsd/gestionPuntosTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarFactorCanje";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjePAIn/";

declare function xf:eliminarFactorCanjePAIn($eliminarFactorCanje1 as element(ns1:eliminarFactorCanje),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDPROMOCION>{ data($eliminarFactorCanje1/PROMO_ID) }</ns0:PV_IDPROMOCION>
            <ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};

declare variable $eliminarFactorCanje1 as element(ns1:eliminarFactorCanje) external;
declare variable $userName as xs:string external;

xf:eliminarFactorCanjePAIn($eliminarFactorCanje1,
    $userName)