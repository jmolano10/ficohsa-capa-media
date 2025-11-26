(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorCliente" element="ns1:consultaTarjetasCreditoPorCliente" location="../xsd/consultaTarjetasCreditoPorClienteCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTarjetasCreditoPorCliente" location="../../ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorClienteCB/xq/consultaTarjetasCreditoPorClienteCBIn/";

declare function xf:consultaTarjetasCreditoPorClienteCBIn($consultaTarjetasCreditoPorCliente as element(ns1:consultaTarjetasCreditoPorCliente))
    as element(ns0:consultaTarjetasCreditoPorCliente) {
        <ns0:consultaTarjetasCreditoPorCliente>
            {
                let $CUSTOMER_FILTER := $consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER
                return
                    <CUSTOMER_FILTER>
                        <CUSTOMER_ID_TYPE>{ data($CUSTOMER_FILTER/CUSTOMER_ID_TYPE) }</CUSTOMER_ID_TYPE>
                        <CUSTOMER_ID_VALUE>{ data($CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</CUSTOMER_ID_VALUE>
                    </CUSTOMER_FILTER>
            }
            <CREDIT_CARD_STATUS>{ data($consultaTarjetasCreditoPorCliente/CREDIT_CARD_STATUS) }</CREDIT_CARD_STATUS>
            {
                for $FILTER_CRITERIAS in $consultaTarjetasCreditoPorCliente/FILTER_CRITERIAS
                return
                    <FILTER_CRITERIAS>
                        {
                            for $FILTER_CRITERIA in $FILTER_CRITERIAS/FILTER_CRITERIA
                            return
                                <FILTER_CRITERIA>
                                    {
                                        for $ID_FILTER in $FILTER_CRITERIA/ID_FILTER
                                        return
                                            <ID_FILTER>{ data($ID_FILTER) }</ID_FILTER>
                                    }
                                    {
                                        for $TYPE_FILTER in $FILTER_CRITERIA/TYPE_FILTER
                                        return
                                            <TYPE_FILTER>{ data($TYPE_FILTER) }</TYPE_FILTER>
                                    }
                                    {
                                        for $VALUE_FILTER in $FILTER_CRITERIA/VALUE_FILTER
                                        return
                                            <VALUE_FILTER>{ data($VALUE_FILTER) }</VALUE_FILTER>
                                    }
                                </FILTER_CRITERIA>
                        }
                    </FILTER_CRITERIAS>
            }
        </ns0:consultaTarjetasCreditoPorCliente>
};

declare variable $consultaTarjetasCreditoPorCliente as element(ns1:consultaTarjetasCreditoPorCliente) external;

xf:consultaTarjetasCreditoPorClienteCBIn($consultaTarjetasCreditoPorCliente)