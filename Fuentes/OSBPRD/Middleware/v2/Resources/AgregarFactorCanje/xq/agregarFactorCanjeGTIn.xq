(:: pragma bea:global-element-parameter parameter="$agregarFactorCanje1" element="ns1:agregarFactorCanje" location="../../GestionPuntosTarjetas/xsd/gestionPuntosTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/agregarFactorCanje/xsd/agregarFactorCanje_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/agregarFactorCanje";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionPuntosTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AgregarFactorCanje/xq/agregarFactorCanjeGTIn/";

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

declare function xf:agregarFactorCanjeGTIn($agregarFactorCanje1 as element(ns1:agregarFactorCanje),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_LOGO>{ data($agregarFactorCanje1/LOGO) }</ns0:PN_LOGO>
            <ns0:PN_CODIGOCOMPLEMENTO>{ sortType(data($agregarFactorCanje1/SORT_TYPE)) }</ns0:PN_CODIGOCOMPLEMENTO>
            <ns0:PV_VALORCOMPLEMENTO>{ data($agregarFactorCanje1/SORT_VALUE) }</ns0:PV_VALORCOMPLEMENTO>
            <ns0:PN_FACTORCANJE>{ data($agregarFactorCanje1/EXCHANGE_RATE) }</ns0:PN_FACTORCANJE>
            <ns0:PD_FECHAINICIO>{ data($agregarFactorCanje1/BEGIN_DATE) }</ns0:PD_FECHAINICIO>
            <ns0:PD_FECHAFIN>{ data($agregarFactorCanje1/END_DATE) }</ns0:PD_FECHAFIN>
            <ns0:PV_IDPROMOCION>{ data($agregarFactorCanje1/PROMO_ID) }</ns0:PV_IDPROMOCION>
            <ns0:PV_USUARIO>{ upper-case($userName) }</ns0:PV_USUARIO>
        </ns0:InputParameters>
};

declare variable $agregarFactorCanje1 as element(ns1:agregarFactorCanje) external;
declare variable $userName as xs:string external;

xf:agregarFactorCanjeGTIn($agregarFactorCanje1,
    $userName)