xquery version "1.0" encoding "utf-8";

(:: pragma bea:global-element-parameter parameter="$pagosMasivosResponse" element="ns0:pagosMasivosResponse" location="../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagosMasivosResponse" location="../../../Schemas/PagosMasivosH2H/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/pagosMasivosInternoOut/";

declare function xf:pagosMasivosInternoOut($pagosMasivosResponse as element(ns0:pagosMasivosResponse))
    as element(ns0:pagosMasivosResponse) {
        <ns0:pagosMasivosResponse>
            {
                for $GLOBAL_ID in $pagosMasivosResponse/GLOBAL_ID
                return
                    <GLOBAL_ID>{ data($GLOBAL_ID) }</GLOBAL_ID>
            }
            {
                for $CUSTOMER_ID in $pagosMasivosResponse/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            {
                for $BATCHES in $pagosMasivosResponse/BATCHES
                return
                    <BATCHES>
                        {
                            for $BATCH in $BATCHES/BATCH
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

declare variable $pagosMasivosResponse as element(ns0:pagosMasivosResponse) external;

xf:pagosMasivosInternoOut($pagosMasivosResponse)