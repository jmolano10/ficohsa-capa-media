xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaMonedaExtCaja/ObtenerUserId/";

declare function xf:ObtenerUserId($user as xs:string)
    as xs:string {
        let $userId := fn-bea:fail-over(fn:tokenize(data($user), "_")[2], $user)
        return
        	if($userId != "") then (
        		$userId
        	) else (
        		$user
        	)
};

declare variable $user as xs:string external;

xf:ObtenerUserId($user)