(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../xsds/ConsultaRecaudoAbanks/consultaRecaudoAbanks/ORA_BANK_OSB_K_INTEGRACION_CONVENIOS_CONSULTA_COBRANZA_ABANKS.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoAbanksResponse" location="../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAbanksTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_INTEGRACION_CONVENIOS/CONSULTA_COBRANZA_ABANKS/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/ConsultaRecaudoAbanksOut/";

declare function xf:ConsultaRecaudoAbanksOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaRecaudoAbanksResponse) {
        <ns1:consultaRecaudoAbanksResponse>
            <MESSAGE_LINE_1>{ data($outputParameters/ns0:MESSAGE_LINE_1) }</MESSAGE_LINE_1>
            <MESSAGE_LINE_2>{ data($outputParameters/ns0:MESSAGE_LINE_2) }</MESSAGE_LINE_2>
            <RESPONSE_TYPE>{ data($outputParameters/ns0:RESPONSE_TYPE) }</RESPONSE_TYPE>
            <BILL_MATRIX>{ data($outputParameters/ns0:BILL_MATRIX) }</BILL_MATRIX>
        </ns1:consultaRecaudoAbanksResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:ConsultaRecaudoAbanksOut($outputParameters)