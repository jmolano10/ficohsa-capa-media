xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultaCargaArchivoDAT/xsd/consultaCargaArchivoDAT_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCargaArchivoDATResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCargaArchivoDAT";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargaArchivoDAT/xq/consultaCargaArchivoDATOut/";

declare function xf:consultaCargaArchivoDATOut($outputParameters1 as element(ns1:OutputParameters),
    $bankBatchId as xs:string)
    as element(ns0:consultaCargaArchivoDATResponse) {
        <ns0:consultaCargaArchivoDATResponse>
            <BANK_BATCH_ID>{ data($bankBatchId) }</BANK_BATCH_ID>
            <RTN>{ data($outputParameters1/ns1:PV_RTN) }</RTN>
            {
                for $PD_FECHAPRESEN in $outputParameters1/ns1:PD_FECHAPRESEN
                return
                    <PRESENTATION_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($PD_FECHAPRESEN)),()) }</PRESENTATION_DATE>
            }
            {
                for $PV_IDDECLARACION in $outputParameters1/ns1:PV_IDDECLARACION
                return
                    <DECLARATION_ID>{ data($PV_IDDECLARACION) }</DECLARATION_ID>
            }
            {
                for $PV_PERIODO in $outputParameters1/ns1:PV_PERIODO
                return
                    <PERIOD>{ data($PV_PERIODO) }</PERIOD>
            }
            {
                for $PN_IDIMP in $outputParameters1/ns1:PN_IDIMP
                return
                    <TAX_ID>{ data($PN_IDIMP) }</TAX_ID>
            }
            {
                for $PV_IDIMP_DESC in $outputParameters1/ns1:PV_DESIMPUESTO
                return
                    <TAX_DESCRIPTION>{ data($PV_IDIMP_DESC) }</TAX_DESCRIPTION>
            }
            {
                for $PN_CONCEPTOIMP in $outputParameters1/ns1:PN_CONCEPTOIMP
                return
                    <CONCEPT_ID>{ data($PN_CONCEPTOIMP) }</CONCEPT_ID>
            }
            {
                for $PV_CONCEPTOIMP_DESC in $outputParameters1/ns1:PV_DESCONCEPTO
                return
                    <CONCEPT_DESCRIPTION>{ data($PV_CONCEPTOIMP_DESC) }</CONCEPT_DESCRIPTION>
            }
            {
                for $PN_PAGOIMP in $outputParameters1/ns1:PN_PAGOIMP
                return
                    <TAX_PAYMENT>{ data($PN_PAGOIMP) }</TAX_PAYMENT>
            }
            {
                for $PN_MULTA in $outputParameters1/ns1:PN_MULTA
                return
                    <PENALTY_FEE>{ data($PN_MULTA) }</PENALTY_FEE>
            }
            {
                for $PN_RECARGO in $outputParameters1/ns1:PN_RECARGO
                return
                    <SURCHARGE_PAYMENT>{ data($PN_RECARGO) }</SURCHARGE_PAYMENT>
            }
            {
                for $PN_INTERESES in $outputParameters1/ns1:PN_INTERESES
                return
                    <TAX_INTEREST>{ data($PN_INTERESES) }</TAX_INTEREST>
            }
            {
                for $PN_TOTALAPAGAR in $outputParameters1/ns1:PN_TOTALAPAGAR
                return
                    <TOTAL_PAYMENT>{ data($PN_TOTALAPAGAR) }</TOTAL_PAYMENT>
            }
            {
                for $PN_TOTALINFORMATIVO in $outputParameters1/ns1:PN_TOTALINFORMATIVO
                return
                    <TOTAL_PRESENTED>{ data($PN_TOTALINFORMATIVO) }</TOTAL_PRESENTED>
            }
             <PAYMENT_DETAILS>
                {
                    for $i in 1 to count($outputParameters1/ns1:PT_CODIMPUESTO/ns1:ITEM)
                    return
                        <PAYMENT_DETAIL>
                            <TAX_XML>{ data($outputParameters1/ns1:PT_CODIMPUESTOXML/ns1:ITEM[$i]) }</TAX_XML>
                            <TAX>{ data($outputParameters1/ns1:PT_CODIMPUESTO/ns1:ITEM[$i]) }</TAX>
                            <CONCEPT>{ data($outputParameters1/ns1:PT_CONCEPTO/ns1:ITEM[$i]) }</CONCEPT>
                            <SUB_CONCEPT>{ data($outputParameters1/ns1:PT_SUBCONCEPTO/ns1:ITEM[$i]) }</SUB_CONCEPT>
                            <DESCRIPTION>{ data($outputParameters1/ns1:PT_DESCRIPCIONIMPUESTO/ns1:ITEM[$i]) }</DESCRIPTION>         
                            <AMOUNT>{ data($outputParameters1/ns1:PT_VALORIMPORTE/ns1:ITEM[$i]) }</AMOUNT>               
                        </PAYMENT_DETAIL>
                    
                }
            </PAYMENT_DETAILS>
        </ns0:consultaCargaArchivoDATResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $bankBatchId as xs:string external;

xf:consultaCargaArchivoDATOut($outputParameters1,
    $bankBatchId)