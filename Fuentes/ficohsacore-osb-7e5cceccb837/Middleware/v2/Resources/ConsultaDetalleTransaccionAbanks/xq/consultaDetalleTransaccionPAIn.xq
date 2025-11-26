xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTransaccion1" element="ns1:consultaDetalleTransaccion" location="../../../../Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaDetalleTransaccion/xsd/ORA_BANK_OSB_CON_DETALLE_MOV.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTransaccionAbanks/xq/consultaDetalleTransaccionPAIn/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_DETALLE_MOV/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";

declare function xf:consultaDetalleTransaccionPAIn($consultaDetalleTransaccion1 as element(ns0:consultaDetalleTransaccion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaDetalleTransaccion1/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            <ns1:TRANSACTION_REFERENCE>{ data($consultaDetalleTransaccion1/TRANSACTION_REFERENCE) }</ns1:TRANSACTION_REFERENCE>
        </ns1:InputParameters>
};

declare variable $consultaDetalleTransaccion1 as element(ns0:consultaDetalleTransaccion) external;

xf:consultaDetalleTransaccionPAIn($consultaDetalleTransaccion1)