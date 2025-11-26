xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeEfecEnMonExtranjera/RetiroDeEfecEnMonExtranjeraAddOut/";

declare function RetiroDeEfecEnMonExtranjeraAddOut($ACCOUNTNAME as xs:string,
    $ALTACCOUNTID as xs:string,
    $BRANCHNAME as xs:string)
    as element(*)* {
        fn-bea:inlinedXML( concat(
	        "<ACCOUNTNAME>", data($ACCOUNTNAME), "</ACCOUNTNAME>",
	        "<ALTACCOUNTID>", data($ALTACCOUNTID), "</ALTACCOUNTID>",
	        "<BRANCHNAME>", data($BRANCHNAME), "</BRANCHNAME>")
        )
};

declare variable $ACCOUNTNAME as xs:string external;
declare variable $ALTACCOUNTID as xs:string external;
declare variable $BRANCHNAME as xs:string external;

RetiroDeEfecEnMonExtranjeraAddOut($ACCOUNTNAME,
    $ALTACCOUNTID,
    $BRANCHNAME)