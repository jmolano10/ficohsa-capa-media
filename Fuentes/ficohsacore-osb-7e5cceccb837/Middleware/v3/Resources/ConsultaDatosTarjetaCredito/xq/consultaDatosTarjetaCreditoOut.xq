(:: pragma bea:global-element-parameter parameter="$sjconsultaDatosTarjetaCreditoResponse" element="ns6:sjconsultaDatosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/consultaDatosTarjetaCredito/xsd/sjconsultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$datosCuenta" element="ns2:OutputParameters" location="../../../../v2/BusinessServices/MasterData/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns3:OutputParameters/ns3:PT_EQUIVALENCIAS" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns5:OutputParameters" location="../../../BusinessServices/consultaDatosTC/xsd/consultaDatosTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCreditoResponse" location="../xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaDatosTarjetaCreditoTypes";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns5 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoOut/";
declare namespace ns6 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaDatosTarjetaCreditoTypes";

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

declare function xf:consultaDatosTarjetaCreditoOut($sjconsultaDatosTarjetaCreditoResponse as element(ns6:sjconsultaDatosTarjetaCreditoResponse),
    $datosCuenta as element(ns2:OutputParameters),
    $ptEquivalencias as element(),
    $outputParameters1 as element(ns5:OutputParameters)?)
    as element(ns0:consultaDatosTarjetaCreditoResponse) {
        <ns0:consultaDatosTarjetaCreditoResponse>
        {
        	if(not(empty($outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM))) then (
           		for $CARD_NUMBER in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_NUMBER
                return
                <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>,

                for $DUAL_INDICATOR in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:DUAL_INDICATOR
                return
                    <DUAL_INDICATOR>{ data($DUAL_INDICATOR) }</DUAL_INDICATOR>,

                for $ACCOUNT_NUMBER in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>,

                for $CARD_HOLDER_NAME in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_NAME
                return
                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>,

                for $ACCOUNT_HOLDER_NAME in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_NAME
                return
                    <ACCOUNT_HOLDER_NAME>{ data($ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>,

                for $CARD_HOLDER_LEGAL_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_LEGAL_ID
                return
                    <CARD_HOLDER_LEGAL_ID>{ data($CARD_HOLDER_LEGAL_ID) }</CARD_HOLDER_LEGAL_ID>,

                for $ACCOUNT_HOLDER_LEGAL_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_LEGAL_ID
                return
                    <ACCOUNT_HOLDER_LEGAL_ID>{ data($ACCOUNT_HOLDER_LEGAL_ID) }</ACCOUNT_HOLDER_LEGAL_ID>,

                for $CUSTOMER_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>,

                for $ACCOUNT_STATUS in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_STATUS
                return
                    <ACCOUNT_STATUS>{ data($ACCOUNT_STATUS) }</ACCOUNT_STATUS>,

                for $CARD_TYPE in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_TYPE
                return
                    <CARD_TYPE>{ data($CARD_TYPE) }</CARD_TYPE>,

                for $AFINITY_GROUP in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:AFINITY_GROUP
                return
					<AFINITY_GROUP>{data($AFINITY_GROUP)}</AFINITY_GROUP>,
                for $PT_DATOS_TARJETA_ITEM in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM
                return(
                    <CARD_CURRENCY_INFORMATION>
                        <ORG_IND>{ data($PT_DATOS_TARJETA_ITEM/ns5:ORG_IND) }</ORG_IND>
                        <ORG>{ data($PT_DATOS_TARJETA_ITEM/ns5:ORG) }</ORG>
                        <CURRENCY>{ data($PT_DATOS_TARJETA_ITEM/ns5:CURRENCY) }</CURRENCY>
                        <ANUAL_PURCHASE_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANUAL_PURCHASE_LIMIT) }</ANUAL_PURCHASE_LIMIT>
                        <ANUAL_WITHDRAWAL_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANUAL_WITHDRAWAL_LIMIT) }</ANUAL_WITHDRAWAL_LIMIT>
                        <MONTHLY_PURCHASE_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_PURCHASE_LIMIT) }</MONTHLY_PURCHASE_LIMIT>
                        <MONTHLY_WITHDRAWAL_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_WITHDRAWAL_LIMIT) }</MONTHLY_WITHDRAWAL_LIMIT>
                        <DAILY_PURCHASE_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_PURCHASE_LIMIT) }</DAILY_PURCHASE_LIMIT>
                        <DAILY_WITHDRAWAL_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_WITHDRAWAL_LIMIT) }</DAILY_WITHDRAWAL_LIMIT>
                        {
	                       	 if(data($PT_DATOS_TARJETA_ITEM/ns5:CARD_ACTIVATION_DATE/text()) != '')then(
	            				<CARD_ACTIVATION_DATE>{  fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($PT_DATOS_TARJETA_ITEM/ns5:CARD_ACTIVATION_DATE)) }</CARD_ACTIVATION_DATE>
	          				 )else()
          				}
                        <CARD_STATUS>{ data($PT_DATOS_TARJETA_ITEM/ns5:CARD_STATUS) }</CARD_STATUS>
                        <CARD_EXPIRATION_DATE>{  data($PT_DATOS_TARJETA_ITEM/ns5:CARD_EXPIRATION_DATE) }</CARD_EXPIRATION_DATE>
	          				
                        <EMBOSSED_NUMBER>{ data($PT_DATOS_TARJETA_ITEM/ns5:EMBOSSED_NUMBER) }</EMBOSSED_NUMBER>
                        <BLOCK_CODE>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_CODE) }</BLOCK_CODE>
                        <BLOCK_REASON>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_REASON) }</BLOCK_REASON>
                        <BLOCK_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_DATE) }</BLOCK_DATE>
                        <PRODUCT>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</PRODUCT>
                    </CARD_CURRENCY_INFORMATION>
                  )
               )else(
               			
               		    <ns0:CARD_NUMBER>{ data($datosCuenta/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'numtarjeta']) }</ns0:CARD_NUMBER>,
	                   	<ns0:DUAL_INDICATOR>{ data($sjconsultaDatosTarjetaCreditoResponse/DUAL_INDICATOR) }</ns0:DUAL_INDICATOR>,
    					<ACCOUNT_NUMBER>{ data($sjconsultaDatosTarjetaCreditoResponse/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>,
    					<CARD_HOLDER_NAME>{ data($sjconsultaDatosTarjetaCreditoResponse/CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>,
    					<ACCOUNT_HOLDER_NAME>{ data($datosCuenta/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'account_name']) }</ACCOUNT_HOLDER_NAME>,
    					<CARD_HOLDER_LEGAL_ID>{ data($datosCuenta/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'card_holder_id']) }</CARD_HOLDER_LEGAL_ID>,
		    			<ACCOUNT_HOLDER_LEGAL_ID>{ data($datosCuenta/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'account_holder_legal_id']) }</ACCOUNT_HOLDER_LEGAL_ID>,
		    			<CUSTOMER_ID>{ data($datosCuenta/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'customer_id']) }</CUSTOMER_ID>,
		    			<ACCOUNT_STATUS>{ data($datosCuenta/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'estatus']) }</ACCOUNT_STATUS>,
						<CARD_TYPE>{ valorCatalogoAPPToOSB(string($sjconsultaDatosTarjetaCreditoResponse/CARD_TYPE/text()), 'VISION+', '6', $ptEquivalencias) }</CARD_TYPE>,
		    			<AFINITY_GROUP>{ data($datosCuenta/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'logo']) }</AFINITY_GROUP>,
	    				
	    				for  $row in $datosCuenta/ns2:RowSet/ns2:Row
		            	let $org := data($row/ns2:Column[@name = 'org'])
		            	let $embosserInquiry := $sjconsultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[ORG = $org]
		            	return(
		            		<CARD_CURRENCY_INFORMATION>
		            			<ORG_IND>{ data($row/ns2:Column[@name = 'TipoOrg']) }</ORG_IND>
		    					{
		    						if(string($org) != '') then (
		    							<ORG>{ $org }</ORG>
		    						) else()
		    					}
		    					<CURRENCY>{ data($row/ns2:Column[@name = 'CodMoneda']) }</CURRENCY>
		    					<ANUAL_PURCHASE_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_RTL_YTD_AMT']) }</ANUAL_PURCHASE_LIMIT>
		    					<ANUAL_WITHDRAWAL_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_CSH_YTD_AMT']) }</ANUAL_WITHDRAWAL_LIMIT>
		    					<MONTHLY_PURCHASE_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_RTL_MTD_AMT']) }</MONTHLY_PURCHASE_LIMIT>
		    					<MONTHLY_WITHDRAWAL_LIMIT>{ data($row/ns2:Column[@name = 'AMED_SL_CSH_MTD_AMT']) }</MONTHLY_WITHDRAWAL_LIMIT>
		    					{
		    						let $dailyPurchaseLimit:= string($row/ns2:Column[@name = 'AMED_SL_RTL_DLY_AMT']/text())
		    						return
		    						if(fn-bea:trim($dailyPurchaseLimit) != "") then (
		    							<DAILY_PURCHASE_LIMIT>{ $dailyPurchaseLimit }</DAILY_PURCHASE_LIMIT>
		    						)else()
		    					}
		    					{
		    						let $dailyWithDrawalLimit:= string($row/ns2:Column[@name = 'AMED_SL_CSH_DLY_AMT']/text())
		    						return
		    						if(fn-bea:trim($dailyWithDrawalLimit) != "") then (
		    							<DAILY_WITHDRAWAL_LIMIT>{ $dailyWithDrawalLimit }</DAILY_WITHDRAWAL_LIMIT>
		    						)else()
		    					}
		    					{
		    						let $cardActivationDate:= string($embosserInquiry/CARD_ACTIVATION_DATE/text())
		    						return
		    						if(fn-bea:trim($cardActivationDate) != "") then (
		    							<CARD_ACTIVATION_DATE>{ $cardActivationDate }</CARD_ACTIVATION_DATE>
		    						)else()
		    					}
		    					{
		    						let $cardStatus:= $embosserInquiry/CARD_STATUS
						 			return
						 				<CARD_STATUS>
						 				{
						 					valorCatalogoAPPToOSB(string($cardStatus/text()), 'VISION+', '13', $ptEquivalencias)
						 				}
						 				</CARD_STATUS>
		    					}
		    					<CARD_EXPIRATION_DATE>{ data($embosserInquiry/CARD_EXPIRATION_DATE) }</CARD_EXPIRATION_DATE>
		    					<EMBOSSED_NUMBER>{ data($embosserInquiry/EMBOSSED_NUMBER) }</EMBOSSED_NUMBER>
								<BLOCK_CODE>{ data($embosserInquiry/BLOCK_CODE) }</BLOCK_CODE>
								<BLOCK_REASON>{ data($embosserInquiry/BLOCK_REASON) }</BLOCK_REASON>
								<BLOCK_DATE>{ data($embosserInquiry/BLOCK_DATE) }</BLOCK_DATE>
		    					<PRODUCT>TCR</PRODUCT>
		    					<USER_CODE>{ data($row/ns2:Column[@name = 'cod_user4']) }</USER_CODE>
		            		</CARD_CURRENCY_INFORMATION>
		            	)
	    			
               )
            }
        </ns0:consultaDatosTarjetaCreditoResponse>
};

declare variable $sjconsultaDatosTarjetaCreditoResponse as element(ns6:sjconsultaDatosTarjetaCreditoResponse) external;
declare variable $datosCuenta as element(ns2:OutputParameters) external;
declare variable $ptEquivalencias as element() external;
declare variable $outputParameters1 as element(ns5:OutputParameters)? external;

xf:consultaDatosTarjetaCreditoOut($sjconsultaDatosTarjetaCreditoResponse,
    $datosCuenta,
    $ptEquivalencias,
    $outputParameters1)