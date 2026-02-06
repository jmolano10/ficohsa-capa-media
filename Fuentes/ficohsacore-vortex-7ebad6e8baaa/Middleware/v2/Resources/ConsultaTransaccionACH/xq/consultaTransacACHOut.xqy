xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeTxnACHRecibidaResponse1" element="ns1:ConsultadeTxnACHRecibidaResponse" location="../../../../Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTransaccionACHResponse" location="../xsd/consultaTransaccionACHTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/consultaTransacACHOut/";

declare function xf:consultaTransacACHOut($consultadeTxnACHRecibidaResponse1 as element(ns1:ConsultadeTxnACHRecibidaResponse))
    as element(ns0:consultaTransaccionACHResponse) {
    	if (fn:string($consultadeTxnACHRecibidaResponse1/Status/successIndicator/text()) = "Success" and
    		fn:count($consultadeTxnACHRecibidaResponse1/WSACHINCOMINGType/ZERORECORDS) = 0) then (
	        <ns0:consultaTransaccionACHResponse>
	            <TRANSACTIONS>
	            {                
	                let $GLOBALREFERENCE := $consultadeTxnACHRecibidaResponse1/WSACHINCOMINGType/gWSACHINCOMINGDetailType/mWSACHINCOMINGDetailType/GLOBALREFERENCE
	                let $TXNLEGENTBANK := $consultadeTxnACHRecibidaResponse1/WSACHINCOMINGType/gWSACHINCOMINGDetailType/mWSACHINCOMINGDetailType/TXNLEGENTBANK
	                let $IDPRODUCT := $consultadeTxnACHRecibidaResponse1/WSACHINCOMINGType/gWSACHINCOMINGDetailType/mWSACHINCOMINGDetailType/IDPRODUCT
	                let $TXNSTATUS := $consultadeTxnACHRecibidaResponse1/WSACHINCOMINGType/gWSACHINCOMINGDetailType/mWSACHINCOMINGDetailType/TXNSTATUS
	                let $TXNAMOUNT := $consultadeTxnACHRecibidaResponse1/WSACHINCOMINGType/gWSACHINCOMINGDetailType/mWSACHINCOMINGDetailType/TXNAMOUNT
	                
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
	        </ns0:consultaTransaccionACHResponse>
	    ) else (
	    	<ns0:consultaTransaccionACHResponse/>
	    )
};

declare variable $consultadeTxnACHRecibidaResponse1 as element(ns1:ConsultadeTxnACHRecibidaResponse) external;

xf:consultaTransacACHOut($consultadeTxnACHRecibidaResponse1)