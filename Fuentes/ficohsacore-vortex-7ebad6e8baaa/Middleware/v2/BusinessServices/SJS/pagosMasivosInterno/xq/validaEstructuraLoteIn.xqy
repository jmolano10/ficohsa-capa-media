xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjPagosMasivosInterno1" element="ns1:sjPagosMasivosInterno" location="../xsd/sjPagosMasivosInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../PMSV/validaEstructuraLote/xsd/validaEstructuraLote_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaEstructuraLote";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjPagosMasivosInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/validaEstructuraLoteIn/";

declare function xf:validaEstructuraLoteIn($numerobatch as xs:int, $sjPagosMasivosInterno1 as element(ns1:sjPagosMasivosInterno))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ data($sjPagosMasivosInterno1/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:BATCH_TYPE>{ data($sjPagosMasivosInterno1/BATCHES/BATCH[$numerobatch]/TYPE) }</ns0:BATCH_TYPE>
            <ns0:NUMBER_OF_TRANSACTIONS>{ data($sjPagosMasivosInterno1/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/VALIDATIONS/NUMBER_OF_TRANSACTIONS) }</ns0:NUMBER_OF_TRANSACTIONS>
            <ns0:TOTAL_AMOUNT>{ data($sjPagosMasivosInterno1/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/VALIDATIONS/TOTAL_AMOUNT) }</ns0:TOTAL_AMOUNT>
            {
            	for $APPLICATION_DATE in $sjPagosMasivosInterno1/BATCHES/BATCH[$numerobatch]/APPLICATION_DATE
            	return
            		<ns0:APPLICATION_DATE>{ data($APPLICATION_DATE) }</ns0:APPLICATION_DATE>
            }
            <ns0:FIELDS>
                {
                    for $FIELD in $sjPagosMasivosInterno1/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/FIELDS/FIELD
                    return
                        <ns0:ITEM>{ data($FIELD) }</ns0:ITEM>
                }
            </ns0:FIELDS>
            <ns0:DELIMITER>{ data($sjPagosMasivosInterno1/BATCHES/BATCH[$numerobatch]/DATA_STRUCTURE/DELIMITER) }</ns0:DELIMITER>
            <ns0:TRANSACTIONS>
                {
                    for $TRANSACTION in $sjPagosMasivosInterno1/BATCHES/BATCH[$numerobatch]/TRANSACTIONS/TRANSACTION
                    return
                        <ns0:ITEM>{ data($TRANSACTION) }</ns0:ITEM>
                }
            </ns0:TRANSACTIONS>
        </ns0:InputParameters>
};

declare variable $sjPagosMasivosInterno1 as element(ns1:sjPagosMasivosInterno) external;
declare variable $numerobatch as xs:int external;

xf:validaEstructuraLoteIn($numerobatch,$sjPagosMasivosInterno1)