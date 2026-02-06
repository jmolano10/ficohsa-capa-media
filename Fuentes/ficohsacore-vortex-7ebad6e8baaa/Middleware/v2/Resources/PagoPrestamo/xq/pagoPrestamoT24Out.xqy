xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoaprestamoAAResponse" element="ns0:PagoaprestamoAAResponse" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoPrestamoResponse" location="../xsd/pagoPrestamoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24Out/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";

declare function xf:pagoPrestamoT24Out($pagoaprestamoAAResponse as element(ns0:PagoaprestamoAAResponse),
    $successIndicatorQry2 as xs:string)
    as element(ns1:pagoPrestamoResponse) {
        if (fn:string($pagoaprestamoAAResponse/Status/successIndicator/text()) = "Success" and 
    		$successIndicatorQry2 = "SUCCESS") then (
	        <ns1:pagoPrestamoResponse>
	            <DATE_TIME>{ fn:concat("20",data($pagoaprestamoAAResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1])) }</DATE_TIME>
	            <LOAN_NUMBER>{ data($pagoaprestamoAAResponse/TELLERFINANCIALSERVICESType/LRLOANNO) }</LOAN_NUMBER>
	            <DUE_ID></DUE_ID>
	            <PAYMENT_AMOUNT>{ data($pagoaprestamoAAResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/AMOUNT) }</PAYMENT_AMOUNT>
	        </ns1:pagoPrestamoResponse>
	    ) else (
	    	<ns1:pagoPrestamoResponse/>
	    )
};

declare variable $pagoaprestamoAAResponse as element(ns0:PagoaprestamoAAResponse) external;
declare variable $successIndicatorQry2 as xs:string external;

xf:pagoPrestamoT24Out($pagoaprestamoAAResponse,
    $successIndicatorQry2)