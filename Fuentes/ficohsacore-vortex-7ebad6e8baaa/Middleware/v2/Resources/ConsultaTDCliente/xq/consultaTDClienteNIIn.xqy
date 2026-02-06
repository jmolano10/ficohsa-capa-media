xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTDCliente" element="ns0:consultaTDCliente" location="../xsd/consultaTDClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Cobis/TarjetaDebitoCliente/xsd/tarjetaDebitoClienteNI_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/tarjetaDebitoClienteNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTDClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTDCliente/xq/consultaTDClienteNIIn/";

declare function xf:consultaTDClienteNIIn($consultaTDCliente as element(ns0:consultaTDCliente))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:i_CUSTOMER_ID>{ data($consultaTDCliente/CUSTOMER_ID) }</ns1:i_CUSTOMER_ID>
            <ns1:i_CARD_STATUS>{ data($consultaTDCliente/CARD_STATUS) }</ns1:i_CARD_STATUS>
        </ns1:InputParameters>
};

declare variable $consultaTDCliente as element(ns0:consultaTDCliente) external;

xf:consultaTDClienteNIIn($consultaTDCliente)