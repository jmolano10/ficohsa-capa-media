xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorCliente" element="ns0:consultaTarjetasCreditoPorCliente" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarTarjetas" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xq/consultaTarjetasCreditoHNIn5/";

declare function xf:consultaTarjetasCreditoHNIn($consultaTarjetasCreditoPorCliente as element(ns0:consultaTarjetasCreditoPorCliente))
    as element(ns1:ConsultarTarjetas) {
         if( data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_TYPE) = "LEGAL_ID") then (
            <ns1:ConsultarTarjetas>
            <ns1:noIdentidadCliente>{ data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</ns1:noIdentidadCliente>
            <ns1:nombreCliente></ns1:nombreCliente>
            <ns1:EstatusCtas>{ data($consultaTarjetasCreditoPorCliente/CREDIT_CARD_STATUS) }</ns1:EstatusCtas>
            {
                for $FILTER_CRITERIAS in $consultaTarjetasCreditoPorCliente/FILTER_CRITERIAS
                return
                    <ns1:Filters>
                        {
                            for $FILTER_CRITERIA in $FILTER_CRITERIAS/FILTER_CRITERIA
                            return
                                <ns1:Filter>
                                    {
                                        for $ID_FILTER in $FILTER_CRITERIA/ID_FILTER
                                        return
                                            <ns1:Id>{ data($ID_FILTER) }</ns1:Id>
                                    }
                                    {
                                        for $TYPE_FILTER in $FILTER_CRITERIA/TYPE_FILTER
                                        return
                                            <ns1:Field>{ data($TYPE_FILTER) }</ns1:Field>
                                    }
                                    {
                                        for $VALUE_FILTER in $FILTER_CRITERIA/VALUE_FILTER
                                        return
                                            <ns1:Values>{ data($VALUE_FILTER) }</ns1:Values>
                                    }
                                </ns1:Filter>
                        }
                    </ns1:Filters>
            }
        </ns1:ConsultarTarjetas>
        )else(
        <ns1:ConsultarTarjetas>
        <ns1:noIdentidadCliente>0</ns1:noIdentidadCliente>
             <ns1:nombreCliente></ns1:nombreCliente>
             <ns1:EstatusCtas></ns1:EstatusCtas>
                <ns1:Filters>
                  <ns1:Filter>
                        <ns1:Id></ns1:Id>
                        <ns1:Field>{ data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_TYPE) }</ns1:Field>
                        <ns1:Values>{ data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</ns1:Values>
                  </ns1:Filter>
                </ns1:Filters>
        </ns1:ConsultarTarjetas>
)        
};

declare variable $consultaTarjetasCreditoPorCliente as element(ns0:consultaTarjetasCreditoPorCliente) external;

xf:consultaTarjetasCreditoHNIn($consultaTarjetasCreditoPorCliente)