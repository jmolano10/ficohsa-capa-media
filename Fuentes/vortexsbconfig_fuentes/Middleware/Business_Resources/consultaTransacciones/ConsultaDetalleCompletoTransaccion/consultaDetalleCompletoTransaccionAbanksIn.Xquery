<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion" element="ns0:consultaDetalleCompletoTransaccion" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleTransaccion" location="../ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/ConsultaDetalleCompletoTransaccionAbanksIn/";

declare function xf:ConsultaDetalleCompletoTransaccionAbanksIn($consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion))
    as element(ns1:consultaDetalleTransaccion) {
        <ns1:consultaDetalleTransaccion>
            <TRANSACTION_REFERENCE>{ data($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE) }</TRANSACTION_REFERENCE>
            {
                for $ACCOUNT_NUMBER in $consultaDetalleCompletoTransaccion/ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
        </ns1:consultaDetalleTransaccion>
};

declare variable $consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion) external;

xf:ConsultaDetalleCompletoTransaccionAbanksIn($consultaDetalleCompletoTransaccion)]]></con:xquery>
    <con:dependency location="consultaDetalleCompletoTransaccionTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionTypes"/>
    </con:dependency>
    <con:dependency location="../ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes"/>
    </con:dependency>
</con:xqueryEntry>