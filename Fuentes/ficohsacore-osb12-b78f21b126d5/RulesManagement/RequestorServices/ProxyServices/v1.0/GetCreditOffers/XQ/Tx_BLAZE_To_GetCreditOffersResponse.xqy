xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://package.name.in.reverse.order";
(:: import schema at "../../../../../ProviderServices/WSDL/GetCustomerOffers/RuleServiceDefinitionOriginacionesHNService.wsdl" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/creditManagement";
(:: import schema at "../../../../../../MWBanking/CreditManagement/RequestorServices/XSD/creditManagement.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $consultaOfertaCreditoConsumoResponse as element() (:: schema-element(ns1:epOriginacionesHondurasResponse) ::) external;

declare function xq:Tx_BLAZE_To_GetCreditOffersResponse($consultaOfertaCreditoConsumoResponse as element() (:: schema-element(ns1:epOriginacionesHondurasResponse) ::),$uuid as xs:string) as element() (:: schema-element(ns2:getCreditOffersResponse) ::) {
    <ns2:getCreditOffersResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:GetCreditOffers>
            <ns2:CaseId>{fn:data($consultaOfertaCreditoConsumoResponse/*:return/*:numeroSolicitud)}</ns2:CaseId>
            <ns2:GeneralRci>{fn:data($consultaOfertaCreditoConsumoResponse/*:return/*:RCI)}</ns2:GeneralRci>
            <ns2:GeneralRciMax>{fn:data($consultaOfertaCreditoConsumoResponse/return/RCIMax)}</ns2:GeneralRciMax>
            <ns2:GeneralCurrentNde>{xs:float(fn:data($consultaOfertaCreditoConsumoResponse/return/NDEActual))}</ns2:GeneralCurrentNde>
            <ns2:GeneralFinalNde>{xs:float(fn:data($consultaOfertaCreditoConsumoResponse/return/NDEFinal))}</ns2:GeneralFinalNde>
            <ns2:CreditCardScore>{xs:float(fn:data($consultaOfertaCreditoConsumoResponse/return/behaviorScoreTC))}</ns2:CreditCardScore>
            <ns2:InternalScore>{ xs:float(data($consultaOfertaCreditoConsumoResponse/return/score/score)) }</ns2:InternalScore>
            <ns2:CreditCardRiskLevel>{ xs:string(data($consultaOfertaCreditoConsumoResponse/return/nivelRiesgoTC)) }</ns2:CreditCardRiskLevel>
            <ns2:InternalRiskLevel>{ xs:string(data($consultaOfertaCreditoConsumoResponse/return/score/nivelRiesgo)) }</ns2:InternalRiskLevel>
            <ns2:ExternalRiskLevel>{ xs:string(data($consultaOfertaCreditoConsumoResponse/return/calificacionBuro)) }</ns2:ExternalRiskLevel>
            <ns2:CustomerSegment>{ xs:string(data($consultaOfertaCreditoConsumoResponse/return/segmentoCliente)) }</ns2:CustomerSegment>
            <ns2:CustomerSubsegment>{ xs:string(data($consultaOfertaCreditoConsumoResponse/return/subSegmentoCliente)) }</ns2:CustomerSubsegment>
            <ns2:CurrentExposure>{ xs:float(data($consultaOfertaCreditoConsumoResponse/return/exposicionActual)) }</ns2:CurrentExposure>
            <ns2:GlobalExposureLocalCcy>{fn:data($consultaOfertaCreditoConsumoResponse/return/exposicionGlobal) }</ns2:GlobalExposureLocalCcy>
            <ns2:GlobalExposureForeignCcy>{ xs:float(data($consultaOfertaCreditoConsumoResponse/return/exposicionGlobalUSD)) }</ns2:GlobalExposureForeignCcy>
            <ns2:CreditCardOverdraft>{ xs:float(data($consultaOfertaCreditoConsumoResponse/return/noSobregiroTC)) }</ns2:CreditCardOverdraft>
            <ns2:CreditReferences>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/noReferenciasCrediticias)) }</ns2:CreditReferences>
            <ns2:InternalLoanReferences>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/noReferenciasPtmo)) }</ns2:InternalLoanReferences>
            <ns2:RewriteReferences>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/noReferenciasSR)) }</ns2:RewriteReferences>
            <ns2:TotalExtra>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/totalExtrafinanciamientos)) }</ns2:TotalExtra>
            <ns2:TotalRisk>{ xs:float(data($consultaOfertaCreditoConsumoResponse/return/riesgoTotal)) }</ns2:TotalRisk>
            <ns2:CurrentArrear>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/moraActualInterna)) }</ns2:CurrentArrear>
            <ns2:CurrentArrearBalance>{ xs:float(data($consultaOfertaCreditoConsumoResponse/return/saldoMoraActualInterna)) }</ns2:CurrentArrearBalance>
            <ns2:CreditExperience>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/expCrediticia)) }</ns2:CreditExperience>
            <ns2:ArrearOn60DaysFor6Months>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/vecesMora60_6m)) }</ns2:ArrearOn60DaysFor6Months>
            <ns2:ArrearOn60DaysFor12Months>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/vecesMora60_12m)) }</ns2:ArrearOn60DaysFor12Months>
            <ns2:ArrearOn90DaysFor12Months>{ xs:int(data($consultaOfertaCreditoConsumoResponse/return/vecesMora90_12m)) }</ns2:ArrearOn90DaysFor12Months>
            <ns2:Resolutions>
            {
               for $resolutions in $consultaOfertaCreditoConsumoResponse/return/oferta/arrayResolucion
               return              
                <ns2:Resolution>
                    <ns2:ResolutionId>{ xs:string(data($resolutions/codResolucion)) }</ns2:ResolutionId>
                    <ns2:ResolutionDescription>{ xs:string(data($resolutions/descripcionResolucion)) }</ns2:ResolutionDescription>
                </ns2:Resolution>
             }
             </ns2:Resolutions>
            <ns2:ResolutionOffers>
                {
                    for $oferta in $consultaOfertaCreditoConsumoResponse/return/oferta
                    return            
                <ns2:Offer>
                                            {
                                for $codProducto in $oferta/codProducto
                                return
                    <ns2:ProductCode>{ xs:string(data($codProducto)) }</ns2:ProductCode>
                   } 
                    <ns2:Rate>{ xs:float(data($oferta/tasa)) }</ns2:Rate>
                    <ns2:Installment>{ xs:float(data($oferta/cuota)) }</ns2:Installment>
                    <ns2:InstallmentNde>{ xs:float(data($oferta/cuotaNDE)) }</ns2:InstallmentNde>
                    <ns2:InstallmentRciNonp2c>{ xs:float(data($oferta/cuotaRCI_NONP2C)) }</ns2:InstallmentRciNonp2c>
                    <ns2:InstallmentRciP2c>{ xs:float(data($oferta/cuotaRCI_P2C)) }</ns2:InstallmentRciP2c>
                    <ns2:For12Months>{ xs:float(data($oferta/monto12)) }</ns2:For12Months>
                    <ns2:For18Months>{ xs:float(data($oferta/monto18)) }</ns2:For18Months>
                    <ns2:For24Months>{ xs:float(data($oferta/monto24)) }</ns2:For24Months>
                    <ns2:For36Months>{ xs:float(data($oferta/monto36)) }</ns2:For36Months>
                    <ns2:For48Months>{ xs:float(data($oferta/monto48)) }</ns2:For48Months>
                    <ns2:For60Months>{ xs:float(data($oferta/monto60)) }</ns2:For60Months>
                    <ns2:ForMaxAmount>{ xs:float(data($oferta/montoMax)) }</ns2:ForMaxAmount>
                    <ns2:MegOffer>{ xs:float(data($oferta/ofertaMEG)) }</ns2:MegOffer>
                    <ns2:MaxOffer>{fn:data($oferta/ofertaMax)}</ns2:MaxOffer>
                    <ns2:NdeOffer>{ xs:float(data($oferta/ofertaNDE)) }</ns2:NdeOffer>
                    <ns2:Nonp2cOffer>{ xs:float(data($oferta/ofertaNonP2c)) }</ns2:Nonp2cOffer>
                    <ns2:P2cOffer>{ xs:float(data($oferta/ofertaP2C)) }</ns2:P2cOffer>
                    <ns2:RciOffer>{ xs:float(data($oferta/ofertaRCI)) }</ns2:RciOffer>
                    <ns2:TimesincomeOffer>{ xs:float(data($oferta/ofertaTimesIncome)) }</ns2:TimesincomeOffer>
                    <ns2:Rci>{ xs:float(data($oferta/RCI)) }</ns2:Rci>
                    <ns2:Timesincome>{ xs:int(data($oferta/timesIncome)) }</ns2:Timesincome>
                </ns2:Offer>
            }    
            </ns2:ResolutionOffers>
            <ns2:CreditCards>
            {
                    for $CREDIT_CARD in $consultaOfertaCreditoConsumoResponse/return/tarjetas
                    return
            <ns2:CreditCard>
                {
                    for $codbloqueo1 in $CREDIT_CARD/codbloqueo1
                    return
                        <ns2:LockCode1>{ data($codbloqueo1) }</ns2:LockCode1>
                }
                {
                    for $codbloqueo2 in $CREDIT_CARD/codbloqueo2
                    return
                        <ns2:LockCode2>{ data($codbloqueo2) }</ns2:LockCode2>
                }
                {
                    for $grupoAfinidad in $CREDIT_CARD/grupoAfinidad
                    return
                        <ns2:Logo>{ data($grupoAfinidad) }</ns2:Logo>
                }
                {
                    for $cash_diponible in $CREDIT_CARD/cash_diponible
                    return
                        <ns2:AvailableCash>{ data($cash_diponible) }</ns2:AvailableCash>
                }
                {
                    for $fechabloqueo1 in $CREDIT_CARD/fechabloqueo1
                    return
                        <ns2:LockDate1>{ data($fechabloqueo1) }</ns2:LockDate1>
                }
                {
                    for $fechabloqueo2 in $CREDIT_CARD/fechabloqueo2
                    return
                        <ns2:LockDate2>{ data($fechabloqueo2) }</ns2:LockDate2>
                }              
                
                <ns2:TransactionCreditCardType>
                {
			        for $TRANSACTION in $CREDIT_CARD/transaccionesTarjeta
                    return
                    <ns2:Transaction>
                    	{
		                    for $cuota_extra in $TRANSACTION/cuota_extra
		                    return
		                        <ns2:ExtraFee>{ data($cuota_extra) }</ns2:ExtraFee>
                		}    
                    	{
		                    for $cuota_intra in $TRANSACTION/cuota_intra
		                    return
		                        <ns2:IntraFee>{ data($cuota_intra) }</ns2:IntraFee>
                		}
                		{
		                    for $saldo_extra in $TRANSACTION/saldo_extra
		                    return
		                        <ns2:ExtraBalance>{ data($saldo_extra) }</ns2:ExtraBalance>
                		}
                		{
		                    for $saldo_intra in $TRANSACTION/saldo_intra
		                    return
		                        <ns2:IntraBalance>{ data($saldo_intra) }</ns2:IntraBalance>
                		}
                    </ns2:Transaction>
                    }
                </ns2:TransactionCreditCardType>
            </ns2:CreditCard>
            }
            </ns2:CreditCards>
        </ns2:GetCreditOffers>
    </ns2:getCreditOffersResponse>
};

xq:Tx_BLAZE_To_GetCreditOffersResponse($consultaOfertaCreditoConsumoResponse,$uuid)