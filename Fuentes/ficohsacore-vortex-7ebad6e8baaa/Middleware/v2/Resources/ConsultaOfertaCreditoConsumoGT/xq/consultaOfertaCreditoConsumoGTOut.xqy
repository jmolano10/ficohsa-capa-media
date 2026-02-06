xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$processWithDecisionFlow2Response" element="ns1:processWithDecisionFlow2Response" location="../../../BusinessServices/OIC/originacionesGT/wsdl/originacionesGT.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaOfertaCreditoConsumoResponse" location="../../ConsultaOfertaCreditoConsumo/xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)

declare namespace ns1 = "http://fico.com/blaze/advisor/rma/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
declare namespace xf = "http://tempuri.org/OSB%20Project%201/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoGTOut/";

declare function xf:consultaOfertaCreditoConsumoGTOut($processWithDecisionFlow2Response as element(ns1:processWithDecisionFlow2Response))
    as element(ns0:consultaOfertaCreditoConsumoResponse) {
        <ns0:consultaOfertaCreditoConsumoResponse>
            {
                for $noSolicitud in $processWithDecisionFlow2Response/return/noSolicitud
                return
                    <CASE_ID>{ data($noSolicitud) }</CASE_ID>
            }
            {
                for $rciFinal in $processWithDecisionFlow2Response/return/accion/rciFinal
                return
                    <GENERAL_RCI>{ data($rciFinal) }</GENERAL_RCI>
            }
            {
                for $rciMax in $processWithDecisionFlow2Response/return/accion/rciMax
                return
                    <GENERAL_RCI_MAX>{ data($rciMax) }</GENERAL_RCI_MAX>
            }
            {
                for $nivelEndeudamientoActual in $processWithDecisionFlow2Response/return/accion/nivelEndeudamientoActual
                return
                    <GENERAL_CURRENT_NDE>{ data($nivelEndeudamientoActual) }</GENERAL_CURRENT_NDE>
            }
            {
                for $nivelEndeudamientoFinal in $processWithDecisionFlow2Response/return/accion/nivelEndeudamientoFinal
                return
                    <GENERAL_FINAL_NDE>{ data($nivelEndeudamientoFinal) }</GENERAL_FINAL_NDE>
            }
            {
                for $scoreTarjetaCredito in $processWithDecisionFlow2Response/return/accion/scoreTarjetaCredito
                return
                    <CREDIT_CARD_SCORE>{ data($scoreTarjetaCredito) }</CREDIT_CARD_SCORE>
            }
            {
                for $nivelRiesgoTarjetaCredito in $processWithDecisionFlow2Response/return/accion/nivelRiesgoTarjetaCredito
                return
                    <CREDIT_CARD_RISK_LEVEL>{ data($nivelRiesgoTarjetaCredito) }</CREDIT_CARD_RISK_LEVEL>
            }
            {
                for $nivelRiesgoExterno in $processWithDecisionFlow2Response/return/accion/nivelRiesgoExterno
                return
                    <EXTERNAL_RISK_LEVEL>{ data($nivelRiesgoExterno) }</EXTERNAL_RISK_LEVEL>
            }
            {
                for $segmentoCliente in $processWithDecisionFlow2Response/return/accion/segmentoCliente
                return
                    <CUSTOMER_SEGMENT>{ data($segmentoCliente) }</CUSTOMER_SEGMENT>
            }
            {
                for $subSegmentoCliente in $processWithDecisionFlow2Response/return/accion/subSegmentoCliente
                return
                    <CUSTOMER_SUBSEGMENT>{ data($subSegmentoCliente) }</CUSTOMER_SUBSEGMENT>
            }
            {
                for $exposicionGlobal in $processWithDecisionFlow2Response/return/accion/exposicionGlobal
                return
                    <CURRENT_EXPOSURE>{ data($exposicionGlobal) }</CURRENT_EXPOSURE>
            }
            {
                for $exposicionActualLOC in $processWithDecisionFlow2Response/return/accion/exposicionActualLOC
                return
                    <GLOBAL_EXPOSURE_LOCAL_CCY>{ data($exposicionActualLOC) }</GLOBAL_EXPOSURE_LOCAL_CCY>
            }
            {
                for $exposicionActualUSD in $processWithDecisionFlow2Response/return/accion/exposicionActualUSD
                return
                    <GLOBAL_EXPOSURE_FOREIGN_CCY>{ data($exposicionActualUSD) }</GLOBAL_EXPOSURE_FOREIGN_CCY>
            }
            {
                for $sobreGiroTarjetaCredito in $processWithDecisionFlow2Response/return/accion/sobreGiroTarjetaCredito
                return
                    <CREDIT_CARD_OVERDRAFT>{ data($sobreGiroTarjetaCredito) }</CREDIT_CARD_OVERDRAFT>
            }
            {
                for $cantidadReferencias in $processWithDecisionFlow2Response/return/accion/cantidadReferencias
                return
                    <CREDIT_REFERENCES>{ data($cantidadReferencias) }</CREDIT_REFERENCES>
            }
            {
                for $cantidadPrestamosInternos in $processWithDecisionFlow2Response/return/accion/cantidadPrestamosInternos
                return
                    <INTERNAL_LOAN_REFERENCES>{ data($cantidadPrestamosInternos) }</INTERNAL_LOAN_REFERENCES>
            }
            {
                for $referenciasCastigo in $processWithDecisionFlow2Response/return/accion/referenciasCastigo
                return
                    <REWRITE_REFERENCES>{ data($referenciasCastigo) }</REWRITE_REFERENCES>
            }
            {
                for $totalSaldoExtrafinanciamiento in $processWithDecisionFlow2Response/return/accion/totalSaldoExtrafinanciamiento
                return
                    <TOTAL_EXTRA>{ data($totalSaldoExtrafinanciamiento) }</TOTAL_EXTRA>
            }
            {
                for $riesgoTotal in $processWithDecisionFlow2Response/return/accion/riesgoTotal
                return
                    <TOTAL_RISK>{ data($riesgoTotal) }</TOTAL_RISK>
            }
            {
                for $moraMaxima in $processWithDecisionFlow2Response/return/accion/moraMaxima
                return
                    <CURRENT_ARREAR>{ data($moraMaxima) }</CURRENT_ARREAR>
            }
            {
                for $saldoMora in $processWithDecisionFlow2Response/return/accion/saldoMora
                return
                    <CURRENT_ARREAR_BALANCE>{ data($saldoMora) }</CURRENT_ARREAR_BALANCE>
            }
            {
                for $experienciaCrediticia in $processWithDecisionFlow2Response/return/accion/experienciaCrediticia
                return
                    <CREDIT_EXPERIENCE>{ data($experienciaCrediticia) }</CREDIT_EXPERIENCE>
            }
            {
                for $cantidadVecesMora60En6M in $processWithDecisionFlow2Response/return/accion/cantidadVecesMora60En6M
                return
                    <ARREAR_ON_60DAYS_FOR_6MONTHS>{ data($cantidadVecesMora60En6M) }</ARREAR_ON_60DAYS_FOR_6MONTHS>
            }
            {
                for $cantidadVecesMora60En12M in $processWithDecisionFlow2Response/return/accion/cantidadVecesMora60En12M
                return
                    <ARREAR_ON_60DAYS_FOR_12MONTHS>{ data($cantidadVecesMora60En12M) }</ARREAR_ON_60DAYS_FOR_12MONTHS>
            }
            {
                for $CantidadVecesMora90En12M in $processWithDecisionFlow2Response/return/accion/CantidadVecesMora90En12M
                return
                    <ARREAR_ON_90DAYS_FOR_12MONTHS>{ data($CantidadVecesMora90En12M) }</ARREAR_ON_90DAYS_FOR_12MONTHS>
            }
            <RESOLUTIONS>
			    {
			        for $oferta in $processWithDecisionFlow2Response/return/oferta
			        for $arrayResolucion in $oferta/arrayResolucion
			        return
			            <RESOLUTION>
			                {
			                    for $codigoResolucion in $arrayResolucion/codigoResolucion
			                    return
			                        <RESOLUTION_ID>{ data($codigoResolucion) }</RESOLUTION_ID>
			                }
			                {
			                    for $descripcion in $arrayResolucion/descripcion
			                    return
			                        <RESOLUTION_DESCRIPTION>{ data($descripcion) }</RESOLUTION_DESCRIPTION>
			                }
			            </RESOLUTION>
			    }
			</RESOLUTIONS>
            <RESOLUTION_OFFERS>
                {
                    for $oferta in $processWithDecisionFlow2Response/return/oferta
                    return
                        <OFFER>
                            {
                                for $codigoProducto in $oferta/codigoProducto
                                return
                                    <PRODUCT_CODE>{ data($codigoProducto) }</PRODUCT_CODE>
                            }
                            {
                                for $tasa in $oferta/tasa
                                return
                                    <RATE>{ data($tasa) }</RATE>
                            }
                            {
                                for $cuota in $oferta/cuota
                                return
                                    <INSTALLMENT>{ data($cuota) }</INSTALLMENT>
                            }
                            
                            {
                                for $cuotaNDE in $oferta/cuotaNDE
                                return
                                    <INSTALLMENT_NDE>{ data($cuotaNDE) }</INSTALLMENT_NDE>
                            }
                            {
                                for $cuotaRCINONP2C in $oferta/cuotaRCINONP2C
                                return
                                    <INSTALLMENT_RCI_NONP2C>{ data($cuotaRCINONP2C) }</INSTALLMENT_RCI_NONP2C>
                            }
                            {
                                for $cuotaRCIP2C in $oferta/cuotaRCIP2C
                                return
                                    <INSTALLMENT_RCI_P2C>{ data($cuotaRCIP2C) }</INSTALLMENT_RCI_P2C>
                            }
                            {
                                for $monto12 in $oferta/monto12
                                return
                                    <FOR_12_MONTHS>{ data($monto12) }</FOR_12_MONTHS>
                            }
                            {
                                for $monto18 in $oferta/monto18
                                return
                                    <FOR_18_MONTHS>{ data($monto18) }</FOR_18_MONTHS>
                            }
                            {
                                for $monto24 in $oferta/monto24
                                return
                                    <FOR_24_MONTHS>{ data($monto24) }</FOR_24_MONTHS>
                            }
                            {
                                for $monto36 in $oferta/monto36
                                return
                                    <FOR_36_MONTHS>{ data($monto36) }</FOR_36_MONTHS>
                            }
                            {
                                for $monto48 in $oferta/monto48
                                return
                                    <FOR_48_MONTHS>{ data($monto48) }</FOR_48_MONTHS>
                            }
                            {
                                for $monto60 in $oferta/monto60
                                return
                                    <FOR_60_MONTHS>{ data($monto60) }</FOR_60_MONTHS>
                            }
                            {
                                for $monto72 in $oferta/monto72
                                return
                                    <FOR_72_MONTHS>{ data($monto72) }</FOR_72_MONTHS>
                            }
                            {
                                for $monto84 in $oferta/monto84
                                return
                                    <FOR_84_MONTHS>{ data($monto84) }</FOR_84_MONTHS>
                            }
                            {
                                for $monto96 in $oferta/monto96
                                return
                                    <FOR_96_MONTHS>{ data($monto96) }</FOR_96_MONTHS>
                            }
                            {
                                for $monto108 in $oferta/monto108
                                return
                                    <FOR_108_MONTHS>{ data($monto108) }</FOR_108_MONTHS>
                            }
                            {
                                for $monto120 in $oferta/monto120
                                return
                                    <FOR_120_MONTHS>{ data($monto120) }</FOR_120_MONTHS>
                            }
                            {
                                for $montoMax in $oferta/montoMax
                                return
                                    <FOR_MAX_AMOUNT>{ data($montoMax) }</FOR_MAX_AMOUNT>
                            }
                            {
                                for $montoMEG in $oferta/montoMEG
                                return
                                    <MEG_OFFER>{ data($montoMEG) }</MEG_OFFER>
                            }
                            {
                                for $ofertaMax in $oferta/ofertaMax
                                return
                                    <MAX_OFFER>{ data($ofertaMax) }</MAX_OFFER>
                            }
                            {
                                for $montoNDE in $oferta/montoNDE
                                return
                                    <NDE_OFFER>{ data($montoNDE) }</NDE_OFFER>
                            }
                            {
                                for $MontoNONP2C in $oferta/MontoNONP2C
                                return
                                    <NONP2C_OFFER>{ data($MontoNONP2C) }</NONP2C_OFFER>
                            }
                            {
                                for $montoP2C in $oferta/montoP2C
                                return
                                    <P2C_OFFER>{ data($montoP2C) }</P2C_OFFER>
                            }
                            {
                                for $montoRCI in $oferta/montoRCI
                                return
                                    <RCI_OFFER>{ data($montoRCI) }</RCI_OFFER>
                            }
                            {
                                for $montoTimesIncome in $oferta/montoTimesIncome
                                return
                                    <TIMESINCOME_OFFER>{ data($montoTimesIncome) }</TIMESINCOME_OFFER>
                            }
                            {
                                for $RCI in $oferta/RCI
                                return
                                    <RCI>{ data($RCI) }</RCI>
                            }
                            {
                                for $timesIncome in $oferta/timesIncome
                                return
                                    <TIMESINCOME>{ data($timesIncome) }</TIMESINCOME>
                            }
                        </OFFER>
                }
            </RESOLUTION_OFFERS>
            {
                for $fechaActual in $processWithDecisionFlow2Response/return/fechaActual
                return
                    <DATE>{ data($fechaActual) }</DATE>
            }        
            {
                for $segmentoSalarioCliente in $processWithDecisionFlow2Response/return/accion/segmentoSalarioCliente
                return
                    <CUSTOMER_SALARY_SEGMENT>{ data($segmentoSalarioCliente) }</CUSTOMER_SALARY_SEGMENT>
            }
            {
                for $creditosDirectosActivos in $processWithDecisionFlow2Response/return/accion/creditosDirectosActivos
                return
                    <ACTIVE_DIRECT_CREDITS>{ data($creditosDirectosActivos) }</ACTIVE_DIRECT_CREDITS>
            }
            {
                for $creditosDirectosCancelados in $processWithDecisionFlow2Response/return/accion/creditosDirectosCancelados
                return
                    <CANCELED_DIRECT_CREDITS>{ data($creditosDirectosCancelados) }</CANCELED_DIRECT_CREDITS>
            }
            {
                for $creditosIndirectosActivos in $processWithDecisionFlow2Response/return/accion/creditosIndirectosActivos
                return
                    <ACTIVE_INDIRECT_CREDITS>{ data($creditosIndirectosActivos) }</ACTIVE_INDIRECT_CREDITS>
            }
            {
                for $creditosIndirectosCancelados in $processWithDecisionFlow2Response/return/accion/creditosIndirectosCancelados
                return
                    <CANCELED_INDIRECT_CREDITS>{ data($creditosIndirectosCancelados) }</CANCELED_INDIRECT_CREDITS>
            }
            {
                for $cantidadVecesMora30En3M in $processWithDecisionFlow2Response/return/accion/cantidadVecesMora30En3M
                return
                    <ARREAR_ON_30DAYS_FOR_3MONTHS>{ data($cantidadVecesMora30En3M) }</ARREAR_ON_30DAYS_FOR_3MONTHS>
            }
            {
                for $cantidadVecesMora120En18M in $processWithDecisionFlow2Response/return/accion/cantidadVecesMora120En18M
                return
                    <ARREAR_ON_120DAYS_FOR_18MONTHS>{ data($cantidadVecesMora120En18M) }</ARREAR_ON_120DAYS_FOR_18MONTHS>
            }
            {
                for $totalDeudaDirecta in $processWithDecisionFlow2Response/return/accion/totalDeudaDirecta
                return
                    <TOTAL_DIRECT_DEBT>{ data($totalDeudaDirecta) }</TOTAL_DIRECT_DEBT>
            }
            {
                for $totalDeudaIndirecta in $processWithDecisionFlow2Response/return/accion/totalDeudaIndirecta
                return
                    <TOTAL_INDIRECT_DEBT>{ data($totalDeudaIndirecta) }</TOTAL_INDIRECT_DEBT>
            }
            {
                for $totalDeudaContingente in $processWithDecisionFlow2Response/return/accion/totalDeudaContingente
                return
                    <TOTAL_CONTINGENT_DEBT>{ data($totalDeudaContingente) }</TOTAL_CONTINGENT_DEBT>
            }
            {
                for $salarioInferido in $processWithDecisionFlow2Response/return/salarioInferido
                return
                    <CALCULATED_SALARY>{ data($salarioInferido) }</CALCULATED_SALARY>
            }
            {
                for $salarioDB in $processWithDecisionFlow2Response/return/salarioDB
                return
                    <DEBT_BURDEN_SALARY>{ data($salarioDB) }</DEBT_BURDEN_SALARY>
            }
            {
                for $sumatoriaCuotasSirc in $processWithDecisionFlow2Response/return/accion/sumatoriaCuotasSirc
                return
                    <BUREAU_INSTALLMENT>{ data($sumatoriaCuotasSirc) }</BUREAU_INSTALLMENT>
            }
            {
                for $sumatoriasCuotasTransunion in $processWithDecisionFlow2Response/return/accion/sumatoriasCuotasTransunion
                return
                    <BUREAU_INSTALLMENT_EXTERNAL>{ data($sumatoriasCuotasTransunion) }</BUREAU_INSTALLMENT_EXTERNAL>
            }
            {
                for $sumatoriaCuotasBuro in $processWithDecisionFlow2Response/return/accion/sumatoriaCuotasBuro
                return
                    <TOTAL_BUREAU_INSTALLMENT>{ data($sumatoriaCuotasBuro) }</TOTAL_BUREAU_INSTALLMENT>
            }
            {
                for $limiteMaximoTarjetaCredito in $processWithDecisionFlow2Response/return/accion/limiteMaximoTarjetaCredito
                return
                    <MAX_LIMIT_CREDIT_CARD>{ data($limiteMaximoTarjetaCredito) }</MAX_LIMIT_CREDIT_CARD>
            }
            {
                for $limitePromedioTarjetaCredito in $processWithDecisionFlow2Response/return/accion/limitePromedioTarjetaCredito
                return
                    <AVERAGE_LIMIT_CREDIT_CARD>{ data($limitePromedioTarjetaCredito) }</AVERAGE_LIMIT_CREDIT_CARD>
            }
            {
                for $saldoConsolidacion in $processWithDecisionFlow2Response/return/saldoConsolidacion
                return
                    <CONSOLIDATE_BALANCE>{ data($saldoConsolidacion) }</CONSOLIDATE_BALANCE>
            }
            {
                for $referenciaSIB in $processWithDecisionFlow2Response/return/accion/referenciaSIB
                return
                    <SIB_REFERENCE>{ data($referenciaSIB) }</SIB_REFERENCE>
            }
            {
                for $poseeReferencia in $processWithDecisionFlow2Response/return/accion/poseeReferencia
                return
                    <REFERENCE>{ data($poseeReferencia) }</REFERENCE>
            }
            {
                for $tipoReferencia in $processWithDecisionFlow2Response/return/accion/tipoReferencia
                return
                    <REFERENCE_TYPE>{ data($tipoReferencia) }</REFERENCE_TYPE>
            }
            {
                for $entidadReferencia in $processWithDecisionFlow2Response/return/accion/entidadReferencia
                return
                    <REFERENCE_ENTITY>{ data($entidadReferencia) }</REFERENCE_ENTITY>
            }
            {
                for $saldoReferencia in $processWithDecisionFlow2Response/return/accion/saldoReferencia
                return
                    <REFERENCE_BALANCE>{ data($saldoReferencia) }</REFERENCE_BALANCE>
            }
            {
                for $fechaAperturaReferencia in $processWithDecisionFlow2Response/return/accion/fechaAperturaReferencia
                return
                    <REFERENCE_OPENING_DATE>{ data($fechaAperturaReferencia) }</REFERENCE_OPENING_DATE>
            }           
            <SCORE>
            {
                for $score in $processWithDecisionFlow2Response/return/score
                return                      
		                <SCORE>
		                    {
		                        for $var1 in $processWithDecisionFlow2Response/return/score/var1
		                        return
		                            <VAR1>{ data($var1) }</VAR1>
		                    }
		                    {
		                        for $var2 in $processWithDecisionFlow2Response/return/score/var2
		                        return
		                            <VAR2>{ data($var2) }</VAR2>
		                    }
		                    {
		                        for $var3 in $processWithDecisionFlow2Response/return/score/var3
		                        return
		                            <VAR3>{ data($var3) }</VAR3>
		                    }
		                    {
		                        for $var4 in $processWithDecisionFlow2Response/return/score/var4
		                        return
		                            <VAR4>{ data($var4) }</VAR4>
		                    }
		                    {
		                        for $var5 in $processWithDecisionFlow2Response/return/score/var5
		                        return
		                            <VAR5>{ data($var5) }</VAR5>
		                    }
		                    {
		                        for $var6 in $processWithDecisionFlow2Response/return/score/var6
		                        return
		                            <VAR6>{ data($var6) }</VAR6>
		                    }
		                    {
		                        for $var7 in $processWithDecisionFlow2Response/return/score/var7
		                        return
		                            <VAR7>{ data($var7) }</VAR7>
		                    }
		                    {
		                        for $var8 in $processWithDecisionFlow2Response/return/score/var8
		                        return
		                            <VAR8>{ data($var8) }</VAR8>
		                    }
		                    {
		                        for $var9 in $processWithDecisionFlow2Response/return/score/var9
		                        return
		                            <VAR9>{ data($var9) }</VAR9>
		                    }
		                    {
		                        for $var10 in $processWithDecisionFlow2Response/return/score/var10
		                        return
		                            <VAR10>{ data($var10) }</VAR10>
		                    }
		                    {
		                        for $var11 in $processWithDecisionFlow2Response/return/score/var11
		                        return
		                            <VAR11>{ data($var11) }</VAR11>
		                    }
		                    {
		                        for $var12 in $processWithDecisionFlow2Response/return/score/var12
		                        return
		                            <VAR12>{ data($var12) }</VAR12>
		                    }
		                    {
		                        for $var13 in $processWithDecisionFlow2Response/return/score/var13
		                        return
		                            <VAR13>{ data($var13) }</VAR13>
		                    }
		                    {
		                        for $var14 in $processWithDecisionFlow2Response/return/score/var14
		                        return
		                            <VAR14>{ data($var14) }</VAR14>
		                    }
		                    {
		                        for $var15 in $processWithDecisionFlow2Response/return/score/var15
		                        return
		                            <VAR15>{ data($var15) }</VAR15>
		                    }
		                    {
		                        for $score in $processWithDecisionFlow2Response/return/score/score
		                        return
		                            <INTERNAL_SCORE>{ data($score) }</INTERNAL_SCORE>
		                    }
		                    {
		                        for $nivelRiesgo in $processWithDecisionFlow2Response/return/score/nivelRiesgo
		                        return
		                            <INTERNAL_RISK_LEVEL>{ data($nivelRiesgo) }</INTERNAL_RISK_LEVEL>
		                    }
							{
		                        for $estrategiaScore in $processWithDecisionFlow2Response/return/score/estrategiaScore
		                        return
		                            <SCORE_STRATEGY>{ data($estrategiaScore) }</SCORE_STRATEGY>
		                    }
		                    {
		                        for $tipoScore in $processWithDecisionFlow2Response/return/score/tipoScore
		                        return
		                            <SCORE_TYPE>{ data($tipoScore) }</SCORE_TYPE>
		                    }
		                </SCORE>
	                }
            </SCORE>
           <FOR_CONSOLIDATE>
                {
                    for $obligacionesConsolidar in $processWithDecisionFlow2Response/return/obligacionesConsolidar
                    return
                        <FOR_CONSOLIDATE>
                            {
                                for $tipoProducto in $obligacionesConsolidar/tipoProducto
                                return
                                    <REFERENCE_TYPE>{ data($tipoProducto) }</REFERENCE_TYPE>
                            }
                            {
                                for $moneda in $obligacionesConsolidar/moneda
                                return
                                    <REFERENCE_CURRENCY>{ data($moneda) }</REFERENCE_CURRENCY>
                            }
                            {
                                for $entidad in $obligacionesConsolidar/entidad
                                return
                                    <REFERENCE_ENTITY>{ data($entidad) }</REFERENCE_ENTITY>
                            }
                            {
                                for $chequeANombreDe in $obligacionesConsolidar/chequeANombreDe
                                return
                                    <CHECK_BENEFECIARY>{ data($chequeANombreDe) }</CHECK_BENEFECIARY>
                            }
                            {
                                for $numeroCuenta in $obligacionesConsolidar/numeroCuenta
                                return
                                    <REFERENCE_ACCOUNT_NUMBER>{ data($numeroCuenta) }</REFERENCE_ACCOUNT_NUMBER>
                            }
                            <REFERENCE_LIMIT_AMOUNT>{ data($obligacionesConsolidar/saldoConsolidar) }</REFERENCE_LIMIT_AMOUNT>
                            <REFERENCE_INSTALLMENT_AMOUNT>{ data($obligacionesConsolidar/cuotaConsolidar) }</REFERENCE_INSTALLMENT_AMOUNT>
                        </FOR_CONSOLIDATE>
                }
            </FOR_CONSOLIDATE>
        </ns0:consultaOfertaCreditoConsumoResponse>
};

declare variable $processWithDecisionFlow2Response as element(ns1:processWithDecisionFlow2Response) external;

xf:consultaOfertaCreditoConsumoGTOut($processWithDecisionFlow2Response)