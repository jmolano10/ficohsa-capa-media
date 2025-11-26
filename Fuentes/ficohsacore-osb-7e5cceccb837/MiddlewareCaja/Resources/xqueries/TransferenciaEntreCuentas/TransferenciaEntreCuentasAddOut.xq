xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TransferenciaEntreCuentas/TransferenciaEntreCuentasAddOut/";

declare function xf:TransferenciaEntreCuentasAddOut($DEBITCUSTOMERNAME as xs:string,
    $CREDITCUSTOMERNAME as xs:string,
    $BRANCHNAME as xs:string)
    as element(*)* {
        fn-bea:inlinedXML( concat(
	        "<DEBITCUSTOMERNAME>", data($DEBITCUSTOMERNAME), "</DEBITCUSTOMERNAME>",
	        "<CREDITCUSTOMERNAME>", data($CREDITCUSTOMERNAME), "</CREDITCUSTOMERNAME>",
	        "<BRANCHNAME>", data($BRANCHNAME), "</BRANCHNAME>")
        )
};

declare variable $DEBITCUSTOMERNAME as xs:string external;
declare variable $CREDITCUSTOMERNAME as xs:string external;
declare variable $BRANCHNAME as xs:string external;

xf:TransferenciaEntreCuentasAddOut($DEBITCUSTOMERNAME,
    $CREDITCUSTOMERNAME,
    $BRANCHNAME)