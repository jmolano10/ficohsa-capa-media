(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorClienteResponse" element="ns0:consultaTarjetasCreditoPorClienteResponse" location="../../ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTarjetasCreditoPorClienteResponse" location="../xsd/consultaTarjetasCreditoPorClienteCBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorClienteCB/xq/consultaTarjetasCreditoPorClienteOut/";

declare function xf:consultaTarjetasCreditoPorClienteOut($consultaTarjetasCreditoPorClienteResponse as element(ns0:consultaTarjetasCreditoPorClienteResponse))
    as element(ns1:consultaTarjetasCreditoPorClienteResponse) {
        <ns1:consultaTarjetasCreditoPorClienteResponse>
            {
                for $CREDIT_CARDS in $consultaTarjetasCreditoPorClienteResponse/CREDIT_CARDS
                return
                    <CREDIT_CARDS>
                        {
                            for $CREDIT_CARD_INFORMATION in $CREDIT_CARDS/CREDIT_CARD_INFORMATION
                            return
                                <CREDIT_CARD_INFORMATION>
                                    {
                                        for $CREDIT_CARD_NUMBER in $CREDIT_CARD_INFORMATION/CREDIT_CARD_NUMBER
                                        return
                                            <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                                    }
                                    {
                                        for $ACCOUNT_NUMBER in $CREDIT_CARD_INFORMATION/ACCOUNT_NUMBER
                                        return
                                            <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                                    }
                                    {
                                        for $CARD_HOLDER_NAME in $CREDIT_CARD_INFORMATION/CARD_HOLDER_NAME
                                        return
                                            <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
                                    }
                                    {
                                        for $CARD_TYPE in $CREDIT_CARD_INFORMATION/CARD_TYPE
                                        return
                                            <CARD_TYPE>{ data($CARD_TYPE) }</CARD_TYPE>
                                    }
                                    {
                                        for $STATUS in $CREDIT_CARD_INFORMATION/STATUS
                                        return
                                            <STATUS>{ data($STATUS) }</STATUS>
                                    }
                                    {
                                        for $PRODUCT_TYPE in $CREDIT_CARD_INFORMATION/PRODUCT_TYPE
                                        return
                                            <PRODUCT_TYPE>{ data($PRODUCT_TYPE) }</PRODUCT_TYPE>
                                    }
                                    {
                                        for $AFINITY_GROUP in $CREDIT_CARD_INFORMATION/AFINITY_GROUP
                                        return
                                            <AFINITY_GROUP>{ data($AFINITY_GROUP) }</AFINITY_GROUP>
                                    }
                                    {
                                        for $ADDITIONAL_INFORMATION in $CREDIT_CARD_INFORMATION/ADDITIONAL_INFORMATION
                                        return
                                            <ADDITIONAL_INFORMATION>
                                                {
                                                    for $FIELD_INFORMATION in $ADDITIONAL_INFORMATION/FIELD_INFORMATION
                                                    return
                                                        <FIELD_INFORMATION>
                                                            {
                                                                for $NAME_FIELD in $FIELD_INFORMATION/NAME_FIELD
                                                                return
                                                                    <NAME_FIELD>{ data($NAME_FIELD) }</NAME_FIELD>
                                                            }
                                                            {
                                                                for $VALUE_FIELD in $FIELD_INFORMATION/VALUE_FIELD
                                                                return
                                                                    <VALUE_FIELD>{ data($VALUE_FIELD) }</VALUE_FIELD>
                                                            }
                                                        </FIELD_INFORMATION>
                                                }
                                            </ADDITIONAL_INFORMATION>
                                    }
                                </CREDIT_CARD_INFORMATION>
                        }
                    </CREDIT_CARDS>
            }
        </ns1:consultaTarjetasCreditoPorClienteResponse>
};

declare variable $consultaTarjetasCreditoPorClienteResponse as element(ns0:consultaTarjetasCreditoPorClienteResponse) external;

xf:consultaTarjetasCreditoPorClienteOut($consultaTarjetasCreditoPorClienteResponse)