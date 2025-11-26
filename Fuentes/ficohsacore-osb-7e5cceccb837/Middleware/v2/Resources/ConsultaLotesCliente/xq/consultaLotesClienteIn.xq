(:: pragma bea:global-element-parameter parameter="$consultaLotesCliente" element="ns0:consultaLotesCliente" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/consultaLotesCliente/xsd/consultaLotesCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLotesCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLotesCliente/xq/consultaLotesClienteIn/";

declare function xf:consultaLotesClienteIn($consultaLotesCliente as element(ns0:consultaLotesCliente))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CUSTOMER_ID>{ data($consultaLotesCliente/CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            <ns1:BEGIN_DATE>{ data($consultaLotesCliente/BEGIN_DATE) }</ns1:BEGIN_DATE>
            <ns1:END_DATE>{ data($consultaLotesCliente/END_DATE) }</ns1:END_DATE>
        </ns1:InputParameters>
};

declare variable $consultaLotesCliente as element(ns0:consultaLotesCliente) external;

xf:consultaLotesClienteIn($consultaLotesCliente)