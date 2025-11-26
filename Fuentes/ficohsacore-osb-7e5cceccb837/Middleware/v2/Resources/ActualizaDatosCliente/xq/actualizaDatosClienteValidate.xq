xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$actualizaDatosClienteRequest1" element="ns0:actualizaDatosClienteRequest" location="../xsd/actualizaDatosCliente.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/actualizaDatosClienteValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes/v2";

declare function xf:actualizaDatosClienteValidate($actualizaDatosClienteRequest1 as element(ns0:actualizaDatosClienteRequest))
    as xs:string {
        if ($actualizaDatosClienteRequest1/CUSTOMER_ID/text() != "" and 
        	$actualizaDatosClienteRequest1/PRIMARY_EMAIL/text() != "") then (
        	if (fn:matches($actualizaDatosClienteRequest1/PRIMARY_EMAIL/text(),".*@.+\..+")) then (
        		""
        	) else ("INVALID EMAIL FORMAT")
        )
        else ( "REQUIRED FIELDS NOT SUPPLIED")
};

declare variable $actualizaDatosClienteRequest1 as element(ns0:actualizaDatosClienteRequest) external;

xf:actualizaDatosClienteValidate($actualizaDatosClienteRequest1)