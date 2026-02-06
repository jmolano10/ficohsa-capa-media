xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaClienteRequestIN" element="ns1:consultaClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/Cobis/ConsultaCliente/xsd/Consulta_Cliente.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/Consulta_Cliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteNIIn/";

declare function xf:consultaClienteNIIn($requestHeaderIN as element(ns2:RequestHeader),
    $consultaClienteRequestIN as element(ns1:consultaClienteRequest),
    $TransaccionType as xs:string,
    $Channel as xs:string,
    $Date as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_pais>{ data($requestHeaderIN/Region/SourceBank) }</ns0:i_pais>
            <ns0:i_user>{ data($requestHeaderIN/Authentication/UserName) }</ns0:i_user>
            <ns0:i_canal>{ $Channel }</ns0:i_canal>
            <ns0:i_fecha>{data($Date) }</ns0:i_fecha>
            <ns0:i_oficina></ns0:i_oficina>
            <ns0:t_trn>{ data($TransaccionType) }</ns0:t_trn>
            {
             if ( data($consultaClienteRequestIN/ns1:CUSTOMER_ID_TYPE/text())!= ("CUSTOMER_ID")) then(
            <ns0:i_customer_id_type>{ data($consultaClienteRequestIN/ns1:CUSTOMER_ID_TYPE) }</ns0:i_customer_id_type>,
            <ns0:i_customer_id_value>{ data($consultaClienteRequestIN/ns1:CUSTOMER_ID_VALUE) }</ns0:i_customer_id_value>,
             <ns0:i_en_ente></ns0:i_en_ente>
            )
            else (
             <ns0:i_customer_id_type></ns0:i_customer_id_type>,
             <ns0:i_customer_id_value></ns0:i_customer_id_value>,
             <ns0:i_en_ente>{ data($consultaClienteRequestIN/ns1:CUSTOMER_ID_VALUE) }</ns0:i_en_ente>
            )
            }
        </ns0:InputParameters>
};

declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $consultaClienteRequestIN as element(ns1:consultaClienteRequest) external;
declare variable $TransaccionType as xs:string external;
declare variable $Channel as xs:string external;
declare variable $Date as xs:string external;

xf:consultaClienteNIIn($requestHeaderIN,
    $consultaClienteRequestIN,
    $TransaccionType,
    $Channel,
    $Date)