xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ConsultaMaestraInfoTransaccionesTC/xsd/ConMaestraInfoTransaccionesTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMaestraInfoTransaccionesTCResponse" location="../xsd/consultaMaestraInfoTransaccionesTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraInfoTransaccionesTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConMaestraInfoTransaccionesTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraInfoTransaccionesTC/xq/consultaMaestraInfoTransaccionesTCOut/";
declare function xf:consultaMaestraInfoTransaccionesTCOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaMaestraInfoTransaccionesTCResponse) {


        let $rows := $outputParameters/ns1:RowSet/ns1:Row

        let $ACCOUNT_NUMBER := $rows[1]/ns1:Column[@name = 'numcuenta']
        let $CARD_NUMBER := $rows[1]/ns1:Column[@name='numtarjeta']
        let $CARD_HOLDER_NAME := $rows[1]/ns1:Column[@name='nombre']
        let $CUTOFF_DATE := $rows[1]/ns1:Column[@name='fechadecorte']
        let $LAST_CUTOFF_DATE := $rows[1]/ns1:Column[@name='fecultpago']
        let $MAX_PAYMENT_DATE := $rows[1]/ns1:Column[@name='fecpagodue']
		let $BEGINNING_BALANCE:= $rows[1]/ns1:Column[@name='SaldoInicial']
        
        return
        <ns0:consultaMaestraInfoTransaccionesTCResponse>
            <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
            <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
            <CUTOFF_DATE>{ substring-before(data($CUTOFF_DATE), 'T') }</CUTOFF_DATE>
            <LAST_CUTOFF_DATE>{ substring-before(data($LAST_CUTOFF_DATE), 'T')  }</LAST_CUTOFF_DATE>
            <MAX_PAYMENT_DATE>{ substring-before(data($MAX_PAYMENT_DATE), 'T')  }</MAX_PAYMENT_DATE>
            <BEGINNING_BALANCE>{data($BEGINNING_BALANCE)}</BEGINNING_BALANCE>
            {
                for $rowOrg in distinct-values($rows/ns1:Column[@name='org'])
                let $itemsOrg := $rows[ns1:Column[@name='org'] = $rowOrg]
                return
                    <CREDIT_CARD_TRANSACTION_INFO>
                        <ORG>{$rowOrg}</ORG>
                        <CURRENCY>{data($itemsOrg[1]/ns1:Column[@name='CodMoneda'])}</CURRENCY>
                        <CURRENT_BALANCE>{data($itemsOrg[1]/ns1:Column[@name='totbalactual'])}</CURRENT_BALANCE>
                        <CUTOFF_BALANCE>{data($itemsOrg[1]/ns1:Column[@name='SaldoAlCorte'])}</CUTOFF_BALANCE>
                        <TRANSACTIONS_DETAILS>
                            {
                                for $item in $itemsOrg
                                return
                                    <TRANSACTION>
                                        <AMOUNT>{data($item/ns1:Column[@name='monto'])}</AMOUNT>
                                        <TRANSACTION_DATE>{ substring-before( data($item/ns1:Column[@name='fecha_transaccion']) ,'T') }</TRANSACTION_DATE>
                                        <POSTING_DATE>{ substring-before(data($item/ns1:Column[@name='fecposteo']),'T') }</POSTING_DATE>
                                        <TRANSACTION_CODE>{data($item/ns1:Column[@name='codtxn'])}</TRANSACTION_CODE>
                                        <REFERENCE_NUMBER>{data($item/ns1:Column[@name='numrefer'])}</REFERENCE_NUMBER>
                                    </TRANSACTION>
                            }
                        </TRANSACTIONS_DETAILS>
                    </CREDIT_CARD_TRANSACTION_INFO>

            }


        </ns0:consultaMaestraInfoTransaccionesTCResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaMaestraInfoTransaccionesTCOut($outputParameters)