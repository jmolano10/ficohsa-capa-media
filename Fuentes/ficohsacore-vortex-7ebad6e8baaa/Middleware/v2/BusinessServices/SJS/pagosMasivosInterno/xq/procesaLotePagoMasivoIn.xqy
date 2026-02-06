xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjPagosMasivosInterno" element="ns1:sjPagosMasivosInterno" location="../xsd/sjPagosMasivosInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../PMSV/procesaLotePagoMasivo/xsd/procesaLotePagoMasivo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/procesaLotePagoMasivo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjPagosMasivosInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/procesaLotePagoMasivoIn/";

declare function xf:procesaLotePagoMasivoIn($numerobatch as xs:int,
    $sjPagosMasivosInterno as element(ns1:sjPagosMasivosInterno))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:GLOBAL_ID>{ data($sjPagosMasivosInterno/GLOBAL_ID) }</ns0:GLOBAL_ID>
            <ns0:CUSTOMER_ID>{ data($sjPagosMasivosInterno/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:USERNAME>{ data($sjPagosMasivosInterno/USERNAME) }</ns0:USERNAME>
            <ns0:BATCH_TYPE>{ data($sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/TYPE) }</ns0:BATCH_TYPE>
            <ns0:CUSTOMER_BATCH_ID>{ data($sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/CUSTOMER_BATCH_ID) }</ns0:CUSTOMER_BATCH_ID>
            <ns0:NUMBER_OF_TRANSACTIONS>{ data($sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/VALIDATIONS/NUMBER_OF_TRANSACTIONS) }</ns0:NUMBER_OF_TRANSACTIONS>
            <ns0:TOTAL_AMOUNT>{ data($sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/VALIDATIONS/TOTAL_AMOUNT) }</ns0:TOTAL_AMOUNT>
            {
                let $FIELDS := $sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/FIELDS
                return
                    <ns0:FIELDS>
                        {
                            for $FIELD in $FIELDS/FIELD
                            return
                                <ns0:ITEM>{ data($FIELD) }</ns0:ITEM>
                        }
                    </ns0:FIELDS>
            }
            <ns0:DELIMITER>{ data($sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/DELIMITER) }</ns0:DELIMITER>
            {
                let $TRANSACTIONS := $sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/TRANSACTIONS
                return
                    <ns0:TRANSACTIONS>
                        {
                            for $TRANSACTION in $TRANSACTIONS/TRANSACTION
                            return
                                <ns0:ITEM>{ data($TRANSACTION) }</ns0:ITEM>
                        }
                    </ns0:TRANSACTIONS>
            }
            <ns0:USER_CHANNEL>{ data($sjPagosMasivosInterno/USERNAME_HEADER) }</ns0:USER_CHANNEL>            
	    {
                for $APPLICATION_DATE in $sjPagosMasivosInterno/BATCHES/BATCH[$numerobatch]/APPLICATION_DATE
                return
                    <ns0:APPLICATION_DATE>{ data($APPLICATION_DATE) }</ns0:APPLICATION_DATE>
            }
        </ns0:InputParameters>
};

declare variable $numerobatch as xs:int external;
declare variable $sjPagosMasivosInterno as element(ns1:sjPagosMasivosInterno) external;

xf:procesaLotePagoMasivoIn($numerobatch,
    $sjPagosMasivosInterno)