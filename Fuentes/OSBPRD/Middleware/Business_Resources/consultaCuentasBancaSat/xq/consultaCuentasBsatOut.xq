xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetaCreditoTypeResponse1" element="ns2:ConsultaTarjetaCreditoTypeResponse" location="../../consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../v2/BusinessServices/ABKGT/consultaListaCuentas/xsd/consultaListaCuentas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCuentasBSatResponse" location="../xsd/consultaCuentasBSatTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCuentasBancaSat/xq/consultaCuentasBsatOut1/";
declare namespace ns2 = "ConsultaTarjetaCreditoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasBSatTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";

declare function xf:consultaCuentasBsatOut1($consultaTarjetaCreditoTypeResponse1 as element(ns2:ConsultaTarjetaCreditoTypeResponse),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaCuentasBSatResponse) {
       <ns1:consultaCuentasBSatResponse>
			<ns1:consultaCuentasBSatAhorrosResponseType>
                {
                	let $assetTypeOut := $outputParameters1/ns0:PV_ASSET_TYPE_OUT/ns0:PV_ASSET_NUMBER_ITEM
                	let $assetNumber := $outputParameters1/ns0:PV_ASSET_NUMBER/ns0:PV_ASSET_NUMBER_ITEM
                	let $assetCurrency := $outputParameters1/ns0:PV_ASSET_CURRENCY/ns0:PV_ASSET_NUMBER_ITEM
                						
					for $i in (1 to count($assetNumber))
					return
						if (fn:string($assetTypeOut[$i]) = "AHO" and fn:string($assetCurrency[$i]) = "GTQ") then (
			                <ns1:consultaCuentasBSatResponseRecordType>
			                    	<ASSET_NUMBER>{ data($assetNumber[$i]) }</ASSET_NUMBER>
			                </ns1:consultaCuentasBSatResponseRecordType>
	                ) else (
	                
	                )
            	}
            </ns1:consultaCuentasBSatAhorrosResponseType>
			<ns1:consultaCuentasBSatCorrienteResponseType>
	    		{
                	
                	let $assetTypeOut := $outputParameters1/ns0:PV_ASSET_TYPE_OUT/ns0:PV_ASSET_NUMBER_ITEM
                	let $assetNumber := $outputParameters1/ns0:PV_ASSET_NUMBER/ns0:PV_ASSET_NUMBER_ITEM
                	let $assetCurrency := $outputParameters1/ns0:PV_ASSET_CURRENCY/ns0:PV_ASSET_NUMBER_ITEM
													
					for $i in (1 to count($assetNumber))
					return
						if (fn:string($assetTypeOut[$i]) = "CHQ" and fn:string($assetCurrency[$i]) = "GTQ") then (
			    			<ns1:consultaCuentasBSatResponseRecordType>
		                    	<ASSET_NUMBER>{ data($assetNumber[$i]) }</ASSET_NUMBER>
			    			</ns1:consultaCuentasBSatResponseRecordType>
		    			) else (
		    			
		    			)
	            }
            </ns1:consultaCuentasBSatCorrienteResponseType>
            <ns1:consultaTarjetasCreditoBSatResponseType>
	    		{
                 if (fn:string($consultaTarjetaCreditoTypeResponse1/ns2:OVERALL_SUCCESS_INDICATOR/text()) = "SUCCESS") then (	
                	 let $contadorDetalle:= count($consultaTarjetaCreditoTypeResponse1/ns2:CREDIT_CARD_DETAILS/ns2:CREDIT_CARD_DETAIL) 
                     let $contadorMonedas:= count($consultaTarjetaCreditoTypeResponse1/ns2:CREDIT_CARD_DETAILS/ns2:CREDIT_CARD_DETAIL/ns2:RESPONSE_BODY/ns2:BALANCE_DETAILS/ns2:BALANCE_DETAIL/ns2:CURRENCY)      
                	 for $d in (1 to $contadorDetalle)      
						    for $m in (1 to $contadorMonedas)
			            	   let $moneda := fn:string($consultaTarjetaCreditoTypeResponse1/ns2:CREDIT_CARD_DETAILS/ns2:CREDIT_CARD_DETAIL[$d]/ns2:RESPONSE_BODY/ns2:BALANCE_DETAILS/ns2:BALANCE_DETAIL[$m]/ns2:CURRENCY/text())
					           let $numeroTarjeta:=fn:string($consultaTarjetaCreditoTypeResponse1/ns2:CREDIT_CARD_DETAILS/ns2:CREDIT_CARD_DETAIL[$d]/ns2:RESPONSE_BODY/ns2:CARD_NUMBER/text())
					    return
						if (fn:string($moneda) = "GTQ") then (
			    			<ns1:consultaTarjetaBSatResponseRecordType>
		                         	     <LIABILITY_NUMBER>{data($numeroTarjeta)}</LIABILITY_NUMBER>
			    			</ns1:consultaTarjetaBSatResponseRecordType>
		    			) else (
		    			
		    			)
	                   )
	              else(
	                   )
	               }
	         </ns1:consultaTarjetasCreditoBSatResponseType>
		</ns1:consultaCuentasBSatResponse>
};

declare variable $consultaTarjetaCreditoTypeResponse1 as element(ns2:ConsultaTarjetaCreditoTypeResponse) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaCuentasBsatOut1($consultaTarjetaCreditoTypeResponse1,
    $outputParameters1)