(:: pragma bea:global-element-parameter parameter="$pagoaprestamoAAFTResponse1" element="ns1:PagoaprestamoAAFTResponse" location="../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoPrestamoResponse" location="../pagoPrestamoTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/PagoPrestamoBOT24Out/";

declare function xf:PagoPrestamoBOT24Out($pagoaprestamoAAFTResponse1 as element(ns1:PagoaprestamoAAFTResponse),
	$successIndicatorQry2 as xs:string)
    as element(ns0:pagoPrestamoResponse) {
    	if (fn:string($pagoaprestamoAAFTResponse1/Status/successIndicator/text()) = "Success" and 
    		$successIndicatorQry2 = "SUCCESS") then (
	        <ns0:pagoPrestamoResponse>
	            <DATE_TIME>{ fn:concat("20",data($pagoaprestamoAAFTResponse1/FICOHADVANCEPAYMENTSType/gDATETIME/DATETIME[1])) }</DATE_TIME>
	            <LOAN_NUMBER>{ data($pagoaprestamoAAFTResponse1/FICOHADVANCEPAYMENTSType/LOANNO) }</LOAN_NUMBER>
	            <DUE_ID></DUE_ID>
	            <PAYMENT_AMOUNT>{ data($pagoaprestamoAAFTResponse1/FICOHADVANCEPAYMENTSType/AMOUNT) }</PAYMENT_AMOUNT>
	        </ns0:pagoPrestamoResponse>
	    ) else (
	    	<ns0:pagoPrestamoResponse/>
	    )
};

declare variable $pagoaprestamoAAFTResponse1 as element(ns1:PagoaprestamoAAFTResponse) external;
declare variable $successIndicatorQry2 as xs:string external;

xf:PagoPrestamoBOT24Out($pagoaprestamoAAFTResponse1,
	$successIndicatorQry2)