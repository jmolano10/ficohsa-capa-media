(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resources/ConsultaImagenChequeAbanks/xsd/ORA_BANK_OSB_CON_IMAGEN_CHEQUE.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaImagenChequeResponse" location="consultaImagenChequeTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaImagenChequeTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_IMAGEN_CHEQUE/";
declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/consultaCheque/ConsultaImagenChequeAbanks/consultaImagenChequeOut/";

declare function xf:consultaImagenChequeOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaImagenChequeResponse) {
        <ns1:consultaImagenChequeResponse>
            <CHEQUE_NUMBER>{ data($outputParameters/ns0:CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            <TRANSACTION_DATE>{ data($outputParameters/ns0:TRANSACTION_DATE) }</TRANSACTION_DATE>
            <CHEQUE_IMAGE_FRONT>{ data($outputParameters/ns0:CHEQUE_IMAGE_FRONT) }</CHEQUE_IMAGE_FRONT>
            <CHEQUE_IMAGE_BACK>{ data($outputParameters/ns0:CHEQUE_IMAGE_BACK) }</CHEQUE_IMAGE_BACK>
            <FILE_EXTENSION>{ data($outputParameters/ns0:FILE_EXTENSION) }</FILE_EXTENSION>
            <QUERY_STATUS>{ data($outputParameters/ns0:QUERY_STATUS) }</QUERY_STATUS>
            <QUERY_DESCRIPTION>{ data($outputParameters/ns0:QUERY_DESCRIPTION) }</QUERY_DESCRIPTION>
        </ns1:consultaImagenChequeResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaImagenChequeOut($outputParameters)