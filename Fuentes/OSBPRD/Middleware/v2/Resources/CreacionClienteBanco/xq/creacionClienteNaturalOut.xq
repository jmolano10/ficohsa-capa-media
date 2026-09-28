(:: pragma bea:global-element-parameter parameter="$creacionClienteNaturalResponse1" element="ns0:CreacionClienteNaturalResponse" location="../../../BusinessServices/T24/creacionCliente/xsd/XMLSchema_1413221226.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creacionClienteNaturalBancoResponse" location="../xsd/creacionClienteBancoTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteBancoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionClienteBanco/xq/creacionClienteNaturalOut/";

declare function xf:creacionClienteNaturalOut($creacionClienteNaturalResponse1 as element(ns0:CreacionClienteNaturalResponse))
    as element(ns1:creacionClienteNaturalBancoResponse) {
    	if (fn:string($creacionClienteNaturalResponse1/Status/successIndicator/text()) = "Success") then (
	        <ns1:creacionClienteNaturalBancoResponse>
	            <ns1:CUSTOMER_ID>{ data($creacionClienteNaturalResponse1/Status/transactionId) }</ns1:CUSTOMER_ID>
	            <ns1:CUSTOMER_NAME>{ data($creacionClienteNaturalResponse1/CUSTOMERType/gSHORTNAME/SHORTNAME[1]) }</ns1:CUSTOMER_NAME>
	        </ns1:creacionClienteNaturalBancoResponse>
	    ) else (
	    	<ns1:creacionClienteNaturalBancoResponse/>
	    )
};

declare variable $creacionClienteNaturalResponse1 as element(ns0:CreacionClienteNaturalResponse) external;

xf:creacionClienteNaturalOut($creacionClienteNaturalResponse1)