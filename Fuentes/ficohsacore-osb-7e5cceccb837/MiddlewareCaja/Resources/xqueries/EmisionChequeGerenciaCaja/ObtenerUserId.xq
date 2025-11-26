declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaCaja/obtenerUserId/";

declare function xf:obtenerUserId($user as xs:string)
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

xf:obtenerUserId($user)