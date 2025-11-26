xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://package.name.in.reverse.order";
(:: import schema at "../../../../../ProviderServices/WSDL/GetCustomerOffers/RuleServiceDefinitionOriginacionesGTService.wsdl" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/creditManagement";
(:: import schema at "../../../../../../MWBanking/CreditManagement/RequestorServices/XSD/creditManagement.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $consultaOfertaCreditoConsumoResponse as element() (:: schema-element(ns1:epOriginacionesGuatemalaResponse) ::) external;

declare function xq:Tx_BLAZE_To_GetCreditOffersResponse($consultaOfertaCreditoConsumoResponse as element() (:: schema-element(ns1:epOriginacionesGuatemalaResponse) ::),$uuid as xs:string) as element() (:: schema-element(ns2:getCreditOffersResponse) ::) {
    <ns2:getCreditOffersResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:GetCreditOffers>
            {
                for $CaseId in $consultaOfertaCreditoConsumoResponse/return/noSolicitud
                return
                <ns2:CaseId>{fn:data($CaseId)}</ns2:CaseId>
            }
            {
                for $GeneralRci in $consultaOfertaCreditoConsumoResponse/return/accion/RCIFinal
                return
                <ns2:GeneralRci>{fn:data($GeneralRci)}</ns2:GeneralRci>
            }
            {
                for $GeneralRciMax in $consultaOfertaCreditoConsumoResponse/return/accion/RCIMax
                return
                <ns2:GeneralRciMax>{fn:data($GeneralRciMax)}</ns2:GeneralRciMax>
            }
            {
                for $GeneralCurrentNde in $consultaOfertaCreditoConsumoResponse/return/accion/niveldeEndeudamientoActual
                return
                <ns2:GeneralCurrentNde>{fn:data($GeneralCurrentNde)}</ns2:GeneralCurrentNde>
            }
            {
                for $GeneralFinalNde in $consultaOfertaCreditoConsumoResponse/return/accion/niveldeEndeudamientoFinal
                return
                <ns2:GeneralFinalNde>{fn:data($GeneralFinalNde)}</ns2:GeneralFinalNde>
            }
            {
                for $CreditCardScore in $consultaOfertaCreditoConsumoResponse/return/accion/scoreTarjetadeCredito
                return
                <ns2:CreditCardScore>{fn:data($CreditCardScore)}</ns2:CreditCardScore>
            }
            {
                for $InternalScore in $consultaOfertaCreditoConsumoResponse/return/score/score
                return
                <ns2:InternalScore>{fn:data($InternalScore)}</ns2:InternalScore>
            }
            {
                for $CreditCardRiskLevel in $consultaOfertaCreditoConsumoResponse/return/accion/nivelRiesgoTarjetaCredito
                return
                <ns2:CreditCardRiskLevel>{fn:data($CreditCardRiskLevel)}</ns2:CreditCardRiskLevel>
            }
            {
                for $InternalRiskLevel in $consultaOfertaCreditoConsumoResponse/return/score/nivelRiesgo
                return
                <ns2:InternalRiskLevel>{fn:data($InternalRiskLevel)}</ns2:InternalRiskLevel>
            }
            {
                for $ExternalRiskLevel in $consultaOfertaCreditoConsumoResponse/return/accion/nivelRiesgoExterno
                return
                <ns2:ExternalRiskLevel>{fn:data($ExternalRiskLevel)}</ns2:ExternalRiskLevel>
            }
            {
                for $CustomerSegment in $consultaOfertaCreditoConsumoResponse/return/accion/segmentoCliente
                return
                <ns2:CustomerSegment>{fn:data($CustomerSegment)}</ns2:CustomerSegment>
            }
            {
                for $CustomerSubsegment in $consultaOfertaCreditoConsumoResponse/return/accion/subSegmentoCliente
                return
                <ns2:CustomerSubsegment>{fn:data($CustomerSubsegment)}</ns2:CustomerSubsegment>
            }
            {
                for $CurrentExposure in $consultaOfertaCreditoConsumoResponse/return/accion/exposicionGlobal
                return
                <ns2:CurrentExposure>{fn:data($CurrentExposure)}</ns2:CurrentExposure>
            }
            {
                for $GlobalExposureLocalCcy in $consultaOfertaCreditoConsumoResponse/return/accion/exposicionActualLOC
                return
                <ns2:GlobalExposureLocalCcy>{fn:data($GlobalExposureLocalCcy)}</ns2:GlobalExposureLocalCcy>
            }
            {
                for $GlobalExposureForeignCcy in $consultaOfertaCreditoConsumoResponse/return/accion/exposicionActualUSD
                return
                <ns2:GlobalExposureForeignCcy>{fn:data($GlobalExposureForeignCcy)}</ns2:GlobalExposureForeignCcy>
            }
            {
                for $CreditCardOverdraft in $consultaOfertaCreditoConsumoResponse/return/accion/sobregiroEnTarjetaDeCredito
                return
                <ns2:CreditCardOverdraft>{fn:data($CreditCardOverdraft)}</ns2:CreditCardOverdraft>
            }
            {
                for $CreditReferences in $consultaOfertaCreditoConsumoResponse/return/accion/cantidadDeReferencias
                return
                <ns2:CreditReferences>{fn:data($CreditReferences)}</ns2:CreditReferences>
            }
            {
                for $InternalLoanReferences in $consultaOfertaCreditoConsumoResponse/return/accion/cantidadDePrestamosInternos
                return
                <ns2:InternalLoanReferences>{fn:data($InternalLoanReferences)}</ns2:InternalLoanReferences>
            }
            {
                for $RewriteReferences in $consultaOfertaCreditoConsumoResponse/return/accion/referenciasDeCastigo
                return
                <ns2:RewriteReferences>{fn:data($RewriteReferences)}</ns2:RewriteReferences>
            }
            {
                for $TotalExtra in $consultaOfertaCreditoConsumoResponse/return/accion/totalSaldoExtrafinanciamiento
                return
                <ns2:TotalExtra>{fn:data($TotalExtra)}</ns2:TotalExtra>
            }
            {
                for $TotalRisk in $consultaOfertaCreditoConsumoResponse/return/accion/riesgoTotal
                return
                <ns2:TotalRisk>{fn:data($TotalRisk)}</ns2:TotalRisk>
            }
            {
                for $CurrentArrear in $consultaOfertaCreditoConsumoResponse/return/accion/moraMaxima
                return
                <ns2:CurrentArrear>{fn:data($CurrentArrear)}</ns2:CurrentArrear>
            }
            {
                for $CurrentArrearBalance in $consultaOfertaCreditoConsumoResponse/return/accion/saldoEnMora
                return
                <ns2:CurrentArrearBalance>{fn:data($CurrentArrearBalance)}</ns2:CurrentArrearBalance>
            }
            {
                for $CreditExperience in $consultaOfertaCreditoConsumoResponse/return/accion/experienciaCrediticia
                return
                <ns2:CreditExperience>{fn:data($CreditExperience)}</ns2:CreditExperience>
            }
            {
                for $ArrearOn60DaysFor6Months in $consultaOfertaCreditoConsumoResponse/return/accion/cantidadVecesMora606M
                return
                <ns2:ArrearOn60DaysFor6Months>{fn:data($ArrearOn60DaysFor6Months)}</ns2:ArrearOn60DaysFor6Months>
            }
            {
                for $ArrearOn60DaysFor12Months in $consultaOfertaCreditoConsumoResponse/return/accion/cantidadVecesMora6012M
                return
                <ns2:ArrearOn60DaysFor12Months>{fn:data($ArrearOn60DaysFor12Months)}</ns2:ArrearOn60DaysFor12Months>
            }
            {
                for $ArrearOn90DaysFor12Months in $consultaOfertaCreditoConsumoResponse/return/accion/cantidadVecesMora9012M
                return
                <ns2:ArrearOn90DaysFor12Months>{fn:data($ArrearOn90DaysFor12Months)}</ns2:ArrearOn90DaysFor12Months>
            }
            {
                if(fn:exists($consultaOfertaCreditoConsumoResponse/return/oferta/resolucion)) then (
                    <ns2:Resolutions>
                    {
                        for $Resolution in $consultaOfertaCreditoConsumoResponse/return/oferta/resolucion
                        return(
                            <ns2:Resolution>
                            {
                                for $ResolutionId in $Resolution/codigoResolucion
                                return
                                <ns2:ResolutionId>{fn:data($ResolutionId)}</ns2:ResolutionId>
                            }
                            {
                                for $ResolutionDescription in $Resolution/descripcion
                                return
                                <ns2:ResolutionDescription>{fn:data($ResolutionDescription)}</ns2:ResolutionDescription>
                            }
                            </ns2:Resolution>
                        )
                    }
                    </ns2:Resolutions>
                ) else ()
            }
            {
                if(fn:exists($consultaOfertaCreditoConsumoResponse/return/oferta)) then (
                    <ns2:ResolutionOffers>
                    {
                        for $Offer in $consultaOfertaCreditoConsumoResponse/return/oferta
                        return(
                            <ns2:Offer>
                            {
                                for $ProductCode in $Offer/codigoProducto
                                return
                                <ns2:ProductCode>{fn:data($ProductCode)}</ns2:ProductCode>
                            }
                            {
                                for $Rate in $Offer/tasa
                                return
                                <ns2:Rate>{fn:data($Rate)}</ns2:Rate>
                            }
                            {
                                for $Installment in $Offer/cuota
                                return
                                <ns2:Installment>{fn:data($Installment)}</ns2:Installment>
                            }
                            {
                                for $InstallmentNde in $Offer/cuotaNDE
                                return
                                <ns2:InstallmentNde>{fn:data($InstallmentNde)}</ns2:InstallmentNde>
                            }
                            {
                                for $InstallmentRciNonp2c in $Offer/cuotaRCINONP2C
                                return
                                <ns2:InstallmentRciNonp2c>{fn:data($InstallmentRciNonp2c)}</ns2:InstallmentRciNonp2c>
                            }
                            {
                                for $InstallmentRciP2c in $Offer/cuotaRCIP2C
                                return
                                <ns2:InstallmentRciP2c>{fn:data($InstallmentRciP2c)}</ns2:InstallmentRciP2c>
                            }
                            {
                                for $For12Months in $Offer/monto12
                                return
                                <ns2:For12Months>{fn:data($For12Months)}</ns2:For12Months>
                            }
                            {
                                for $For18Months in $Offer/monto18
                                return
                                <ns2:For18Months>{fn:data($For18Months)}</ns2:For18Months>
                            }
                            {
                                for $For24Months in $Offer/monto24
                                return
                                <ns2:For24Months>{fn:data($For24Months)}</ns2:For24Months>
                            }
                            {
                                for $For36Months in $Offer/monto36
                                return
                                <ns2:For36Months>{fn:data($For36Months)}</ns2:For36Months>
                            }
                            {
                                for $For48Months in $Offer/monto48
                                return
                                <ns2:For48Months>{fn:data($For48Months)}</ns2:For48Months>
                            }
                            {
                                for $For60Months in $Offer/monto60
                                return
                                <ns2:For60Months>{fn:data($For60Months)}</ns2:For60Months>
                            }
                            {
                                for $For72Months in $Offer/monto72
                                return
                                <ns2:For72Months>{fn:data($For72Months)}</ns2:For72Months>
                            }
                            {
                                for $For84Months in $Offer/monto84
                                return
                                <ns2:For84Months>{fn:data($For84Months)}</ns2:For84Months>
                            }
                            {
                                for $For96Months in $Offer/monto96
                                return
                                <ns2:For96Months>{fn:data($For96Months)}</ns2:For96Months>
                            }
                            {
                                for $For108Months in $Offer/monto108
                                return
                                <ns2:For108Months>{fn:data($For108Months)}</ns2:For108Months>
                            }
                            {
                                for $For120Months in $Offer/monto120
                                return
                                <ns2:For120Months>{fn:data($For120Months)}</ns2:For120Months>
                            }
                            {
                                for $ForMaxAmount in $Offer/montoMax
                                return
                                <ns2:ForMaxAmount>{fn:data($ForMaxAmount)}</ns2:ForMaxAmount>
                            }
                            {
                                for $MegOffer in $Offer/montoMEG
                                return
                                <ns2:MegOffer>{fn:data($MegOffer)}</ns2:MegOffer>
                            }
                            {
                                for $MaxOffer in $Offer/ofertaMax
                                return
                                <ns2:MaxOffer>{fn:data($MaxOffer)}</ns2:MaxOffer>
                            }
                            {
                                for $NdeOffer in $Offer/montoNDE
                                return
                                <ns2:NdeOffer>{fn:data($NdeOffer)}</ns2:NdeOffer>
                            }
                            {
                                for $Nonp2cOffer in $Offer/montoNONP2C
                                return
                                <ns2:Nonp2cOffer>{fn:data($Nonp2cOffer)}</ns2:Nonp2cOffer>
                            }
                            {
                                for $P2cOffer in $Offer/montoP2C
                                return
                                <ns2:P2cOffer>{fn:data($P2cOffer)}</ns2:P2cOffer>
                            }
                            {
                                for $RciOffer in $Offer/montoRCI
                                return
                                <ns2:RciOffer>{fn:data($RciOffer)}</ns2:RciOffer>
                            }
                            {
                                for $TimesincomeOffer in $Offer/montoTimesIncome
                                return
                                <ns2:TimesincomeOffer>{fn:data($TimesincomeOffer)}</ns2:TimesincomeOffer>
                            }
                            {
                                for $Rci in $Offer/RCI
                                return
                                <ns2:Rci>{fn:data($Rci)}</ns2:Rci>
                            }
                            {
                                for $Timesincome in $Offer/timesIncome
                                return
                                <ns2:Timesincome>{fn:data($Timesincome)}</ns2:Timesincome>
                            }
                            </ns2:Offer>
                        )
                    }
                    </ns2:ResolutionOffers>
                ) else ()
            }
            {
                if(fn:exists($consultaOfertaCreditoConsumoResponse/return/tarjeta)) then (
                    <ns2:CreditCards>
                    {
                        for $CreditCard in $consultaOfertaCreditoConsumoResponse/return/tarjeta
                        return(
                            <ns2:CreditCard>
                            {
                                for $LockCode1 in $CreditCard/codbloqueo1
                                return
                                <ns2:LockCode1>{fn:data($LockCode1)}</ns2:LockCode1>
                            }
                            {
                                for $LockCode2 in $CreditCard/codbloqueo2
                                return
                                <ns2:LockCode2>{fn:data($LockCode2)}</ns2:LockCode2>
                            }
                            {
                                for $Logo in $CreditCard/logo
                                return
                                <ns2:Logo>{fn:data($Logo)}</ns2:Logo>
                            }
                            {
                                for $AvailableCash in $CreditCard/diponibleCompras
                                return
                                <ns2:AvailableCash>{fn:data($AvailableCash)}</ns2:AvailableCash>
                            }
                            {
                                for $LockDate1 in $CreditCard/fechaBloqueo1
                                return
                                <ns2:LockDate1>{fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", fn:data($LockDate1))}</ns2:LockDate1>
                            }
                            {
                                for $LockDate2 in $CreditCard/fechaBloqueo2
                                return
                                <ns2:LockDate2>{fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", fn:data($LockDate2))}</ns2:LockDate2>
                            }
                            </ns2:CreditCard>
                        )
                    }
                    </ns2:CreditCards>
                ) else ()
            }
        </ns2:GetCreditOffers>
    </ns2:getCreditOffersResponse>
};

xq:Tx_BLAZE_To_GetCreditOffersResponse($consultaOfertaCreditoConsumoResponse,$uuid)