xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$respuestaAbanks" element="ns0:OutputParameters" location="../Resources/ConsultaDetalladaMovimientosCuenta/xsd/ORA_BANK_OSB_K__CONSDETMOVSCTA_TOPLEVEL-24OSB_CON_DET_MOVS_CTA.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$respuestaT24" element="ns1:ConsultadetalladademovscuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaDetalladaMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuentaAbanks/consultaDetalladaMovimientosCuentaMixtoOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K__CONSDETMOVSCTA/TOPLEVEL-24OSB_CON_DET_MOVS_CTA/";

declare function xf:consultaDetalladaMovimientosCuentaMixtoOut($respuestaAbanks as element(ns0:OutputParameters),
    $respuestaT24 as element(ns1:ConsultadetalladademovscuentaResponse),
    $fechaSalidaT24 as xs:string,
    $beginDate  as xs:string)
    as element(ns2:consultaDetalladaMovimientosCuentaResponse) {
        <ns2:consultaDetalladaMovimientosCuentaResponse>
            {
                for $ACCOUNTNAME in $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/ACCOUNTNAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                let $STARTINGBALANCET24 := fn:string($respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/STARTINGBALANCE/text())
                let $STARTINGBALANCETABANKS := fn:string($respuestaAbanks/ns0:STARTING_BALANCE/text())
                return
                if ($beginDate < $fechaSalidaT24) then (
                	<STARTING_BALANCE>{ if (number($STARTINGBALANCETABANKS) < 0) then ( "0" ) else ( $STARTINGBALANCETABANKS ) }</STARTING_BALANCE>
                ) else (
                    <STARTING_BALANCE>{ data($STARTINGBALANCET24) }</STARTING_BALANCE>
                )
            }
            {
                for $BEGIN_DATE in $respuestaAbanks/ns0:BEGIN_DATE
                return
                    <START_DATE>{ data($BEGIN_DATE) }</START_DATE>
            }
            {
                for $END_DATE in $respuestaAbanks/ns0:END_DATE
                return
                    <END_DATE>{ data($END_DATE) }</END_DATE>
            }
            <ns2:consultaDetalladaMovimientosCuentaResponseType>
            {
                let $refs  := ($respuestaAbanks/ns0:REF_NO/ns0:ITEM)  
                let $amounts  := ($respuestaAbanks/ns0:AMOUNT/ns0:ITEM)  
                let $trxDescrs  := ($respuestaAbanks/ns0:TRANSACTION_DESCRIPTION/ns0:ITEM)  
                let $cusDescrs  := ($respuestaAbanks/ns0:CUSTOMER_DESCRIPTION/ns0:ITEM)  
                let $bDates  := ($respuestaAbanks/ns0:BOOKING_DATE/ns0:ITEM)  
                let $vDates  := ($respuestaAbanks/ns0:VALUE_DATE/ns0:ITEM)  
                let $chkNros  := ($respuestaAbanks/ns0:CHEQUE_NUMBER/ns0:ITEM)  
                let $inputters  := ($respuestaAbanks/ns0:INPUTTER/ns0:ITEM)  
                let $auths  := ($respuestaAbanks/ns0:AUTHORIZER/ns0:ITEM)  
                let $agencies_code  := ($respuestaAbanks/ns0:AGENCY_CODE/ns0:ITEM)  
                let $agencies_name  := ($respuestaAbanks/ns0:AGENCY_NAME/ns0:ITEM)  
                let $transactions_code  := ($respuestaAbanks/ns0:TRANSACTION_CODE/ns0:ITEM)  
                let $effect_on_balance  := ($respuestaAbanks/ns0:EFFECT_ON_BALANCE/ns0:ITEM)
                return
                    for $i  in (1 to count($refs))  
                    return 
                    if (data($vDates) < $fechaSalidaT24)then(
	                    <ns2:consultaDetalladaMovimientosCuentaResponseRecordType>
	                        <REF_NO>{ data($refs[$i]) }</REF_NO>
	                        <AMOUNT>{ data($amounts[$i]) }</AMOUNT>
	                        <TRANSACTION_DESCRIPTION>{ data($trxDescrs[$i]) }</TRANSACTION_DESCRIPTION>
	                        <CUSTOMER_DESCRIPTION>{ data($cusDescrs[$i]) }</CUSTOMER_DESCRIPTION>
	                        <BOOKING_DATE>{ data($bDates[$i]) }</BOOKING_DATE>
	                        <VALUE_DATE>{ data($vDates[$i]) }</VALUE_DATE>
	                        <CHEQUE_NUMBER>{ data($chkNros[$i]) }</CHEQUE_NUMBER>
	                        <INPUTTER>{ data($inputters[$i]) }</INPUTTER>
	                        <AUTHORIZER>{ data($auths[$i]) }</AUTHORIZER>
	                        <AGENCY_CODE>{ data($agencies_code[$i]) }</AGENCY_CODE>
	                        <AGENCY_NAME>{ data($agencies_name[$i]) }</AGENCY_NAME>
	                        <TRANSACTION_CODE>{ data($transactions_code[$i]) }</TRANSACTION_CODE>
	                        <EFFECT_ON_BALANCE>{ data($effect_on_balance[$i]) }</EFFECT_ON_BALANCE>
						</ns2:consultaDetalladaMovimientosCuentaResponseRecordType>
					)else()
            }
            {
            	let $refNos := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNREFERENCE
            	let $amounts := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNAMOUNT
            	let $trxDescs := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNDESCRIPTION
            	let $cusDescs := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/CUSTOMERDESCRIPTION
            	let $bDates := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/DATETIME
            	let $vDates := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/BOOKINGDATE
            	let $chqNumbers := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/CHEQUENUMBER
            	let $inputters := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/INPUTTER
            	let $authorizers := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/AUTHORISER
            	let $agencyCodes := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/BRANCHCODE
            	let $agencyNames := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/BRANCHNAME
            	let $trxCodes := $respuestaT24/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNCODE
                return
					for $i in (1 to count($refNos))
        			return
	        			if ((data($trxCodes[$i]) != "" or
        					data($vDates[$i]) != "" or
        					data($refNos[$i]) != "" or
        					data($amounts[$i]) != "") and data($vDates[$i]) >= $fechaSalidaT24
        					and not(data($vDates[$i]) = $fechaSalidaT24 and fn:substring(data($refNos[$i]), 1, 2) = "DC")) then (
		                    <ns2:consultaDetalladaMovimientosCuentaResponseRecordType>
		                        <REF_NO>{ data($refNos[$i]) }</REF_NO>
		                        <AMOUNT>{ data($amounts[$i]) }</AMOUNT>
		                        <TRANSACTION_DESCRIPTION>{ data($trxDescs[$i]) }</TRANSACTION_DESCRIPTION>
		                        <CUSTOMER_DESCRIPTION>{ replace(fn:string($cusDescs[$i]/text()),'\.\|\|','') }</CUSTOMER_DESCRIPTION>
		                        <BOOKING_DATE>{ concat("20", $bDates[$i]) }</BOOKING_DATE>
		                        <VALUE_DATE>{ data($vDates[$i]) }</VALUE_DATE>
		                        <CHEQUE_NUMBER>{ data($chqNumbers[$i]) }</CHEQUE_NUMBER>
		                        <INPUTTER>{ data($inputters[$i]) }</INPUTTER>
		                        <AUTHORIZER>{ data($authorizers[$i]) }</AUTHORIZER>
		                        <AGENCY_CODE>{ data($agencyCodes[$i]) }</AGENCY_CODE>
		                        <AGENCY_NAME>{ data($agencyNames[$i]) }</AGENCY_NAME>
		                        <TRANSACTION_CODE>{ data($trxCodes[$i]) }</TRANSACTION_CODE>
		                        <EFFECT_ON_BALANCE>1</EFFECT_ON_BALANCE>
		                    </ns2:consultaDetalladaMovimientosCuentaResponseRecordType>
		              	) else ()
            }
            </ns2:consultaDetalladaMovimientosCuentaResponseType>
        </ns2:consultaDetalladaMovimientosCuentaResponse>
};

declare variable $respuestaAbanks as element(ns0:OutputParameters) external;
declare variable $respuestaT24 as element(ns1:ConsultadetalladademovscuentaResponse) external;
declare variable $fechaSalidaT24 as xs:string external;
declare variable $beginDate as xs:string external;

xf:consultaDetalladaMovimientosCuentaMixtoOut($respuestaAbanks,
    $respuestaT24,
    $fechaSalidaT24,
    $beginDate)