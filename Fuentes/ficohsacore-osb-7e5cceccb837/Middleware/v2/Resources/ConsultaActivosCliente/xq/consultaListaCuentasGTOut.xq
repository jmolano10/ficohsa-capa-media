xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaListaCuentas/xsd/consultaListaCuentas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaActivosClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasGTOut1/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";

declare function mensajeRespuesta($successIndicator as xs:string, $registros as item()*) as xs:string {
	if (upper-case($successIndicator) = 'SUCCESS' and count($registros) > 0) then (
		'Success'
    ) else if ((upper-case($successIndicator) = 'SUCCESS' and count($registros) = 0) or upper-case($successIndicator) = 'NO RECORDS' ) then (
    	'No Records'
    ) else (
    	'Error'
    )
};

declare function xf:consultaListaCuentasGTOut1($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaActivosClienteResponse) {
       if (fn:string($outputParameters1/ns0:PV_ASSET_TYPE) = "AHO") then (
        	<ns1:consultaActivosClienteResponse>
	            <ns1:consultaActivosClienteAhorrosResponseType>
	            	{
                        for $PV_ERROR_CODE in $outputParameters1/ns0:PV_ERROR_CODE
                        return
                            <SUCCESS_INDICATOR>{ mensajeRespuesta(data($PV_ERROR_CODE), $outputParameters1/ns0:PV_ASSET_TYPE[text() = 'AHO']) }</SUCCESS_INDICATOR>
                    }
	                {
	                	let $assetType := $outputParameters1/ns0:PV_ASSET_TYPE
	                	let $assetNumber := $outputParameters1/ns0:PV_ASSET_NUMBER/ns0:PV_ASSET_NUMBER_ITEM
						let $assetName := $outputParameters1/ns0:PV_ASSET_NAME/ns0:PV_ASSET_NAME_ITEM
						let $assetCurrency := $outputParameters1/ns0:PV_ASSET_CURRENCY/ns0:PV_ASSET_NUMBER_ITEM
						let $assetTotalBalance := $outputParameters1/ns0:PV_ASSET_TOTAL_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetReserveBalance := $outputParameters1/ns0:PV_ASSET_RESERVE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetLockedBalance := $outputParameters1/ns0:PV_ASSET_LOCKED_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetVisaFloatingBalance := $outputParameters1/ns0:PV_ASSET_VISA_FLOATING_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetAvailableBalance := $outputParameters1/ns0:PV_ASSET_AVAILABLE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetProductType := $outputParameters1/ns0:PV_ASSET_PRODUCT_TYPE/ns0:PV_ASSET_NUMBER_ITEM
						
						for $i in (1 to count($assetNumber))
						return
		                <ns1:consultaActivosClienteResponseRecordType>
								<ASSET_TYPE>{ data($assetType) }</ASSET_TYPE>
		                    	<ASSET_NUMBER>{ data($assetNumber[$i]) }</ASSET_NUMBER>
		                        <ASSET_NAME>{ data($assetName[$i]) }</ASSET_NAME>
		                        <ASSET_CURRENCY>{ data($assetCurrency[$i]) }</ASSET_CURRENCY>
		                        <ASSET_TOTAL_BALANCE>{ data($assetTotalBalance[$i]) }</ASSET_TOTAL_BALANCE>
		                        <ASSET_RESERVE_BALANCE>{ data($assetReserveBalance[$i]) }</ASSET_RESERVE_BALANCE>
		                        <ASSET_LOCKED_BALANCE>{ data($assetLockedBalance[$i]) }</ASSET_LOCKED_BALANCE>
		                        <ASSET_VISA_FLOATING_BALANCE>{ data($assetVisaFloatingBalance[$i]) }</ASSET_VISA_FLOATING_BALANCE>
		                        <ASSET_AVAILABLE_BALANCE>{ data($assetAvailableBalance[$i]) }</ASSET_AVAILABLE_BALANCE>
		                		<ASSET_SOURCE_BANK>GT01</ASSET_SOURCE_BANK>
		                		<ASSET_PRODUCT_TYPE>{ data($assetProductType[$i]) }</ASSET_PRODUCT_TYPE>
		                </ns1:consultaActivosClienteResponseRecordType>
	            }
	            </ns1:consultaActivosClienteAhorrosResponseType>
	            <ns1:consultaActivosClienteCorrienteResponseType/>
	            <ns1:consultaActivosClienteDepositosResponseType/>
	        </ns1:consultaActivosClienteResponse>
	    ) else (
	    	if (fn:string($outputParameters1/ns0:PV_ASSET_TYPE) = "CHQ") then (
		    	<ns1:consultaActivosClienteResponse>
		    		<ns1:consultaActivosClienteCorrienteResponseType>
		    		{
                        for $PV_ERROR_CODE in $outputParameters1/ns0:PV_ERROR_CODE
                        return
                            <SUCCESS_INDICATOR>{ mensajeRespuesta(data($PV_ERROR_CODE), $outputParameters1/ns0:PV_ASSET_TYPE[text() = 'CHQ']) }</SUCCESS_INDICATOR>
                    }
		    		{
	                	let $assetType := $outputParameters1/ns0:PV_ASSET_TYPE
	                	let $assetNumber := $outputParameters1/ns0:PV_ASSET_NUMBER/ns0:PV_ASSET_NUMBER_ITEM
						let $assetName := $outputParameters1/ns0:PV_ASSET_NAME/ns0:PV_ASSET_NAME_ITEM
						let $assetCurrency := $outputParameters1/ns0:PV_ASSET_CURRENCY/ns0:PV_ASSET_NUMBER_ITEM
						let $assetTotalBalance := $outputParameters1/ns0:PV_ASSET_TOTAL_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetReserveBalance := $outputParameters1/ns0:PV_ASSET_RESERVE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetLockedBalance := $outputParameters1/ns0:PV_ASSET_LOCKED_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetVisaFloatingBalance := $outputParameters1/ns0:PV_ASSET_VISA_FLOATING_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetAvailableBalance := $outputParameters1/ns0:PV_ASSET_AVAILABLE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
						let $assetProductType := $outputParameters1/ns0:PV_ASSET_PRODUCT_TYPE/ns0:PV_ASSET_NUMBER_ITEM
						
						for $i in (1 to count($assetNumber))
						return
		    			<ns1:consultaActivosClienteResponseRecordType>
		    				<ASSET_TYPE>{ data($assetType) }</ASSET_TYPE>
	                    	<ASSET_NUMBER>{ data($assetNumber[$i]) }</ASSET_NUMBER>
	                        <ASSET_NAME>{ data($assetName[$i]) }</ASSET_NAME>
	                        <ASSET_CURRENCY>{ data($assetCurrency[$i]) }</ASSET_CURRENCY>
	                        <ASSET_TOTAL_BALANCE>{ data($assetTotalBalance[$i]) }</ASSET_TOTAL_BALANCE>
	                        <ASSET_RESERVE_BALANCE>{ data($assetReserveBalance[$i]) }</ASSET_RESERVE_BALANCE>
	                        <ASSET_LOCKED_BALANCE>{ data($assetLockedBalance[$i]) }</ASSET_LOCKED_BALANCE>
	                        <ASSET_VISA_FLOATING_BALANCE>{ data($assetVisaFloatingBalance[$i]) }</ASSET_VISA_FLOATING_BALANCE>
	                        <ASSET_AVAILABLE_BALANCE>{ data($assetAvailableBalance[$i]) }</ASSET_AVAILABLE_BALANCE>
	                        <ASSET_SOURCE_BANK>GT01</ASSET_SOURCE_BANK>
	                        <ASSET_PRODUCT_TYPE>{ data($assetProductType[$i]) }</ASSET_PRODUCT_TYPE>
		    			</ns1:consultaActivosClienteResponseRecordType>
		            }
		            </ns1:consultaActivosClienteCorrienteResponseType>
		            <ns1:consultaActivosClienteAhorrosResponseType/>
	            	<ns1:consultaActivosClienteDepositosResponseType/>
		    	</ns1:consultaActivosClienteResponse>
	    	) 
	    	else (
	    		if (fn:string($outputParameters1/ns0:PV_ASSET_TYPE) = "CTA") then (
					<ns1:consultaActivosClienteResponse>
						<ns1:consultaActivosClienteAhorrosResponseType>
							{
		                        for $PV_ERROR_CODE in $outputParameters1/ns0:PV_ERROR_CODE
		                        return
		                            <SUCCESS_INDICATOR>{ mensajeRespuesta(data($PV_ERROR_CODE), $outputParameters1/ns0:PV_ASSET_TYPE_OUT/ns0:PV_ASSET_NUMBER_ITEM[text() = 'AHO']) }</SUCCESS_INDICATOR>
		                    }
			                {
			                	let $assetType := $outputParameters1/ns0:PV_ASSET_TYPE
			                	let $assetTypeOut := $outputParameters1/ns0:PV_ASSET_TYPE_OUT/ns0:PV_ASSET_NUMBER_ITEM
			                	let $assetNumber := $outputParameters1/ns0:PV_ASSET_NUMBER/ns0:PV_ASSET_NUMBER_ITEM
								let $assetName := $outputParameters1/ns0:PV_ASSET_NAME/ns0:PV_ASSET_NAME_ITEM
								let $assetCurrency := $outputParameters1/ns0:PV_ASSET_CURRENCY/ns0:PV_ASSET_NUMBER_ITEM
								let $assetTotalBalance := $outputParameters1/ns0:PV_ASSET_TOTAL_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetReserveBalance := $outputParameters1/ns0:PV_ASSET_RESERVE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetLockedBalance := $outputParameters1/ns0:PV_ASSET_LOCKED_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetVisaFloatingBalance := $outputParameters1/ns0:PV_ASSET_VISA_FLOATING_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetAvailableBalance := $outputParameters1/ns0:PV_ASSET_AVAILABLE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetProductType := $outputParameters1/ns0:PV_ASSET_PRODUCT_TYPE/ns0:PV_ASSET_NUMBER_ITEM
								
								for $i in (1 to count($assetNumber))
								return
									if (fn:string($assetTypeOut[$i]) = "AHO") then (
				                <ns1:consultaActivosClienteResponseRecordType>
										<ASSET_TYPE>{ data($assetTypeOut[$i]) }</ASSET_TYPE>
				                    	<ASSET_NUMBER>{ data($assetNumber[$i]) }</ASSET_NUMBER>
				                        <ASSET_NAME>{ data($assetName[$i]) }</ASSET_NAME>
				                        <ASSET_CURRENCY>{ data($assetCurrency[$i]) }</ASSET_CURRENCY>
				                        <ASSET_TOTAL_BALANCE>{ data($assetTotalBalance[$i]) }</ASSET_TOTAL_BALANCE>
				                        <ASSET_RESERVE_BALANCE>{ data($assetReserveBalance[$i]) }</ASSET_RESERVE_BALANCE>
				                        <ASSET_LOCKED_BALANCE>{ data($assetLockedBalance[$i]) }</ASSET_LOCKED_BALANCE>
				                        <ASSET_VISA_FLOATING_BALANCE>{ data($assetVisaFloatingBalance[$i]) }</ASSET_VISA_FLOATING_BALANCE>
				                        <ASSET_AVAILABLE_BALANCE>{ data($assetAvailableBalance[$i]) }</ASSET_AVAILABLE_BALANCE>
				                        <ASSET_SOURCE_BANK>GT01</ASSET_SOURCE_BANK>
				                        <ASSET_PRODUCT_TYPE>{ data($assetProductType[$i]) }</ASSET_PRODUCT_TYPE>
				                </ns1:consultaActivosClienteResponseRecordType>
				                ) else (
				                
				                )
			            	}
			            	</ns1:consultaActivosClienteAhorrosResponseType>
							<ns1:consultaActivosClienteCorrienteResponseType>
							{
		                        for $PV_ERROR_CODE in $outputParameters1/ns0:PV_ERROR_CODE
		                        return
		                            <SUCCESS_INDICATOR>{ mensajeRespuesta(data($PV_ERROR_CODE), $outputParameters1/ns0:PV_ASSET_TYPE_OUT/ns0:PV_ASSET_NUMBER_ITEM[text() = 'CHQ']) }</SUCCESS_INDICATOR>
		                    }
				    		{
			                	let $assetType := $outputParameters1/ns0:PV_ASSET_TYPE
			                	let $assetTypeOut := $outputParameters1/ns0:PV_ASSET_TYPE_OUT/ns0:PV_ASSET_NUMBER_ITEM
			                	let $assetNumber := $outputParameters1/ns0:PV_ASSET_NUMBER/ns0:PV_ASSET_NUMBER_ITEM
								let $assetName := $outputParameters1/ns0:PV_ASSET_NAME/ns0:PV_ASSET_NAME_ITEM
								let $assetCurrency := $outputParameters1/ns0:PV_ASSET_CURRENCY/ns0:PV_ASSET_NUMBER_ITEM
								let $assetTotalBalance := $outputParameters1/ns0:PV_ASSET_TOTAL_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetReserveBalance := $outputParameters1/ns0:PV_ASSET_RESERVE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetLockedBalance := $outputParameters1/ns0:PV_ASSET_LOCKED_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetVisaFloatingBalance := $outputParameters1/ns0:PV_ASSET_VISA_FLOATING_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetAvailableBalance := $outputParameters1/ns0:PV_ASSET_AVAILABLE_BALANCE/ns0:PV_ASSET_NUMBER_ITEM
								let $assetProductType := $outputParameters1/ns0:PV_ASSET_PRODUCT_TYPE/ns0:PV_ASSET_NUMBER_ITEM
								
								for $i in (1 to count($assetNumber))
								return
									if (fn:string($assetTypeOut[$i]) = "CHQ") then (
					    			<ns1:consultaActivosClienteResponseRecordType>
					    				<ASSET_TYPE>{ data($assetTypeOut[$i]) }</ASSET_TYPE>
				                    	<ASSET_NUMBER>{ data($assetNumber[$i]) }</ASSET_NUMBER>
				                        <ASSET_NAME>{ data($assetName[$i]) }</ASSET_NAME>
				                        <ASSET_CURRENCY>{ data($assetCurrency[$i]) }</ASSET_CURRENCY>
				                        <ASSET_TOTAL_BALANCE>{ data($assetTotalBalance[$i]) }</ASSET_TOTAL_BALANCE>
				                        <ASSET_RESERVE_BALANCE>{ data($assetReserveBalance[$i]) }</ASSET_RESERVE_BALANCE>
				                        <ASSET_LOCKED_BALANCE>{ data($assetLockedBalance[$i]) }</ASSET_LOCKED_BALANCE>
				                        <ASSET_VISA_FLOATING_BALANCE>{ data($assetVisaFloatingBalance[$i]) }</ASSET_VISA_FLOATING_BALANCE>
				                        <ASSET_AVAILABLE_BALANCE>{ data($assetAvailableBalance[$i]) }</ASSET_AVAILABLE_BALANCE>
				                        <ASSET_SOURCE_BANK>GT01</ASSET_SOURCE_BANK>
				                        <ASSET_PRODUCT_TYPE>{ data($assetProductType[$i]) }</ASSET_PRODUCT_TYPE>
					    			</ns1:consultaActivosClienteResponseRecordType>
					    			) else (
					    			
					    			)
				            }
			            </ns1:consultaActivosClienteCorrienteResponseType>
						<ns1:consultaActivosClienteDepositosResponseType/>
					</ns1:consultaActivosClienteResponse>
	    		) else (
	    			<ns1:consultaActivosClienteResponse>
	    				<ns1:consultaActivosClienteAhorrosResponseType/>
	    				<ns1:consultaActivosClienteCorrienteResponseType/>
						<ns1:consultaActivosClienteDepositosResponseType/>
	    			</ns1:consultaActivosClienteResponse>
	    		)
	    	)
	    )
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaListaCuentasGTOut1($outputParameters1)