xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccionResponse1" element="ns0:consultaDetalleCompletoTransaccionResponse" location="../../../consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../xsd/consultarReciboPagoPtmo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarReciboPagoPtmo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosT24/consultarReciboPagoPtmo/xq/consultaReciboPagoPtmoIn/";

declare function xf:consultaReciboPagoPtmoIn($string1 as xs:string,
    $consultaDetalleCompletoTransaccionResponse1 as element(ns0:consultaDetalleCompletoTransaccionResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $LOAN_NUMBER in $consultaDetalleCompletoTransaccionResponse1/LOAN_NUMBER
                return
                    <ns1:LOAN_NUMBER>{ substring(data($LOAN_NUMBER),5) }</ns1:LOAN_NUMBER>
            }
            <ns1:TRANSACTION_REFERENCE>{ $string1 }</ns1:TRANSACTION_REFERENCE>
        </ns1:InputParameters>
};

declare variable $string1 as xs:string external;
declare variable $consultaDetalleCompletoTransaccionResponse1 as element(ns0:consultaDetalleCompletoTransaccionResponse) external;

xf:consultaReciboPagoPtmoIn($string1,
    $consultaDetalleCompletoTransaccionResponse1)