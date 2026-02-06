xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorClienteResponse" element="ns0:consultaTarjetasCreditoPorClienteResponse" location="../../ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesaMensajeGenericoT24Response" location="../../../../v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaTarjetasCreditoPorClienteFacade/xq/consultaTarjetasCreditoPorClienteFacadeOut/";

declare function xf:consultaTarjetasCreditoPorClienteFacadeOut($consultaTarjetasCreditoPorClienteResponse as element(ns0:consultaTarjetasCreditoPorClienteResponse),
    $transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string)
    as element(ns1:procesaMensajeGenericoT24Response) {
        <ns1:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>
            {
                if (upper-case($errorCode) = 'SUCCESS' and $validationMessage != 'NO RECORDS') then
                    let $cardsString :=
                        for $cardInfo in $consultaTarjetasCreditoPorClienteResponse/CREDIT_CARDS/CREDIT_CARD_INFORMATION
                        return
                            concat(
                                '@GM',
                                $cardInfo/CREDIT_CARD_NUMBER, '@FM',
                                $cardInfo/ACCOUNT_NUMBER, '@FM',
                                $cardInfo/CARD_HOLDER_NAME, '@FM',
                                $cardInfo/CARD_TYPE, '@FM',
                                $cardInfo/CARD_BRAND, '@FM',
                                $cardInfo/STATUS, '@FM',
                                $cardInfo/PRODUCT_TYPE, '@FM',
                                $cardInfo/AFFINITY_GROUP, '@FM',
                                $cardInfo/CARD_EFFECTIVE_DATE, '@FM',    
                                for $additionalInfo in $cardInfo/ADDITIONAL_INFORMATION/FIELD_INFORMATION
                                return
                                    concat(
                                        '@VM',
                                        $additionalInfo/NAME_FIELD, '@FM',
                                        $additionalInfo/VALUE_FIELD
                                    )
                            )
                    return concat('Success||', string-join($cardsString, ''))
                else if($validationMessage = 'NO RECORDS') then
                	concat('ERROR|', $validationMessage)
                else
                    concat($errorCode, '|', $validationMessage)
            }
        </MESSAGE>
        </ns1:procesaMensajeGenericoT24Response>
};

declare variable $consultaTarjetasCreditoPorClienteResponse as element(ns0:consultaTarjetasCreditoPorClienteResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:consultaTarjetasCreditoPorClienteFacadeOut($consultaTarjetasCreditoPorClienteResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $validationMessage)