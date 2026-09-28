(:: pragma bea:global-element-parameter parameter="$agregarFactorCanje" element="ns1:agregarFactorCanje" location="../../GestionPuntosTarjetas/xsd/gestionPuntosTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PXYNIC/agregarFactorCanje/xsd/agregarFactorCanje_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/agregarFactorCanje";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AgregarFactorCanje/agregarFactorCanjeIn/";

declare function sortType($type as xs:string)
as xs:integer
{
	if ($type = "TERMINAL_ID") then
		(1)
	elseif($type = "MERCHANT_ID") then
		(2)
	elseif($type = "MERCHANT_TYPE") then
		(3)
	else
		(4)
};

declare function xf:agregarFactorCanjeIn($agregarFactorCanje as element(ns1:agregarFactorCanje),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_LOGO>{ data($agregarFactorCanje/LOGO) }</ns0:PN_LOGO>
            <ns0:PN_CODIGOCOMPLEMENTO>{ sortType(data($agregarFactorCanje/SORT_TYPE)) }</ns0:PN_CODIGOCOMPLEMENTO>
            <ns0:PV_VALORCOMPLEMENTO>{ data($agregarFactorCanje/SORT_VALUE) }</ns0:PV_VALORCOMPLEMENTO>
            <ns0:PN_FACTORCANJE>{ data($agregarFactorCanje/EXCHANGE_RATE) }</ns0:PN_FACTORCANJE>
            <ns0:PD_FECHAINICIO>{ data($agregarFactorCanje/BEGIN_DATE) }</ns0:PD_FECHAINICIO>
            <ns0:PD_FECHAFIN>{ data($agregarFactorCanje/END_DATE) }</ns0:PD_FECHAFIN>
            <ns0:PV_IDPROMOCION>{ data($agregarFactorCanje/PROMO_ID) }</ns0:PV_IDPROMOCION>
            <ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};

declare variable $agregarFactorCanje as element(ns1:agregarFactorCanje) external;
declare variable $userName as xs:string external;

xf:agregarFactorCanjeIn($agregarFactorCanje,
    $userName)