xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetalletarjetasResponse" element="ns0:ConsultadetalletarjetasResponse" location="../../../BusinessServices/T24/svcConsultaDetalleTarjetas/xsd/XMLSchema_-271592632.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleTarjetasResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTarjetas/xq/consultaDetalleTarjetasHNOut/";

declare function xf:consultaDetalleTarjetasHNOut($consultadetalletarjetasResponse as element(ns0:ConsultadetalletarjetasResponse))
    as element(ns1:consultaDetalleTarjetasResponse) {
        <ns1:consultaDetalleTarjetasResponse>
            <CARD_DETAILS>
                {
                    let $mWSFICOCARDDETAILDetailType := $consultadetalletarjetasResponse/WSFICOCARDDETAILType[1]/gWSFICOCARDDETAILDetailType/mWSFICOCARDDETAILDetailType
                    for $CARD_DETAIL at $i in fn:tokenize($consultadetalletarjetasResponse/WSFICOCARDDETAILType[1]/gWSFICOCARDDETAILDetailType/mWSFICOCARDDETAILDetailType/CARDNUMBER, '\|\|')
                    return
                    	if (fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/BIN), '\|\|')[$i]) != '') then (
	                        <CARD_ITEM>
	                            <BIN>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/BIN), '\|\|')[$i]) }</BIN>
	                            <COMPANY>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/COMPANY), '\|\|')[$i]) }</COMPANY>
	                            <CARD_NUMBER>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/CARDNUMBER), '\|\|')[$i]) }</CARD_NUMBER>
	                            <CUSTOMER_ID>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/CUSTOMER), '\|\|')[$i]) }</CUSTOMER_ID>
	                            <CUSTOMER_LEGAL_ID>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/IDNUMBER), '\|\|')[$i]) }</CUSTOMER_LEGAL_ID>
	                            <CUSTOMER_NAME>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/NAME), '\|\|')[$i]) }</CUSTOMER_NAME>
	                            <NAME_ON_CARD>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/NAMEONCARD), '\|\|')[$i]) }</NAME_ON_CARD>
	                            <EXPIRATION_DATE>
	                            	{ 
	                            		let $expirationDate := fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/EXPIRATIONDATE), '\|\|')[$i])
	                            		return
		                            		concat(
		                            			substring($expirationDate, 1, 4), 
		                            			"-", 
		                            			substring($expirationDate, 5, 2), 
		                            			"-", 
		                            			substring($expirationDate, 7)
		                            		)
	                            	}
	                            </EXPIRATION_DATE>
	                            <CREATION_DATE>
	                            	{
	                            		let $creationDate := fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/CREATIONDATE), '\|\|')[$i])
	                            		return
		                            		concat(
		                            			substring($creationDate, 1, 4), 
		                            			"-", 
		                            			substring($creationDate, 5, 2), 
		                            			"-", 
		                            			substring($creationDate, 7)
		                            		)
	                            	}
	                            </CREATION_DATE>
	                            <BANK_STATUS>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/STATUS), '\|\|')[$i]) }</BANK_STATUS>
	                            <EMBOSS_STATUS>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/EMBOSSSTATUS), '\|\|')[$i]) }</EMBOSS_STATUS>
	                            <PIN_VERIFICATION_VALUE>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/PIN), '\|\|')[$i]) }</PIN_VERIFICATION_VALUE>
	                            <SERVICE_CODE>{ fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/SERVICECODE), '\|\|')[$i]) }</SERVICE_CODE>
	                            <ACCOUNT_DETAILS>
		                            {
		                            	let $PRIMARYACCT := fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/PRIMARYACCT), '\|\|')[$i])
		                            	let $CURRENCY := fn:tokenize(fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/CURRENCY), '\|\|')[$i]), '\|')[1]
	                            		for $ACCOUNT_ITEM at $j in fn:tokenize($PRIMARYACCT, '\|')
	                            		return
                            				if(fn-bea:trim(fn:tokenize($PRIMARYACCT, '\|')[$j]) != '') then(
	                            				<ACCOUNT_ITEM>
                            						{
		                            					<ORDER_ACCOUNT>1</ORDER_ACCOUNT>,
		                            					<ACCOUNT_NUMBER>
				                                			{ 
				                                				fn-bea:trim(fn:tokenize($PRIMARYACCT, '\|')[$j]) 
				                                			}
				                                		</ACCOUNT_NUMBER>,
				                                		if(fn-bea:trim(fn:tokenize($CURRENCY, '\*')[$j]) != '') then(
				                                			<CURRENCY>
						                                		{ 
						                                			fn-bea:trim(fn:tokenize($CURRENCY, '\*')[$j])
						                                		}
						                                	</CURRENCY>
				                                		)else()
					                                }
	                            				</ACCOUNT_ITEM>
                            				)else()
                            		}
                            		{
                        				let $SECUNDARYACCT := fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/SECUNDARYACCT), '\|\|')[$i])
                        				let $CURRENCY := fn:tokenize(fn-bea:trim(fn:tokenize(data($mWSFICOCARDDETAILDetailType/CURRENCY), '\|\|')[$i]), '\|')[2]
                        				for $ACCOUNT_ITEM at $j in fn:tokenize($SECUNDARYACCT, '\|')
                        				return	
                            				if(fn-bea:trim(fn:tokenize($SECUNDARYACCT, '\|')[$j]) != '') then(
                            					<ACCOUNT_ITEM>
                            						{
		                            					<ORDER_ACCOUNT>2</ORDER_ACCOUNT>,
		                            					<ACCOUNT_NUMBER>
				                                			{ 
				                                				fn-bea:trim(fn:tokenize($SECUNDARYACCT, '\|')[$j]) 
				                                			}
				                                		</ACCOUNT_NUMBER>,
				                                		if(fn-bea:trim(fn:tokenize($CURRENCY, '\*')[$j]) != '') then(
				                                			<CURRENCY>
						                                		{ 
						                                			fn-bea:trim(fn:tokenize($CURRENCY, '\*')[$j]) 
						                                		}
						                                	</CURRENCY>
				                                		)else()
						                            }
		                            			</ACCOUNT_ITEM>
                            				)else()
		                            }
	                            </ACCOUNT_DETAILS>
	                        </CARD_ITEM>
	                    )else()
                }
            </CARD_DETAILS>
        </ns1:consultaDetalleTarjetasResponse>
};

declare variable $consultadetalletarjetasResponse as element(ns0:ConsultadetalletarjetasResponse) external;

xf:consultaDetalleTarjetasHNOut($consultadetalletarjetasResponse)