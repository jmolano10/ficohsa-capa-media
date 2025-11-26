(:: pragma bea:global-element-return element="ns0:consultaPaises" location="../../../../../Middleware/Business_Resources/direcciones/consultaPaises/consultaPaisesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaPaisesH2H/xq/consultaPaisesH2HIN";

declare function xf:consultaPaisesH2HIN($countryCode as xs:string)
    as element(ns0:consultaPaises) {
	<ns0:consultaPaises>
	         <COUNTRY_CODE>{ data($countryCode) }</COUNTRY_CODE>
	</ns0:consultaPaises>
};

declare variable $countryCode as xs:string external;

xf:consultaPaisesH2HIN($countryCode)