(:: pragma bea:global-element-parameter parameter="$consultaRecaudoRespuesta" element="ns0:consultaRecaudoRespuesta" location="../../../BusinessServices/CTS/convenio/xsd/services.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns4:consultaRecaudo" location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns4:consultaRecaudoResponse" location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns5 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns0 = "http://service.srvaplcobisrecaudo.ecobis.cobiscorp";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudoNI";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoNI/xq/consultaRecaudoNIOut/";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:consultaRecaudoNIOut($consultaRecaudoRespuesta as element(ns0:consultaRecaudoRespuesta),
    $outputParameters as element(ns2:OutputParameters),
    $consultaRecaudo as element(ns4:consultaRecaudo))
    as element(ns4:consultaRecaudoResponse) {
        <ns4:consultaRecaudoResponse>
            <CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</CONTRACT_ID>
            {
                for $PV_NOMBRECONVENIO in $outputParameters/ns2:PV_NOMBRECONVENIO
                return
                    <CONTRACT_NAME>{ data($PV_NOMBRECONVENIO) }</CONTRACT_NAME>
            }
            <DEBTOR_CODE>{ data($consultaRecaudo/DEBTOR_CODE) }</DEBTOR_CODE>
            {
                for $debtorName in $consultaRecaudoRespuesta/ns1:debtorName
                return
                    <DEBTOR_NAME>{ data($debtorName) }</DEBTOR_NAME>
            }
            {
                for $billDetail in $consultaRecaudoRespuesta/ns1:billDetail
                return
                    <BILL_DETAIL>{ data($billDetail) }</BILL_DETAIL>
            }
            {
                for $bills in $consultaRecaudoRespuesta/ns1:bills
                return
                    <BILLS>
                        {
                            for $billRecord in $bills/ns1:billRecord
                            return
                                <BILL_RECORD>
                                    {
                                        for $billNumber in $billRecord/ns1:billNumber
                                        return
                                            <BILL_NUMBER>{ data($billNumber) }</BILL_NUMBER>
                                    }
                                    {
                                        for $billCurrency in $billRecord/ns1:billCurrency
                                        return
                                            <BILL_CURRENCY>{ data($billCurrency) }</BILL_CURRENCY>
                                    }
                                    {
                                        for $billDate in $billRecord/ns1:billDate
                                        return
                                            <BILL_DATE>{ data($billDate) }</BILL_DATE>
                                    }
                                    {
                                        for $dueDate in $billRecord/ns1:dueDate
                                        return
                                            <DUE_DATE>{ data($dueDate) }</DUE_DATE>
                                    }
                                    {
                                        for $billAmount in $billRecord/ns1:billAmount
                                        return
                                            <BILL_AMOUNT>{ data($billAmount) }</BILL_AMOUNT>
                                    }
                                    {
                                        for $lateFee in $billRecord/ns1:lateFee
                                        return
                                            <LATE_FEE>{ data($lateFee) }</LATE_FEE>
                                    }
                                    {
                                        for $totalAmountLoc in $billRecord/ns1:totalAmountLoc
                                        return
                                            <TOTAL_AMOUNT_LOC>{ data($totalAmountLoc) }</TOTAL_AMOUNT_LOC>
                                    }
                                    {
                                        for $totalAmountUsd in $billRecord/ns1:totalAmountUsd
                                        return
                                            <TOTAL_AMOUNT_USD>{ data($totalAmountUsd) }</TOTAL_AMOUNT_USD>
                                    }
                                    {
                                        for $billDescription in $billRecord/ns1:billDescription
                                        return
                                            <BILL_DESCRIPTION>{ data($billDescription) }</BILL_DESCRIPTION>
                                    }
                                </BILL_RECORD>
                        }
                    </BILLS>
            }
        </ns4:consultaRecaudoResponse>
};

declare variable $consultaRecaudoRespuesta as element(ns0:consultaRecaudoRespuesta) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $consultaRecaudo as element(ns4:consultaRecaudo) external;

xf:consultaRecaudoNIOut($consultaRecaudoRespuesta,
    $outputParameters,
    $consultaRecaudo)