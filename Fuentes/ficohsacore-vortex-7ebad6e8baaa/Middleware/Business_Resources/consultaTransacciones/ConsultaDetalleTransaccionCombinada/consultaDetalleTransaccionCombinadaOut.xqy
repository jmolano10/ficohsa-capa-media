xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTFSResponse1" element="ns1:ConsultadetransaccionTFSResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleTransaccionCombinadaResponse" location="consultaDetalleTransaccionCombinadaTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionCombinadaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionCombinada/out/";

declare function xf:out($consultadetransaccionTFSResponse1 as element(ns1:ConsultadetransaccionTFSResponse))
    as element(ns0:consultaDetalleTransaccionCombinadaResponse) {
        <ns0:consultaDetalleTransaccionCombinadaResponse>
            {
                for $ID in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/ID
                return
                    <TRANSACTION_ID>{ data($ID) }</TRANSACTION_ID>
            }
            {
                for $TXNDESC in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/TXNDESC
                return
                    <TRANSACTION_DESCRIPTION>{ data($TXNDESC) }</TRANSACTION_DESCRIPTION>
            }
            {
                for $BOOKINGDATE in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/BOOKINGDATE
                return
                    <BOOKING_DATE>{ data($BOOKINGDATE) }</BOOKING_DATE>
            }
            {
                for $BOOKINGDATE in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/BOOKINGDATE
                return
                    <VALUE_DATE>{ data($BOOKINGDATE) }</VALUE_DATE>
            }
            {
                for $PRIMARYACCOUNT in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/PRIMARYACCOUNT
                return
                    <ACCOUNT_NUMBER>{ data($PRIMARYACCOUNT) }</ACCOUNT_NUMBER>
            }
            {
                for $TXNAMOUNT in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/TXNAMOUNT
                return
                    <AMOUNT>{ data($TXNAMOUNT) }</AMOUNT>
            }
            {
                for $TXNCURRENCY in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/TXNCURRENCY
                return
                    <CURRENCY>{ data($TXNCURRENCY) }</CURRENCY>
            }
            {
                for $INPUTTER in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $AUTHORISER in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/AUTHORISER
                return
                    <AUTHORIZER>{ data($AUTHORISER) }</AUTHORIZER>
            }
            {
                for $BRANCHCODE in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/BRANCHCODE
                return
                    <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
            }
            {
                for $BRANCHNAME in $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/BRANCHNAME
                return
                    <BRANCH_NAME>{ data($BRANCHNAME) }</BRANCH_NAME>
            }
            <ns0:consultaDetalleTransaccionCombinadaResponseType>
            
            			{            	
            	let $CHILDTXNS := $consultadetransaccionTFSResponse1/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType
                for $i in (1 to count($CHILDTXNS))
                return
	            <ns0:consultaDetalleTransaccionCombinadaResponseRecordType>
	                	<CHILD_TXN_ID>{data($CHILDTXNS[$i]/CHILDTXNID)}</CHILD_TXN_ID>
	                	<CHILD_TXN_CODE>{data($CHILDTXNS[$i]/CHILDTXNCODE)}</CHILD_TXN_CODE>
	                	<CHILD_TXN_DESC>{ data($CHILDTXNS[$i]/CHILDTXNDESCFULL) }</CHILD_TXN_DESC>
	                	<CHILD_TXN_AMOUNT>{ data($CHILDTXNS[$i]/CHILDTXNAMOUNT) }</CHILD_TXN_AMOUNT>
						<CHILD_TXN_CURRENCY>{ data($CHILDTXNS[$i]/CHILDTXNCURRENCY) }</CHILD_TXN_CURRENCY>
						<CHILD_TXN_CHQ_NUMBER>{ data($CHILDTXNS[$i]/CHILDTXNCHQNUMBER) }</CHILD_TXN_CHQ_NUMBER>
						<CHILD_TXN_BANK_CODE>{ data($CHILDTXNS[$i]/CHILDTXNCHQBANK) }</CHILD_TXN_BANK_CODE>
						<CHILD_TXN_BANK_NAME>{ data($CHILDTXNS[$i]/CHILDTXNBANKNAME) }</CHILD_TXN_BANK_NAME>
						<CHILD_TXN_INSTRUCTING_PARTY>{ data($CHILDTXNS[$i]/DEPOSITLIBRADOR) }</CHILD_TXN_INSTRUCTING_PARTY> 
	                </ns0:consultaDetalleTransaccionCombinadaResponseRecordType>
	            }
	            </ns0:consultaDetalleTransaccionCombinadaResponseType>
	        </ns0:consultaDetalleTransaccionCombinadaResponse>
};

declare variable $consultadetransaccionTFSResponse1 as element(ns1:ConsultadetransaccionTFSResponse) external;

xf:out($consultadetransaccionTFSResponse1)