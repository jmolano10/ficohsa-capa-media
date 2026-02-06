xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTarjetasCreditoPorCliente" location="../../ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaTarjetasCreditoPorClienteFacade/xq/consultaTarjetasCreditoPorClienteFacadeIn/";

declare function xf:consultaTarjetasCreditoPorClienteFacadeIn($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:consultaTarjetasCreditoPorCliente) {
        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return
            <ns0:consultaTarjetasCreditoPorCliente>
                <CUSTOMER_FILTER>
                    <CUSTOMER_ID_TYPE>{ $messageListFM[1] }</CUSTOMER_ID_TYPE>
                    <CUSTOMER_ID_VALUE>{ $messageListFM[2] }</CUSTOMER_ID_VALUE>
                </CUSTOMER_FILTER>
                <CREDIT_CARD_STATUS></CREDIT_CARD_STATUS>
            </ns0:consultaTarjetasCreditoPorCliente>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:consultaTarjetasCreditoPorClienteFacadeIn($procesaMensajeGenericoT24)