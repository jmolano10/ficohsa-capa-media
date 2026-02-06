xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../PMSV/procesaLotePagoMasivo/xsd/procesaLotePagoMasivo_sp.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/procesaLotePagoMasivo";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/sjPagosMasivosInternoBacthOut/";

declare function xf:sjPagosMasivosInternoBacthOut($contador as xs:int,
    $outputParameters as element(ns0:OutputParameters))
    as element(*) {
        <BATCH>
        	<ID_POSITION>{$contador}</ID_POSITION>
        	{
	        	for $CUSTOMER_BATCH_ID in $outputParameters/ns0:CUSTOMER_BATCH_ID
	        	return
	        		<CUSTOMER_BATCH_ID>{ data($CUSTOMER_BATCH_ID) }</CUSTOMER_BATCH_ID>
			}
			{
	        	for $BANK_BATCH_ID in $outputParameters/ns0:BANK_BATCH_ID
	        	return
	        		if (fn:string($BANK_BATCH_ID) != "") then (
	        			<BANK_BATCH_ID>{ data($BANK_BATCH_ID) }</BANK_BATCH_ID>
	        		) else ()
	        		
			}
			{
	        	for $STATUS in $outputParameters/ns0:STATUS
	        	return
	        		<STATUS>{ data($STATUS) }</STATUS>
			}
			{
	        	for $ERROR_CODE in $outputParameters/ns0:ERROR_CODE
	        	return
	        		if (fn:string($ERROR_CODE) != "") then (
	        			<ERROR_CODE>{ data($ERROR_CODE) }</ERROR_CODE>
	        		) else ()
			}
			{
	        	for $ERROR_MESSAGE in $outputParameters/ns0:ERROR_MESSAGE
	        	return
	        		if (fn:string($ERROR_MESSAGE) != "") then (
	        			<ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
	        		) else ()
			}
		</BATCH>
};

declare variable $contador as xs:int external;
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:sjPagosMasivosInternoBacthOut($contador,
    $outputParameters)