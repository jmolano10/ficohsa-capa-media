(:: pragma bea:global-element-parameter parameter="$consultaCargaArchivoDATResponse1" element="ns0:consultaCargaArchivoDATResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cargaArchivoDATResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoDAT/xq/cargaArchivoOut/";

declare function xf:cargaArchivoOut($consultaCargaArchivoDATResponse1 as element(ns0:consultaCargaArchivoDATResponse))
    as element(ns0:cargaArchivoDATResponse) {
        <ns0:cargaArchivoDATResponse>
            <BANK_BATCH_ID>{ data($consultaCargaArchivoDATResponse1/BANK_BATCH_ID) }</BANK_BATCH_ID>
            {
                for $RTN in $consultaCargaArchivoDATResponse1/RTN
                return
                    <RTN>{ data($RTN) }</RTN>
            }
            {
                for $PRESENTATION_DATE in $consultaCargaArchivoDATResponse1/PRESENTATION_DATE
                return
                    <PRESENTATION_DATE>{ fn:adjust-date-to-timezone(data($PRESENTATION_DATE),()) }</PRESENTATION_DATE>
            }
            {
                for $DECLARATION_ID in $consultaCargaArchivoDATResponse1/DECLARATION_ID
                return
                    <DECLARATION_ID>{ data($DECLARATION_ID) }</DECLARATION_ID>
            }
            {
                for $PERIOD in $consultaCargaArchivoDATResponse1/PERIOD
                return
                    <PERIOD>{ data($PERIOD) }</PERIOD>
            }
            {
                for $TAX_ID in $consultaCargaArchivoDATResponse1/TAX_ID
                return
                    <TAX_ID>{ data($TAX_ID) }</TAX_ID>
            }
             {
                for $TAX_DESC in $consultaCargaArchivoDATResponse1/TAX_DESCRIPTION
                return
                    <TAX_DESCRIPTION>{ data($TAX_DESC) }</TAX_DESCRIPTION>
            }
            
            {
                for $CONCEPT_ID in $consultaCargaArchivoDATResponse1/CONCEPT_ID
                return
                    <CONCEPT_ID>{ data($CONCEPT_ID) }</CONCEPT_ID>
            }
            {
                for $TAX_DESC in $consultaCargaArchivoDATResponse1/CONCEPT_DESCRIPTION
                return
                    <CONCEPT_DESCRIPTION>{ data($TAX_DESC) }</CONCEPT_DESCRIPTION>
            }
            {
                for $TAX_PAYMENT in $consultaCargaArchivoDATResponse1/TAX_PAYMENT
                return
                    <TAX_PAYMENT>{ data($TAX_PAYMENT) }</TAX_PAYMENT>
            }
            {
                for $PENALTY_FEE in $consultaCargaArchivoDATResponse1/PENALTY_FEE
                return
                    <PENALTY_FEE>{ data($PENALTY_FEE) }</PENALTY_FEE>
            }
            {
                for $SURCHARGE_PAYMENT in $consultaCargaArchivoDATResponse1/SURCHARGE_PAYMENT
                return
                    <SURCHARGE_PAYMENT>{ data($SURCHARGE_PAYMENT) }</SURCHARGE_PAYMENT>
            }
            {
                for $TAX_INTEREST in $consultaCargaArchivoDATResponse1/TAX_INTEREST
                return
                    <TAX_INTEREST>{ data($TAX_INTEREST) }</TAX_INTEREST>
            }
            {
                for $TOTAL_PAYMENT in $consultaCargaArchivoDATResponse1/TOTAL_PAYMENT
                return
                    <TOTAL_PAYMENT>{ data($TOTAL_PAYMENT) }</TOTAL_PAYMENT>
            }
            {
                for $TOTAL_PRESENTED in $consultaCargaArchivoDATResponse1/TOTAL_PRESENTED
                return
                    <TOTAL_PRESENTED>{ data($TOTAL_PRESENTED) }</TOTAL_PRESENTED>
            }
            {
                for $PAYMENT_DETAILS in $consultaCargaArchivoDATResponse1/PAYMENT_DETAILS
                return
                    <PAYMENT_DETAILS>
                        {
                            for $PAYMENT_DETAIL in $PAYMENT_DETAILS/PAYMENT_DETAIL
                            return
                                <PAYMENT_DETAIL>
                                    <TAX_XML>{ data($PAYMENT_DETAIL/TAX_XML) }</TAX_XML>
                                    <TAX>{ data($PAYMENT_DETAIL/TAX) }</TAX>
                                    <CONCEPT>{ data($PAYMENT_DETAIL/CONCEPT) }</CONCEPT>
                                    <SUB_CONCEPT>{ data($PAYMENT_DETAIL/SUB_CONCEPT) }</SUB_CONCEPT>
                                    <DESCRIPTION>{ data($PAYMENT_DETAIL/DESCRIPTION) }</DESCRIPTION>      
                                    <AMOUNT>{ data($PAYMENT_DETAIL/AMOUNT) }</AMOUNT>
                                </PAYMENT_DETAIL>
                        }
                    </PAYMENT_DETAILS>
            }
        </ns0:cargaArchivoDATResponse>
};

declare variable $consultaCargaArchivoDATResponse1 as element(ns0:consultaCargaArchivoDATResponse) external;

xf:cargaArchivoOut($consultaCargaArchivoDATResponse1)