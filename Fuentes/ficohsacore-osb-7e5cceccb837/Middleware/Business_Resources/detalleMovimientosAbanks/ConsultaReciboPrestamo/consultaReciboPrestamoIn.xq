(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaReciboPrestamo/xsd/ORA_BANK_OSB_K_CONSULTARECIBOPRESTAMO_TOPLEVEL-24OSB_CON_RECIBO_PREST.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTARECIBOPRESTAMO/TOPLEVEL-24OSB_CON_RECIBO_PREST/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosAbanks/ConsultaReciboPrestamo/consultaReciboPrestamoIn/";

declare function xf:consultaReciboPrestamoIn($ACCOUNT as xs:string,
    $TRANSACTION_REFERENCE as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:ACCOUNT_NUMBER>{ $ACCOUNT }</ns0:ACCOUNT_NUMBER>
            <ns0:TRANSACTION_REFERENCE>{ $TRANSACTION_REFERENCE }</ns0:TRANSACTION_REFERENCE>
        </ns0:InputParameters>
};

declare variable $ACCOUNT as xs:string external;
declare variable $TRANSACTION_REFERENCE as xs:string external;

xf:consultaReciboPrestamoIn($ACCOUNT,
    $TRANSACTION_REFERENCE)