(:: pragma bea:global-element-parameter parameter="$sjconsultaDatosTarjetaCreditoResponse" element="ns4:sjconsultaDatosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/consultaDatosTarjetaCredito/xsd/sjconsultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$datosCuenta" element="ns2:OutputParameters" location="../../../../v2/BusinessServices/MasterData/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns3:OutputParameters/ns3:PT_EQUIVALENCIAS" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/registroDatosTC/xsd/registroDatosTC_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaDatosTarjetaCreditoTypes";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroDatosTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xq/registraDatosTCNIIn/";

declare function valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns3:EQUIVALENCIA[ns3:CATALOGO_ID = $catalogoId and 
															  ns3:APLICACION_DESC = $aplicacion and 
															  ns3:EQUIVALENCIA_DESC = $valor]/ns3:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:registraDatosTCNIIn($sjconsultaDatosTarjetaCreditoResponse as element(ns4:sjconsultaDatosTarjetaCreditoResponse),
    $datosCuenta as element(ns2:OutputParameters),
    $ptEquivalencias as element(),
     $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_DATOS_TARJETA>
            {
            	for  $row in $datosCuenta/ns2:RowSet/ns2:Row
            	let $org := data($row/ns2:Column[@name = 'org'])
            	let $embosserInquiry := $sjconsultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[ORG = $org]
            	return(
	                <ns0:PT_DATOS_TARJETA_ITEM>
	                    <ns0:CARD_NUMBER>{ data($row/ns2:Column[@name = 'numtarjeta']) }</ns0:CARD_NUMBER>
	                   	<ns0:DUAL_INDICATOR>{ data($sjconsultaDatosTarjetaCreditoResponse/DUAL_INDICATOR) }</ns0:DUAL_INDICATOR>
    					<ns0:ACCOUNT_NUMBER>{ data($sjconsultaDatosTarjetaCreditoResponse/ACCOUNT_NUMBER) }</ns0:ACCOUNT_NUMBER>
    					<ns0:CARD_HOLDER_NAME>{ data($sjconsultaDatosTarjetaCreditoResponse/CARD_HOLDER_NAME) }</ns0:CARD_HOLDER_NAME>
    					<ns0:ACCOUNT_HOLDER_NAME>{ data($row/ns2:Column[@name = 'account_name']) }</ns0:ACCOUNT_HOLDER_NAME>
    					<ns0:CARD_HOLDER_LEGAL_ID>{ data($row/ns2:Column[@name = 'card_holder_id']) }</ns0:CARD_HOLDER_LEGAL_ID>
		    			<ns0:ACCOUNT_HOLDER_LEGAL_ID>{ data($row/ns2:Column[@name = 'account_holder_legal_id']) }</ns0:ACCOUNT_HOLDER_LEGAL_ID>
		    			<ns0:CUSTOMER_ID>{ data($row/ns2:Column[@name = 'customer_id']) }</ns0:CUSTOMER_ID>
		    			<ns0:ACCOUNT_STATUS>{ data($row/ns2:Column[@name = 'estatus']) }</ns0:ACCOUNT_STATUS>
						{
							let $cardType := $sjconsultaDatosTarjetaCreditoResponse/CARD_TYPE
							return(
								<ns0:CARD_TYPE>
								{
								 	valorCatalogoAPPToOSB(string($cardType/text()), 'VISION+', '6', $ptEquivalencias)
								}
								</ns0:CARD_TYPE>
							)
						}
		    			<ns0:AFINITY_GROUP>{ data($row/ns2:Column[@name = 'logo']) }</ns0:AFINITY_GROUP>
    					<ns0:ORG_IND>{ data($row/ns2:Column[@name = 'TipoOrg']) }</ns0:ORG_IND>
    					{
    						if(string($org) != '') then (
    							<ns0:ORG>{ $org }</ns0:ORG>
    						) else()
    					}
    					<ns0:CURRENCY>{ data($row/ns2:Column[@name = 'CodMoneda']) }</ns0:CURRENCY>
    					<ns0:ANUAL_PURCHASE_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_RTL_YTD_AMT']) }</ns0:ANUAL_PURCHASE_LIMIT>
    					<ns0:ANUAL_WITHDRAWAL_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_CSH_YTD_AMT']) }</ns0:ANUAL_WITHDRAWAL_LIMIT>
    					<ns0:MONTHLY_PURCHASE_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_RTL_MTD_AMT']) }</ns0:MONTHLY_PURCHASE_LIMIT>
    					<ns0:MONTHLY_WITHDRAWAL_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_CSH_MTD_AMT']) }</ns0:MONTHLY_WITHDRAWAL_LIMIT>
    					{
    						let $dailyPurchaseLimit:= string($row/ns2:Column[@name = 'AMED_SL_RTL_DLY_AMT']/text())
    						return
    						if(fn-bea:trim($dailyPurchaseLimit) != "") then (
    							<ns0:DAILY_PURCHASE_LIMIT>{ $dailyPurchaseLimit }</ns0:DAILY_PURCHASE_LIMIT>
    						)else()
    					}
    					{
    						let $dailyWithDrawalLimit:= string($row/ns2:Column[@name = 'AMED_SL_CSH_DLY_AMT']/text())
    						return
    						if(fn-bea:trim($dailyWithDrawalLimit) != "") then (
    							<ns0:DAILY_WITHDRAWAL_LIMIT>{ $dailyWithDrawalLimit }</ns0:DAILY_WITHDRAWAL_LIMIT>
    						)else()
    					}
    					{
    						let $cardActivationDate:= string($embosserInquiry/CARD_ACTIVATION_DATE/text())
    						return
    						if(fn-bea:trim($cardActivationDate) != "") then (
    							<ns0:CARD_ACTIVATION_DATE>{ $cardActivationDate }</ns0:CARD_ACTIVATION_DATE>
    						)else()
    					}
    					{
    						let $cardStatus:= $embosserInquiry/CARD_STATUS
				 			return
				 				<ns0:CARD_STATUS>
				 				{
				 					valorCatalogoAPPToOSB(string($cardStatus/text()), 'VISION+', '13', $ptEquivalencias)
				 				}
				 				</ns0:CARD_STATUS>
    					}
    					<ns0:CARD_EXPIRATION_DATE>{ data($embosserInquiry/CARD_EXPIRATION_DATE) }</ns0:CARD_EXPIRATION_DATE>
    					<ns0:EMBOSSED_NUMBER>{ data($embosserInquiry/EMBOSSED_NUMBER) }</ns0:EMBOSSED_NUMBER>
						<ns0:BLOCK_CODE>{ data($embosserInquiry/BLOCK_CODE) }</ns0:BLOCK_CODE>
						<ns0:BLOCK_REASON>{ data($embosserInquiry/BLOCK_REASON) }</ns0:BLOCK_REASON>
						<ns0:BLOCK_DATE>{ data($embosserInquiry/BLOCK_DATE) }</ns0:BLOCK_DATE>
    					<ns0:PRODUCT>TCR</ns0:PRODUCT>
    					<ns0:USER_CODE>{ data($row/ns2:Column[@name = 'cod_user4']) }</ns0:USER_CODE>
	           </ns0:PT_DATOS_TARJETA_ITEM>
	            )
	        }
            </ns0:PT_DATOS_TARJETA>
             <ns0:PV_COUNTRY_CODE>{ $countryCode }</ns0:PV_COUNTRY_CODE>
        </ns0:InputParameters>
};

declare variable $sjconsultaDatosTarjetaCreditoResponse as element(ns4:sjconsultaDatosTarjetaCreditoResponse) external;
declare variable $datosCuenta as element(ns2:OutputParameters) external;
declare variable $ptEquivalencias as element() external;
declare variable $countryCode as xs:string external;

xf:registraDatosTCNIIn($sjconsultaDatosTarjetaCreditoResponse,
    $datosCuenta,
    $ptEquivalencias,
    $countryCode)