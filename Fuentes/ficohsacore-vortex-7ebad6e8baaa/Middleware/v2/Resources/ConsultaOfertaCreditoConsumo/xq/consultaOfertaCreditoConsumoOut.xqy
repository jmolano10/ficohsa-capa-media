xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$epOriginacionesHondurasResponse" element="ns1:epOriginacionesHondurasResponse" location="../../../BusinessServices/BLAZE/wsdl/RuleServiceDefinitionORPTMOHNService.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaOfertaCreditoConsumoResponse" location="../xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)

declare namespace ns1 = "http://package.name.in.reverse.order";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoOut/";

declare function xf:consultaOfertaCreditoConsumoOut($epOriginacionesHondurasResponse as element(ns1:epOriginacionesHondurasResponse))
    as element(ns0:consultaOfertaCreditoConsumoResponse) {
        <ns0:consultaOfertaCreditoConsumoResponse>
            <CASE_ID>{ data($epOriginacionesHondurasResponse/return/numeroSolicitud) }</CASE_ID> 
            <GENERAL_RCI>{ xs:float(data($epOriginacionesHondurasResponse/return/RCI)) }</GENERAL_RCI> 
            <GENERAL_RCI_MAX>{ xs:float(data($epOriginacionesHondurasResponse/return/RCIMax)) }</GENERAL_RCI_MAX> 
            <GENERAL_CURRENT_NDE>{ xs:float(data($epOriginacionesHondurasResponse/return/NDEActual)) }</GENERAL_CURRENT_NDE> 
            <GENERAL_FINAL_NDE>{ xs:float(data($epOriginacionesHondurasResponse/return/NDEFinal)) }</GENERAL_FINAL_NDE> 
            <CREDIT_CARD_SCORE>{ xs:int(data($epOriginacionesHondurasResponse/return/behaviorScoreTC)) }</CREDIT_CARD_SCORE> 
            <INTERNAL_SCORE>{ xs:float(data($epOriginacionesHondurasResponse/return/score/score)) }</INTERNAL_SCORE>
            <CREDIT_CARD_RISK_LEVEL>{ xs:string(data($epOriginacionesHondurasResponse/return/nivelRiesgoTC)) }</CREDIT_CARD_RISK_LEVEL> 
            <INTERNAL_RISK_LEVEL>{ xs:string(data($epOriginacionesHondurasResponse/return/score/nivelRiesgo)) }</INTERNAL_RISK_LEVEL>
            <EXTERNAL_RISK_LEVEL>{ xs:string(data($epOriginacionesHondurasResponse/return/calificacionBuro)) }</EXTERNAL_RISK_LEVEL>
            <CUSTOMER_SEGMENT>{ xs:string(data($epOriginacionesHondurasResponse/return/segmentoCliente)) }</CUSTOMER_SEGMENT>
            <CUSTOMER_SUBSEGMENT>{ xs:string(data($epOriginacionesHondurasResponse/return/subSegmentoCliente)) }</CUSTOMER_SUBSEGMENT>
            <CURRENT_EXPOSURE>{ xs:float(data($epOriginacionesHondurasResponse/return/exposicionActual)) }</CURRENT_EXPOSURE>
            <GLOBAL_EXPOSURE_LOCAL_CCY>{ xs:float(data($epOriginacionesHondurasResponse/return/exposicionGlobal)) }</GLOBAL_EXPOSURE_LOCAL_CCY>
            <GLOBAL_EXPOSURE_FOREIGN_CCY>{ xs:float(data($epOriginacionesHondurasResponse/return/exposicionGlobalUSD)) }</GLOBAL_EXPOSURE_FOREIGN_CCY>
            <CREDIT_CARD_OVERDRAFT>{ xs:float(data($epOriginacionesHondurasResponse/return/noSobregiroTC)) }</CREDIT_CARD_OVERDRAFT> 
            <CREDIT_REFERENCES>{ xs:int(data($epOriginacionesHondurasResponse/return/noReferenciasCrediticias)) }</CREDIT_REFERENCES> 
            <INTERNAL_LOAN_REFERENCES>{ xs:int(data($epOriginacionesHondurasResponse/return/noReferenciasPtmo)) }</INTERNAL_LOAN_REFERENCES>
            <REWRITE_REFERENCES>{ xs:int(data($epOriginacionesHondurasResponse/return/noReferenciasSR)) }</REWRITE_REFERENCES>
            <TOTAL_EXTRA>{ xs:int(data($epOriginacionesHondurasResponse/return/totalExtrafinanciamientos)) }</TOTAL_EXTRA>
            <TOTAL_RISK>{ xs:float(data($epOriginacionesHondurasResponse/return/riesgoTotal)) }</TOTAL_RISK>
            <CURRENT_ARREAR>{ xs:int(data($epOriginacionesHondurasResponse/return/moraActualInterna)) }</CURRENT_ARREAR>
            <CURRENT_ARREAR_BALANCE>{ xs:float(data($epOriginacionesHondurasResponse/return/saldoMoraActualInterna)) }</CURRENT_ARREAR_BALANCE>
            <CREDIT_EXPERIENCE>{ xs:int(data($epOriginacionesHondurasResponse/return/expCrediticia)) }</CREDIT_EXPERIENCE>
            <ARREAR_ON_60DAYS_FOR_6MONTHS>{ xs:int(data($epOriginacionesHondurasResponse/return/vecesMora60_6m)) }</ARREAR_ON_60DAYS_FOR_6MONTHS>
            <ARREAR_ON_60DAYS_FOR_12MONTHS>{ xs:int(data($epOriginacionesHondurasResponse/return/vecesMora60_12m)) }</ARREAR_ON_60DAYS_FOR_12MONTHS>
            <ARREAR_ON_90DAYS_FOR_12MONTHS>{ xs:int(data($epOriginacionesHondurasResponse/return/vecesMora90_12m)) }</ARREAR_ON_90DAYS_FOR_12MONTHS>
            <RESOLUTIONS>
            {
               for $resolutions in $epOriginacionesHondurasResponse/return/oferta/arrayResolucion
               return
               <RESOLUTION>
                  <RESOLUTION_ID>{ xs:string(data($resolutions/codResolucion)) }</RESOLUTION_ID>  
                  <RESOLUTION_DESCRIPTION>{ xs:string(data($resolutions/descripcionResolucion)) }</RESOLUTION_DESCRIPTION>
               </RESOLUTION>
            }
            </RESOLUTIONS>
            <RESOLUTION_OFFERS>
                {
                    for $oferta in $epOriginacionesHondurasResponse/return/oferta
                    return
                        <OFFER>
                            {
                                for $codProducto in $oferta/codProducto
                                return
                                    <PRODUCT_CODE>{ xs:string(data($codProducto)) }</PRODUCT_CODE>
                            }
                            <RATE>{ xs:float(data($oferta/tasa)) }</RATE>
                            <INSTALLMENT>{ xs:float(data($oferta/cuota)) }</INSTALLMENT>
                            <INSTALLMENT_NDE>{ xs:float(data($oferta/cuotaNDE)) }</INSTALLMENT_NDE>
                            <INSTALLMENT_RCI_NONP2C>{ xs:float(data($oferta/cuotaRCI_NONP2C)) }</INSTALLMENT_RCI_NONP2C>
                            <INSTALLMENT_RCI_P2C>{ xs:float(data($oferta/cuotaRCI_P2C)) }</INSTALLMENT_RCI_P2C>
                            <FOR_12_MONTHS>{ xs:float(data($oferta/monto12)) }</FOR_12_MONTHS>
                            <FOR_18_MONTHS>{ xs:float(data($oferta/monto18)) }</FOR_18_MONTHS>
                            <FOR_24_MONTHS>{ xs:float(data($oferta/monto24)) }</FOR_24_MONTHS>
                            <FOR_36_MONTHS>{ xs:float(data($oferta/monto36)) }</FOR_36_MONTHS>
                            <FOR_48_MONTHS>{ xs:float(data($oferta/monto48)) }</FOR_48_MONTHS>
                            <FOR_60_MONTHS>{ xs:float(data($oferta/monto60)) }</FOR_60_MONTHS>
                            <FOR_72_MONTHS>{ xs:float(data($oferta/monto72)) }</FOR_72_MONTHS>
                            <FOR_84_MONTHS>{ xs:float(data($oferta/monto84)) }</FOR_84_MONTHS>
                            <FOR_96_MONTHS>{ xs:float(data($oferta/monto96)) }</FOR_96_MONTHS>
                            <FOR_108_MONTHS>{ xs:float(data($oferta/monto108)) }</FOR_108_MONTHS>
                            <FOR_120_MONTHS>{ xs:float(data($oferta/monto120)) }</FOR_120_MONTHS>
                            <FOR_MAX_AMOUNT>{ xs:float(data($oferta/montoMax)) }</FOR_MAX_AMOUNT>
                            <MEG_OFFER>{ xs:float(data($oferta/ofertaMEG)) }</MEG_OFFER>
                            <MAX_OFFER>{ xs:float(data($oferta/ofertaMax)) }</MAX_OFFER>
                            <NDE_OFFER>{ xs:float(data($oferta/ofertaNDE)) }</NDE_OFFER>
                            <NONP2C_OFFER>{ xs:float(data($oferta/ofertaNonP2c)) }</NONP2C_OFFER>
                            <P2C_OFFER>{ xs:float(data($oferta/ofertaP2C)) }</P2C_OFFER>
                            <RCI_OFFER>{ xs:float(data($oferta/ofertaRCI)) }</RCI_OFFER>
                            <TIMESINCOME_OFFER>{ xs:float(data($oferta/ofertaTimesIncome)) }</TIMESINCOME_OFFER>
                            <RCI>{ xs:float(data($oferta/RCI)) }</RCI>
                            <TIMESINCOME>{ xs:int(data($oferta/timesIncome)) }</TIMESINCOME>
                        </OFFER>
                }
            </RESOLUTION_OFFERS>
            {
                    for $CREDIT_CARD in $epOriginacionesHondurasResponse/return/tarjetas
                    return
            <CREDIT_CARD>
                {
                    for $codbloqueo1 in $CREDIT_CARD/codbloqueo1
                    return
                        <LOCKCODE1>{ data($codbloqueo1) }</LOCKCODE1>
                }
                {
                    for $codbloqueo2 in $CREDIT_CARD/codbloqueo2
                    return
                        <LOCKCODE2>{ data($codbloqueo2) }</LOCKCODE2>
                }
                {
                    for $grupoAfinidad in $CREDIT_CARD/grupoAfinidad
                    return
                        <LOGO>{ data($grupoAfinidad) }</LOGO>
                }
                {
                    for $cash_diponible in $CREDIT_CARD/cash_diponible
                    return
                        <AVAILABLE_CASH>{ data($cash_diponible) }</AVAILABLE_CASH>
                }
                {
                    for $fechabloqueo1 in $CREDIT_CARD/fechabloqueo1
                    return
                        <LOCK_DATE1>{ data($fechabloqueo1) }</LOCK_DATE1>
                }
                {
                    for $fechabloqueo2 in $CREDIT_CARD/fechabloqueo2
                    return
                        <LOCK_DATE2>{ data($fechabloqueo2) }</LOCK_DATE2>
                }              
                
                <TRANSACTION_CREDIT_CARD_TYPE>
                {
			        for $TRANSACTION in $CREDIT_CARD/transaccionesTarjeta
                    return
                    <TRANSACTION>
                    	{
		                    for $cuota_extra in $TRANSACTION/cuota_extra
		                    return
		                        <EXTRA_FEE>{ data($cuota_extra) }</EXTRA_FEE>
                		}    
                    	{
		                    for $cuota_intra in $TRANSACTION/cuota_intra
		                    return
		                        <INTRA_FEE>{ data($cuota_intra) }</INTRA_FEE>
                		}
                		{
		                    for $saldo_extra in $TRANSACTION/saldo_extra
		                    return
		                        <EXTRA_BALANCE>{ data($saldo_extra) }</EXTRA_BALANCE>
                		}
                		{
		                    for $saldo_intra in $TRANSACTION/saldo_intra
		                    return
		                        <INTRA_BALANCE>{ data($saldo_intra) }</INTRA_BALANCE>
                		}
                    </TRANSACTION>
                    }
                </TRANSACTION_CREDIT_CARD_TYPE>
            </CREDIT_CARD>
            }
        </ns0:consultaOfertaCreditoConsumoResponse>
};

declare variable $epOriginacionesHondurasResponse as element(ns1:epOriginacionesHondurasResponse) external;

xf:consultaOfertaCreditoConsumoOut($epOriginacionesHondurasResponse)