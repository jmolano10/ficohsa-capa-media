(:: pragma bea:global-element-parameter parameter="$consultaLotesCliente" element="ns0:consultaLotesCliente" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:customerBatchQueryRequest" location="../../../BusinessServices/MTR/consultorLotesCliente/wsdl/customerBatchQuery.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/pms/customerBatchQuery";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLotesCliente/xq/consultaLotesClienteRGIn/";

declare function xf:consultaLotesClienteRGIn($consultaLotesCliente as element(ns0:consultaLotesCliente),
    $countryCode as xs:string)
    as element(ns1:customerBatchQueryRequest) {
        <ns1:customerBatchQueryRequest>
            <countryCode>{ $countryCode }</countryCode>
            <customerId>{ data($consultaLotesCliente/CUSTOMER_ID) }</customerId>
            <beginDate>{ data($consultaLotesCliente/BEGIN_DATE) }</beginDate>
            <endDate>{ data($consultaLotesCliente/END_DATE) }</endDate>
        </ns1:customerBatchQueryRequest>
};

declare variable $consultaLotesCliente as element(ns0:consultaLotesCliente) external;
declare variable $countryCode as xs:string external;

xf:consultaLotesClienteRGIn($consultaLotesCliente,
    $countryCode)
