xquery version "1.0" encoding "utf-8";

(:: pragma bea:global-element-parameter parameter="$consultaLotesCliente" element="ns0:consultaLotesCliente" location="../../../Schemas/PagosMasivosH2H/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaLotesCliente" location="../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaLotesClienteIn/";

declare function xf:consultaLotesClienteIn($consultaLotesCliente as element(ns0:consultaLotesCliente))
    as element(ns0:consultaLotesCliente) {
        <ns0:consultaLotesCliente>
            <CUSTOMER_ID>{ data($consultaLotesCliente/CUSTOMER_ID) }</CUSTOMER_ID>
            <BEGIN_DATE>{ data($consultaLotesCliente/BEGIN_DATE) }</BEGIN_DATE>
            <END_DATE>{ data($consultaLotesCliente/END_DATE) }</END_DATE>
        </ns0:consultaLotesCliente>
};

declare variable $consultaLotesCliente as element(ns0:consultaLotesCliente) external;

xf:consultaLotesClienteIn($consultaLotesCliente)