(:: pragma bea:local-element-parameter parameter="$consultarXmlAutorizacionesResult1" type="ns1:ConsultarXmlAutorizacionesResponse/ns1:ConsultarXmlAutorizacionesResult" location="../../../BusinessServices/VASA/consultarFlotantesTC/wsdl/WSConsultas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosFlotantesTCResponse" location="../xsd/consultaMovimientosFlotantesTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosFlotantesTCTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosFlotantesTC/xq/consultaMovsFlotantesTCOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "monedaLocal") then "HNL"
	else if ($codigoMoneda = "dolares") then "USD" 
	else( "" )

};

declare function local:converAmount($pMonto as xs:string?) as xs:double
{
		let $sMonto := translate(translate($pMonto,'.',''),",",".")
		
		return 
			number($sMonto)
		
};

declare function xf:consultaMovimientosFlotantesTCOut($consultarXmlAutorizacionesResult1 as element(ns1:ConsultarXmlAutorizacionesResponse))
    as element(ns0:consultaMovimientosFlotantesTCResponse) {
        <ns0:consultaMovimientosFlotantesTCResponse>
        	<OWNER_NAME>
        		{
        			data($consultarXmlAutorizacionesResult1//datos/titular/text())
        		}
        	</OWNER_NAME>
        	<PRINCIPAL_CARD_NUMBER>
        		{
        			data($consultarXmlAutorizacionesResult1//datos/tarjetaActiva/text())
        		}
        	</PRINCIPAL_CARD_NUMBER>
        	<TOTAL_LCY_AMOUNT>
        		{
        			local:converAmount(data($consultarXmlAutorizacionesResult1//autorizaciones/totales/monedaLocal/text()))
        		}
        	</TOTAL_LCY_AMOUNT>
            <TOTAL_USD_AMOUNT>
            	{
            		local:converAmount(data($consultarXmlAutorizacionesResult1//autorizaciones/totales/dolares/text()))
            	}
            </TOTAL_USD_AMOUNT>
            {
             	for $tagTarjetas in $consultarXmlAutorizacionesResult1//autorizaciones
            	return
					<CARDS>
					{
					 	for $aTarjetas in $tagTarjetas/tarjeta
						return
					        <CARD_DETAILS>
					        	<CARD_NUMBER>{translate(data($aTarjetas/codigoTarjeta/text())," ","-")}</CARD_NUMBER>
					        	<LCY_AMOUNT>{local:converAmount(data($aTarjetas/monedaLocal/text()))}</LCY_AMOUNT>
					        	<USD_AMOUNT>{local:converAmount(data($aTarjetas/dolares/text()))}</USD_AMOUNT>
					        	{
					             	for $tagMovimientos in $tagTarjetas/tarjeta
					            	return			            	
						            	<MOVEMENTS>
						            	{
								             	for $aFlotantes in $tagMovimientos/autorizacion
								            	return
									                <FLOATING_MOVEMENT>
														<MCC_CODE>{data($aFlotantes/codigo/text())}</MCC_CODE>
									                    <MCC_DESCRIPTION>{data($aFlotantes/establecimiento/text())}</MCC_DESCRIPTION>
									                    <DESCRIPTION>{data($aFlotantes/descripcion/text())}</DESCRIPTION>
									                    <DATE>
										                    {   
										                    	xs:date(concat(
											                    	substring(data($aFlotantes/fecha/text()),7,4),'-',
											                    	substring(data($aFlotantes/fecha/text()),4,2),'-',
											                    	substring(data($aFlotantes/fecha/text()),1,2)
											                    ))
										                    }
									                    </DATE>
									                    <TIME>
									                    	{
									                    		xs:time(concat(
										                    		substring(data($aFlotantes/hora/text()),1,2),":",
										                    		substring(data($aFlotantes/hora/text()),3,2),":",
										                    		substring(data($aFlotantes/hora/text()),5,2)
										                    		))
										                    }
										                 </TIME>
									                    <AMOUNT>
									                    	{
									                    		local:converAmount(data($aFlotantes/importe/text()))
									                    	}
									                    </AMOUNT>
									                    <CURRENCY>
									                    	{
									                    		local:getMoneda(data($aFlotantes/moneda/text()))
									                    	}
									                    </CURRENCY>
									                    
									                    
									                    
									                    <FEE>{data($aFlotantes/cuotas/text())}</FEE>
									                    <PAYMENT_METHOD>{data($aFlotantes/medioDePago/text())}</PAYMENT_METHOD>
									                </FLOATING_MOVEMENT>
						                }
						                </MOVEMENTS>
								}
					        </CARD_DETAILS>
					    }
					</CARDS>
		    }
        </ns0:consultaMovimientosFlotantesTCResponse>
};

declare variable $consultarXmlAutorizacionesResult1 as element(ns1:ConsultarXmlAutorizacionesResponse) external;

xf:consultaMovimientosFlotantesTCOut($consultarXmlAutorizacionesResult1)