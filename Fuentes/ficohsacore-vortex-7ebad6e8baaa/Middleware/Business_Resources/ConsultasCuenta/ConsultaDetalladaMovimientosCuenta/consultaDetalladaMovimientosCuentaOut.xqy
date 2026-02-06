xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetalladademovscuentaResponse" element="ns0:ConsultadetalladademovscuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalladaMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaOut/";

declare function xf:consultaDetalladaMovimientosCuentaOut($consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse),
    $fecha1 as xs:string,
    $fecha2 as xs:string,
    $fechaSalidaT24 as xs:string)
    as element(ns1:consultaDetalladaMovimientosCuentaResponse) {
        <ns1:consultaDetalladaMovimientosCuentaResponse>
            {
                for $ACCOUNTNAME in $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/ACCOUNTNAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $STARTINGBALANCE in $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/STARTINGBALANCE
                return
                    <STARTING_BALANCE>{ data($STARTINGBALANCE) }</STARTING_BALANCE>
            }
            <START_DATE>{ $fecha1 }</START_DATE>
            <END_DATE>{ $fecha2 }</END_DATE>
            <ns1:consultaDetalladaMovimientosCuentaResponseType>
            {
            	let $refNos := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNREFERENCE
            	let $amounts := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNAMOUNT
            	let $trxDescs := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNDESCRIPTION            	
            	let $cusDescs := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/CUSTOMERDESCRIPTION
            	let $vDates := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/BOOKINGDATE           	
            	let $bDates := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/DATETIME
            	let $chqNumbers := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/CHEQUENUMBER
            	let $inputters := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/INPUTTER
            	let $authorizers := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/AUTHORISER
            	let $agencyCodes := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/BRANCHCODE
            	let $agencyNames := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/BRANCHNAME
            	let $trxCodes := $consultadetalladademovscuentaResponse/WSFICOESTMTGIVENDATESDETType[1]/gWSFICOESTMTGIVENDATESDETDetailType/mWSFICOESTMTGIVENDATESDETDetailType/TXNCODE
                return
    				for $i in (1 to count($refNos))
        			return
	        			if ((data($trxCodes[$i]) != "" or
        					data($vDates[$i]) != "" or
        					data($refNos[$i]) != "" or
        					data($amounts[$i]) != "") and data($vDates[$i]) >= $fechaSalidaT24
        					and not(data($vDates[$i]) = $fechaSalidaT24 and fn:substring(data($refNos[$i]), 1, 2) = "DC")) then (
		                    <ns1:consultaDetalladaMovimientosCuentaResponseRecordType>
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
		                    </ns1:consultaDetalladaMovimientosCuentaResponseRecordType>
		              	) else ()
            }
            </ns1:consultaDetalladaMovimientosCuentaResponseType>
        </ns1:consultaDetalladaMovimientosCuentaResponse>
};

declare variable $consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse) external;
declare variable $fecha1 as xs:string external;
declare variable $fecha2 as xs:string external;
declare variable $fechaSalidaT24 as xs:string external;

xf:consultaDetalladaMovimientosCuentaOut($consultadetalladademovscuentaResponse,
    $fecha1,
    $fecha2,
    $fechaSalidaT24)