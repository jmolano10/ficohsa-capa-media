xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosFinanciamientosCancelacionAnticipadaResponse" element="ns1:ConsultaSaldosFinanciamientosCancelacionAnticipadaResponse" location="../../../../External/Outgoing/BusinessServices/Salesforce/consultaCancelacionAnticipadaFinanciamiento/wsdl/consultaCancelacionAnticipadaFinanciamiento.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaCancelacionAnticipadaFinanciamientoResponse" location="../xsd/consultaCancelacionAnticipadaFinanciamientoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCancelacionAnticipadaFinanciamientoTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCancelacionAnticipadaFinanciamiento/xq/consultaCancelacionAnticipadaFinanciamientoOut/";

declare function xf:consultaCancelacionAnticipadaFinanciamientoOut($consultaSaldosFinanciamientosCancelacionAnticipadaResponse as element(ns1:ConsultaSaldosFinanciamientosCancelacionAnticipadaResponse))
    as element(ns0:consultaCancelacionAnticipadaFinanciamientoResponse) {
        <ns0:consultaCancelacionAnticipadaFinanciamientoResponse>
            <GENERAL_INFO>
                <TOTAL_EXTRA>
                    <LOCAL_CURRENCY>{ string(data($consultaSaldosFinanciamientosCancelacionAnticipadaResponse/ns1:result/ns1:body/ns1:calculoCancelacionAnticipada/ns1:totalExtraLPS/text())) }</LOCAL_CURRENCY>
                    <FOREIGN_CURRENCY>{ data($consultaSaldosFinanciamientosCancelacionAnticipadaResponse/ns1:result/ns1:body/ns1:calculoCancelacionAnticipada/ns1:totalExtraUSD) }</FOREIGN_CURRENCY>
                </TOTAL_EXTRA>
                <TOTAL_INTRA>
                    <LOCAL_CURRENCY>{ data($consultaSaldosFinanciamientosCancelacionAnticipadaResponse/ns1:result/ns1:body/ns1:calculoCancelacionAnticipada/ns1:totalIntraLPS) }</LOCAL_CURRENCY>
                    <FOREIGN_CURRENCY>{ data($consultaSaldosFinanciamientosCancelacionAnticipadaResponse/ns1:result/ns1:body/ns1:calculoCancelacionAnticipada/ns1:totalIntraUSD) }</FOREIGN_CURRENCY>
                </TOTAL_INTRA>
            </GENERAL_INFO>
            <FINANCING_DETAILS>
                {
                for $listaFinanciamientos in $consultaSaldosFinanciamientosCancelacionAnticipadaResponse/ns1:result/ns1:body/ns1:listaFinanciamientos
                return
                    <FINANCING_ITEM>
                        <ID>{ data($listaFinanciamientos/ns1:comprobante) }</ID>
                        <TYPE>{ data($listaFinanciamientos/ns1:tipoFinanciamiento) }</TYPE>
                        <INSTALLMENTS_COUNT>{ data($listaFinanciamientos/ns1:cantidadCuotas) }</INSTALLMENTS_COUNT>
                        <INSTALLMENT_AMOUNT>{ data($listaFinanciamientos/ns1:cuota) }</INSTALLMENT_AMOUNT>
                        <NEXT_INSTALLMENT>{ data($listaFinanciamientos/ns1:siguienteCuota) }</NEXT_INSTALLMENT>
                        <PENDING_PRINCIPAL>{ data($listaFinanciamientos/ns1:capitalPendiente) }</PENDING_PRINCIPAL>
                        <CYCLE>{ data($listaFinanciamientos/ns1:ciclo) }</CYCLE>
                        <CUT>{ data($listaFinanciamientos/ns1:CUT) }</CUT>
                        <PLACEMENT_DATE>{ data($listaFinanciamientos/ns1:fechaColocacion) }</PLACEMENT_DATE>
                        <CUT_DATE>{ data($listaFinanciamientos/ns1:fechaCorte) }</CUT_DATE>
                        <PAYMENT_DATE>{ data($listaFinanciamientos/ns1:fechaPago) }</PAYMENT_DATE>
                        <CURRENCY>{ data($listaFinanciamientos/ns1:moneda) }</CURRENCY>
                        <AMOUNT>{ data($listaFinanciamientos/ns1:monto) }</AMOUNT>
                        <ANTICIPATED_CANCELLATION_AMOUNT>{ data($listaFinanciamientos/ns1:montoCancelacionAnticipada) }</ANTICIPATED_CANCELLATION_AMOUNT>
                        <RATE>{ data($listaFinanciamientos/ns1:tasa) }</RATE>
                    </FINANCING_ITEM>
	            }
            </FINANCING_DETAILS>
        </ns0:consultaCancelacionAnticipadaFinanciamientoResponse>
};

declare variable $consultaSaldosFinanciamientosCancelacionAnticipadaResponse as element(ns1:ConsultaSaldosFinanciamientosCancelacionAnticipadaResponse) external;

xf:consultaCancelacionAnticipadaFinanciamientoOut($consultaSaldosFinanciamientosCancelacionAnticipadaResponse)