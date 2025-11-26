(:: pragma bea:global-element-parameter parameter="$t24FTAuthFlow" element="ns2:T24FTAuthFlow" location="../xsd/T24FicoTSPServices-T24FTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/registraBitacoraTSPPMSV/xsd/registraBitacoraTSPMasivos_sp.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24FTAuthFlow";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraTSPMasivos";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/registrarBitTsp_In/";

declare function xf:registrarBitTsp_In($t24FTAuthFlow as element(ns2:T24FTAuthFlow),
    $RATE_AMOUNT as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $TransStmtEntry in $t24FTAuthFlow/ns2:TransStmtEntry
                return
                    <ns1:PV_ID_TRANSACCION>{ data($TransStmtEntry) }</ns1:PV_ID_TRANSACCION>
            }
            <ns1:PD_FECHA_VALIDA>{ data($t24FTAuthFlow/ns2:debitValueDate) }</ns1:PD_FECHA_VALIDA>
            <ns1:PN_CODIGO_CLIENTE>{ data($t24FTAuthFlow/ns2:DebitCustomerNo) }</ns1:PN_CODIGO_CLIENTE>
            <ns1:PV_NUMERO_CUENTA>{ data($t24FTAuthFlow/ns2:debitAcctNo) }</ns1:PV_NUMERO_CUENTA>
            {
                for $debitCurrency in $t24FTAuthFlow/ns2:debitCurrency
                return
                    <ns1:PV_CODIGO_MONEDA>{ data($debitCurrency) }</ns1:PV_CODIGO_MONEDA>
            }
            {
                for $TransStmtEntry in $t24FTAuthFlow/ns2:TransStmtEntry
                return
                    <ns1:PV_CODIGO_TRANSACCION>{ data($TransStmtEntry) }</ns1:PV_CODIGO_TRANSACCION>
            }
            {
                for $id in $t24FTAuthFlow/ns2:id
                return
                    <ns1:PV_REFERENCIA_FT_TT>{ data($id) }</ns1:PV_REFERENCIA_FT_TT>
            }
            {
                for $debitAmount in $t24FTAuthFlow/ns2:debitAmount
                return
                    <ns1:PN_MONTO>{ data($debitAmount) }</ns1:PN_MONTO>
            }
            <ns1:PN_MONTO_TSP>{ data($RATE_AMOUNT) }</ns1:PN_MONTO_TSP>
            {
                for $CreditCustomerNo in $t24FTAuthFlow/ns2:CreditCustomerNo
                return
                    <ns1:PN_CODIGO_CLIENTE_DESTINO>{ data($CreditCustomerNo) }</ns1:PN_CODIGO_CLIENTE_DESTINO>
            }
            <ns1:PV_NUMERO_CUENTA_DESTINO>{ data($t24FTAuthFlow/ns2:creditAcctNo) }</ns1:PV_NUMERO_CUENTA_DESTINO>
            {
                for $creditCurrency in $t24FTAuthFlow/ns2:creditCurrency
                return
                    <ns1:PV_CODIGO_MONEDA_DESTINO>{ data($creditCurrency) }</ns1:PV_CODIGO_MONEDA_DESTINO>
            }
            {
                for $lrAgClientId in $t24FTAuthFlow/ns2:lrAgClientId
                return
                    <ns1:PV_CODIGO_CONVENIO>{ data($lrAgClientId) }</ns1:PV_CODIGO_CONVENIO>
            }
            {
                let $result :=
                    for $paymentDetails in $t24FTAuthFlow/ns2:paymentDetailsList/ns2:paymentDetails
                    return
                        <ns1:PV_DESCRIPCION_MOVIMIENTO>{ data($paymentDetails) }</ns1:PV_DESCRIPCION_MOVIMIENTO>
                return
                    $result[1]
            }
            <ns1:PV_CODIGO_USUARIO>{ data($t24FTAuthFlow/ns2:eventCommon/ns0:operator) }</ns1:PV_CODIGO_USUARIO>
        </ns1:InputParameters>
};

declare variable $t24FTAuthFlow as element(ns2:T24FTAuthFlow) external;
declare variable $RATE_AMOUNT as xs:string external;

xf:registrarBitTsp_In($t24FTAuthFlow,
    $RATE_AMOUNT)