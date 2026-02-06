xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse" element="ns0:consultaDatosTarjetaCreditoResponse" location="../../../../v3/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoPAOut/";

declare function transformarFecha($fecha as xs:string)
	as xs:string?{
		fn-bea:date-to-string-with-format("yyyyMMdd", xs:date($fecha))
};

declare function xf:consultaDatosTarjetaCreditoPAOut($consultaDatosTarjetaCreditoResponse as element(ns0:consultaDatosTarjetaCreditoResponse),
    $estadoPlastico as xs:string,
    $estadoCuenta as xs:string)
    as element(ns0:consultaDatosTarjetaCreditoResponse) {
        <ns0:consultaDatosTarjetaCreditoResponse>
            <ns0:consultaDatosTarjetaCreditoResponseType>
                <ns0:consultaDatosTarjetaCreditoResponseRecordType>
                    {
                        for $CARD_NUMBER in $consultaDatosTarjetaCreditoResponse/CARD_NUMBER
                        return
                            <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
                    }
                    {
                        for $ACCOUNT_HOLDER_NAME in $consultaDatosTarjetaCreditoResponse/ACCOUNT_HOLDER_NAME
                        return
                            <ACCOUNT_HOLDER_NAME>{ data($ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>
                    }
                    {
                        for $CARD_HOLDER_NAME in $consultaDatosTarjetaCreditoResponse/CARD_HOLDER_NAME
                        return
                            <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
                    }
                    {
                        for $CARD_TYPE in $consultaDatosTarjetaCreditoResponse/CARD_TYPE
                        return
                            <CARD_TYPE>{ data($CARD_TYPE) }</CARD_TYPE>
                    }
                    {
                        for $CUSTOMER_ID in $consultaDatosTarjetaCreditoResponse/CUSTOMER_ID
                        return
                            <CUSTOMER_ID>{ xs:long(data($CUSTOMER_ID)) }</CUSTOMER_ID>
                    }
                    {
                        for $CARD_HOLDER_LEGAL_ID in $consultaDatosTarjetaCreditoResponse/CARD_HOLDER_LEGAL_ID
                        return
                            <CARD_HOLDER_LEGAL_ID>{ data($CARD_HOLDER_LEGAL_ID) }</CARD_HOLDER_LEGAL_ID>
                    }
                    {
                        for $ACCOUNT_HOLDER_LEGAL_ID in $consultaDatosTarjetaCreditoResponse/ACCOUNT_HOLDER_LEGAL_ID
                        return
                            <ACCOUNT_HOLDER_LEGAL_ID>{ data($ACCOUNT_HOLDER_LEGAL_ID) }</ACCOUNT_HOLDER_LEGAL_ID>
                    }
                    {
                        for $ACCOUNT_NUMBER in $consultaDatosTarjetaCreditoResponse/ACCOUNT_NUMBER
                        return
                            <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $PRODUCT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/PRODUCT
                        return
                            <PRODUCT>{ data($PRODUCT) }</PRODUCT>
                    }
                    {
                        for $AFINITY_GROUP in $consultaDatosTarjetaCreditoResponse/AFINITY_GROUP
                        return
                            <AFINITY_GROUP>{ data($AFINITY_GROUP) }</AFINITY_GROUP>
                    }
                    <ACCOUNT_STATUS>{ $estadoCuenta }</ACCOUNT_STATUS>
                    <CARD_STATUS>{ $estadoPlastico }</CARD_STATUS>
                    {
                        for $CARD_EXPIRATION_DATE in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/CARD_EXPIRATION_DATE
                        return
                            <CARD_EXPIRATION_DATE>{transformarFecha(data($CARD_EXPIRATION_DATE))}</CARD_EXPIRATION_DATE>
                    }
                </ns0:consultaDatosTarjetaCreditoResponseRecordType>
            </ns0:consultaDatosTarjetaCreditoResponseType>
        </ns0:consultaDatosTarjetaCreditoResponse>
};

declare variable $consultaDatosTarjetaCreditoResponse as element(ns0:consultaDatosTarjetaCreditoResponse) external;
declare variable $estadoPlastico as xs:string external;
declare variable $estadoCuenta as xs:string external;

xf:consultaDatosTarjetaCreditoPAOut($consultaDatosTarjetaCreditoResponse,
    $estadoPlastico,
    $estadoCuenta)