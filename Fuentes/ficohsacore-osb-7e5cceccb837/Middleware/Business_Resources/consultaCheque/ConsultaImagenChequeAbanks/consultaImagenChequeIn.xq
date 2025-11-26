(:: pragma bea:global-element-parameter parameter="$consultaImagenCheque" element="ns1:consultaImagenCheque" location="consultaImagenChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaImagenChequeAbanks/xsd/ORA_BANK_OSB_CON_IMAGEN_CHEQUE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaImagenChequeTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_IMAGEN_CHEQUE/";
declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/consultaCheque/ConsultaImagenChequeAbanks/consultaImagenChequeIn/";

declare function xf:consultaImagenChequeIn($consultaImagenCheque as element(ns1:consultaImagenCheque))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:ACCOUNT_NUMBER>{ data($consultaImagenCheque/ACCOUNT_NUMBER) }</ns0:ACCOUNT_NUMBER>
            <ns0:TRANSACTION_REFERENCE>{ data($consultaImagenCheque/TRANSACTION_REFERENCE) }</ns0:TRANSACTION_REFERENCE>
            <ns0:CHEQUE_NUMBER>{ data($consultaImagenCheque/CHEQUE_NUMBER) }</ns0:CHEQUE_NUMBER>
        </ns0:InputParameters>
};

declare variable $consultaImagenCheque as element(ns1:consultaImagenCheque) external;

xf:consultaImagenChequeIn($consultaImagenCheque)