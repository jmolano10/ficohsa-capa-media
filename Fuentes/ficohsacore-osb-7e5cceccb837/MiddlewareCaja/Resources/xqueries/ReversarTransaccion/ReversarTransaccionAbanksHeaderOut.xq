(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../xsds/ReversaTransaccion/ReversionRecaudoAbanks/ORA_BANK_OSB_K_INTEGRACION_CONVENIOS_REVERSION_COBRANZA_ABANKS.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_INTEGRACION_CONVENIOS/REVERSION_COBRANZA_ABANKS/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionAbanksHeaderOut/";

declare function xf:ReversarTransaccionAbanksHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $TRANSACTION_ID_REV in $outputParameters/ns0:TRANSACTION_ID_REV
                return
                    <transactionId>{ data($TRANSACTION_ID_REV) }</transactionId>
            }
            {
                for $CODIGO_MENSAJE in $outputParameters/ns0:CODIGO_MENSAJE
                return
                    <successIndicator>{ data($CODIGO_MENSAJE) }</successIndicator>
            }
            {
                for $DESCRIPCION_MENSAJE in $outputParameters/ns0:DESCRIPCION_MENSAJE
                return
                    <messages>{ data($DESCRIPCION_MENSAJE) }</messages>
            }
            {
                for $VALUE_DATE_REV in $outputParameters/ns0:VALUE_DATE_REV
                return
                    <valueDate>{ data($VALUE_DATE_REV) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:ReversarTransaccionAbanksHeaderOut($outputParameters)