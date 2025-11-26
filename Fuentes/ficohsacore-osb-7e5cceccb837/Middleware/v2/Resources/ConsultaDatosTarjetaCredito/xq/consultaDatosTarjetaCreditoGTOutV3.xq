xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse" element="ns0:consultaDatosTarjetaCreditoResponse" location="../../../../v3/BusinessServices/OSB/ConsultaDatosTarjetaCredito_v3/xsd/XMLSchema_-1080362392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCreditoResponse" location="../xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoGTOutV3/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";

declare function xf:consultaDatosTarjetaCreditoGTOutV3($consultaDatosTarjetaCreditoResponse as element(ns0:consultaDatosTarjetaCreditoResponse),
	$estadoCuenta as xs:string,
	$estadoPlastico as xs:string
	)
    as element(ns0:consultaDatosTarjetaCreditoResponse) {
        <ns0:consultaDatosTarjetaCreditoResponse>
            {
                for $CARD_NUMBER in $consultaDatosTarjetaCreditoResponse/CARD_NUMBER
                return
                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
            }
            {
                for $ACCOUNT_NUMBER in $consultaDatosTarjetaCreditoResponse/ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $CARD_HOLDER_NAME in $consultaDatosTarjetaCreditoResponse/CARD_HOLDER_NAME
                return
                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
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
                for $CUSTOMER_ID in $consultaDatosTarjetaCreditoResponse/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            <ACCOUNT_STATUS>{ $estadoCuenta }</ACCOUNT_STATUS>
            {
                for $CARD_TYPE in $consultaDatosTarjetaCreditoResponse/CARD_TYPE
                return
                    <CARD_TYPE>{ data($CARD_TYPE) }</CARD_TYPE>
            }
            {
                for $AFINITY_GROUP in $consultaDatosTarjetaCreditoResponse/AFINITY_GROUP
                return
                    <AFINITY_GROUP>{ data($AFINITY_GROUP) }</AFINITY_GROUP>
            }
            <CARD_CURRENCY_INFORMATION>
                {
                    for $ORG_IND in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/ORG_IND
                    return
                        <ORG_IND>{ data($ORG_IND) }</ORG_IND>
                }
                {
                    for $ORG in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/ORG
                    return
                        <ORG>{ data($ORG) }</ORG>
                }
                {
                    for $CURRENCY in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/CURRENCY
                    return
                        <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                }
                {
                    for $ANUAL_PURCHASE_LIMIT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/ANUAL_PURCHASE_LIMIT
                    return
                        <ANUAL_PURCHASE_LIMIT>{ data($ANUAL_PURCHASE_LIMIT) }</ANUAL_PURCHASE_LIMIT>
                }
                {
                    for $ANUAL_WITHDRAWAL_LIMIT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/ANUAL_WITHDRAWAL_LIMIT
                    return
                        <ANUAL_WITHDRAWAL_LIMIT>{ data($ANUAL_WITHDRAWAL_LIMIT) }</ANUAL_WITHDRAWAL_LIMIT>
                }
                {
                    for $MONTHLY_PURCHASE_LIMIT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/MONTHLY_PURCHASE_LIMIT
                    return
                        <MONTHLY_PURCHASE_LIMIT>{ data($MONTHLY_PURCHASE_LIMIT) }</MONTHLY_PURCHASE_LIMIT>
                }
                {
                    for $MONTHLY_WITHDRAWAL_LIMIT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/MONTHLY_WITHDRAWAL_LIMIT
                    return
                        <MONTHLY_WITHDRAWAL_LIMIT>{ data($MONTHLY_WITHDRAWAL_LIMIT) }</MONTHLY_WITHDRAWAL_LIMIT>
                }
                {
                    for $DAILY_PURCHASE_LIMIT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/DAILY_PURCHASE_LIMIT
                    return
                        <DAILY_PURCHASE_LIMIT>{ data($DAILY_PURCHASE_LIMIT) }</DAILY_PURCHASE_LIMIT>
                }
                {
                    for $DAILY_WITHDRAWAL_LIMIT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/DAILY_WITHDRAWAL_LIMIT
                    return
                        <DAILY_WITHDRAWAL_LIMIT>{ data($DAILY_WITHDRAWAL_LIMIT) }</DAILY_WITHDRAWAL_LIMIT>
                }
                {
                    for $CARD_ACTIVATION_DATE in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/CARD_ACTIVATION_DATE
                    return
                        <CARD_ACTIVATION_DATE>{ data($CARD_ACTIVATION_DATE) }</CARD_ACTIVATION_DATE>
                }
                <CARD_STATUS>{ $estadoPlastico }</CARD_STATUS>
                {
                    for $CARD_EXPIRATION_DATE in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/CARD_EXPIRATION_DATE
                    return
                        <CARD_EXPIRATION_DATE>{ data($CARD_EXPIRATION_DATE) }</CARD_EXPIRATION_DATE>
                }
                {
                    for $EMBOSSED_NUMBER in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/EMBOSSED_NUMBER
                    return
                        <EMBOSSED_NUMBER>{ data($EMBOSSED_NUMBER) }</EMBOSSED_NUMBER>
                }
                {
                    for $BLOCK_CODE in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/BLOCK_CODE
                    return
                        <BLOCK_CODE>{ data($BLOCK_CODE) }</BLOCK_CODE>
                }
                {
                    for $BLOCK_REASON in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/BLOCK_REASON
                    return
                        <BLOCK_REASON>{ data($BLOCK_REASON) }</BLOCK_REASON>
                }
                {
                    for $BLOCK_DATE in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/BLOCK_DATE
                    return
                        <BLOCK_DATE>{ data($BLOCK_DATE) }</BLOCK_DATE>
                }
                {
                    for $PRODUCT in $consultaDatosTarjetaCreditoResponse/CARD_CURRENCY_INFORMATION[1]/PRODUCT
                    return
                        <PRODUCT>{ data($PRODUCT) }</PRODUCT>
                }
            </CARD_CURRENCY_INFORMATION>
        </ns0:consultaDatosTarjetaCreditoResponse>
};

declare variable $consultaDatosTarjetaCreditoResponse as element(ns0:consultaDatosTarjetaCreditoResponse) external;
declare variable $estadoCuenta as xs:string external;
declare variable $estadoPlastico as xs:string external;

xf:consultaDatosTarjetaCreditoGTOutV3($consultaDatosTarjetaCreditoResponse,
	$estadoCuenta,
	$estadoPlastico)