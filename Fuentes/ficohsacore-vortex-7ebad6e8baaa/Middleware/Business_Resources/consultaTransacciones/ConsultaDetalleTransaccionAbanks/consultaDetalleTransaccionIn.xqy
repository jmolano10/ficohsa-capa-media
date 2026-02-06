xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccion1" element="ns0:consultaDetalleTransaccion" location="consultaDetalleTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/ConsultaDetalleTransaccionAbanks/xsd/ORA_BANK_OSB_CON_DETALLE_MOV.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_DETALLE_MOV/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionIn/";

declare function xf:consultaDetalleTransaccionIn($consultaDetalleTransaccion1 as element(ns0:consultaDetalleTransaccion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaDetalleTransaccion1/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            <ns1:TRANSACTION_REFERENCE>{ data($consultaDetalleTransaccion1/TRANSACTION_REFERENCE) }</ns1:TRANSACTION_REFERENCE>
        </ns1:InputParameters>
};

declare variable $consultaDetalleTransaccion1 as element(ns0:consultaDetalleTransaccion) external;

xf:consultaDetalleTransaccionIn($consultaDetalleTransaccion1)