(:: pragma bea:global-element-parameter parameter="$sjPagosMasivosInternoResponse" element="ns1:sjPagosMasivosInternoResponse" location="../../../BusinessServices/SJS/pagosMasivosInterno/xsd/sjPagosMasivosInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagosMasivosResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjPagosMasivosInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/PagosMasivosInternoOut/";

declare function xf:pagosMasivosInternoOut($sjPagosMasivosInternoResponse as element(ns1:sjPagosMasivosInternoResponse))
    as element(ns0:pagosMasivosResponse) {
        let $sjPagosMasivosInternoResponse := $sjPagosMasivosInternoResponse
        return
            <ns0:pagosMasivosResponse>
                {
                    for $GLOBAL_ID in $sjPagosMasivosInternoResponse/GLOBAL_ID
                    return
                        <GLOBAL_ID>{ data($GLOBAL_ID) }</GLOBAL_ID>
                }
                {
                    for $CUSTOMER_ID in $sjPagosMasivosInternoResponse/CUSTOMER_ID
                    return
                        <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
                }
                {
                    for $BATCHES in $sjPagosMasivosInternoResponse/BATCHES
                    return
                        <BATCHES>
                            {
                                for $BATCH in $BATCHES/BATCH
                                order by $BATCH/ID_POSITION
                                return
                                    <BATCH>
                                        {
                                            for $BANK_BATCH_ID in $BATCH/BANK_BATCH_ID
                                            return
                                                <BANK_BATCH_ID>{ data($BANK_BATCH_ID) }</BANK_BATCH_ID>
                                        }
                                        {
                                            for $CUSTOMER_BATCH_ID in $BATCH/CUSTOMER_BATCH_ID
                                            return
                                                <CUSTOMER_BATCH_ID>{ data($CUSTOMER_BATCH_ID) }</CUSTOMER_BATCH_ID>
                                        }
                                        {
                                            for $STATUS in $BATCH/STATUS
                                            return
                                                <STATUS>{ data($STATUS) }</STATUS>
                                        }
                                        {
                                            for $ERROR_CODE in $BATCH/ERROR_CODE
                                            return
                                                <ERROR_CODE>{ data($ERROR_CODE) }</ERROR_CODE>
                                        }
                                        {
                                            for $ERROR_MESSAGE in $BATCH/ERROR_MESSAGE
                                            return
                                                <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                        }
                                    </BATCH>
                            }
                        </BATCHES>
                }
            </ns0:pagosMasivosResponse>
};

declare variable $sjPagosMasivosInternoResponse as element(ns1:sjPagosMasivosInternoResponse) external;

xf:pagosMasivosInternoOut($sjPagosMasivosInternoResponse)