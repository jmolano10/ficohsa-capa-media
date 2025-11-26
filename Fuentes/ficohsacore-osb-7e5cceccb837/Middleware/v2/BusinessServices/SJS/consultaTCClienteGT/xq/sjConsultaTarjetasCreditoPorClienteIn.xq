(:: pragma bea:global-element-return element="ns0:consultaTarjetasCreditoPorCliente" location="../../../../Resources/ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjConsultaTarjetasCreditoPorClienteIn/";

declare function xf:sjConsultaTarjetasCreditoPorClienteIn($customerIdType as xs:string,
    $customerIdValue as xs:string,
    $creditCardStatus as xs:string)
    as element(ns0:consultaTarjetasCreditoPorCliente) {
        <ns0:consultaTarjetasCreditoPorCliente>
            <CUSTOMER_FILTER>
                <CUSTOMER_ID_TYPE>{ $customerIdType }</CUSTOMER_ID_TYPE>
                <CUSTOMER_ID_VALUE>{ $customerIdValue }</CUSTOMER_ID_VALUE>
            </CUSTOMER_FILTER>
            <CREDIT_CARD_STATUS>{ $creditCardStatus }</CREDIT_CARD_STATUS>
        </ns0:consultaTarjetasCreditoPorCliente>
};

declare variable $customerIdType as xs:string external;
declare variable $customerIdValue as xs:string external;
declare variable $creditCardStatus as xs:string external;

xf:sjConsultaTarjetasCreditoPorClienteIn($customerIdType,
    $customerIdValue,
    $creditCardStatus)
