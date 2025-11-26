xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaACHDebitoResponse" element="ns0:ConsultaACHDebitoResponse" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionACHResponse" location="../xsd/consultaTransaccionACHTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionACH/xq/consultaTransaccionACHDebitoOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";

declare function xf:consultaTransaccionACHDebitoOut($consultaACHDebitoResponse as element(ns0:ConsultaACHDebitoResponse))
    as element(ns1:consultaTransaccionACHResponse) {
    	if (fn:string($consultaACHDebitoResponse/Status/successIndicator/text()) = "Success" and
    		fn:count($consultaACHDebitoResponse/WSACHDEBITOSType/ZERORECORDS) = 0) then (
	        <ns1:consultaTransaccionACHResponse>
	            <TRANSACTIONS>
	            {                
	                let $GLOBALREFERENCE := $consultaACHDebitoResponse/WSACHDEBITOSType/gWSACHDEBITOSDetailType/mWSACHDEBITOSDetailType/GLOBALREFERENCE
	                let $TXNLEGENTBANK := $consultaACHDebitoResponse/WSACHDEBITOSType/gWSACHDEBITOSDetailType/mWSACHDEBITOSDetailType/TXNLEGENTBANK
	                let $IDPRODUCT := $consultaACHDebitoResponse/WSACHDEBITOSType/gWSACHDEBITOSDetailType/mWSACHDEBITOSDetailType/IDPRODUCT
	                let $TXNSTATUS := $consultaACHDebitoResponse/WSACHDEBITOSType/gWSACHDEBITOSDetailType/mWSACHDEBITOSDetailType/TXNSTATUS
	                let $TXNAMOUNT := $consultaACHDebitoResponse/WSACHDEBITOSType/gWSACHDEBITOSDetailType/mWSACHDEBITOSDetailType/TXNAMOUNT
	                
	                for $i in (1 to count($GLOBALREFERENCE))
	                return
						<TRANSACTION_RECORD>
			                <DETAIL_ID>{ data($GLOBALREFERENCE[$i]) }</DETAIL_ID>
			                <TRANSACTION_ID>{ data($TXNLEGENTBANK[$i]) }</TRANSACTION_ID>
			                <RECEIVING_ACCOUNT>{ data($IDPRODUCT[$i]) }</RECEIVING_ACCOUNT>
			                <STATUS>{ fn:upper-case(data($TXNSTATUS[$i])) }</STATUS>
			                <AMOUNT>{ data($TXNAMOUNT[$i]) }</AMOUNT>
	     				</TRANSACTION_RECORD>
				}    
	            </TRANSACTIONS>
	        </ns1:consultaTransaccionACHResponse>
	    ) else (
	    	<ns1:consultaTransaccionACHResponse/>
	    )
};

declare variable $consultaACHDebitoResponse as element(ns0:ConsultaACHDebitoResponse) external;

xf:consultaTransaccionACHDebitoOut($consultaACHDebitoResponse)