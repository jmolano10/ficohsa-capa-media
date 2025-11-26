(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse" element="ns0:consultaDatosTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCreditoResponse" location="../xsd/consultaDatosTarjetaCreditoCBTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoCBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCreditoCB/xq/consultaDatosTarjetaCreditoCBOut/";

declare function xf:consultaDatosTarjetaCreditoCBOut($consultaDatosTarjetaCreditoResponse as element(ns0:consultaDatosTarjetaCreditoResponse))
    as element(ns1:consultaDatosTarjetaCreditoResponse) {
        <ns1:consultaDatosTarjetaCreditoResponse>
            <ns1:consultaDatosTarjetaCreditoResponseType>
                {
                    for $consultaDatosTarjetaCreditoResponseRecordType in $consultaDatosTarjetaCreditoResponse/ns0:consultaDatosTarjetaCreditoResponseType/ns0:consultaDatosTarjetaCreditoResponseRecordType
                    return
                        <ns1:consultaDatosTarjetaCreditoResponseRecordType>
                            {
                                for $CARD_NUMBER in $consultaDatosTarjetaCreditoResponseRecordType/CARD_NUMBER
                                return
                                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
                            }
                            {
                                for $ACCOUNT_HOLDER_NAME in $consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_HOLDER_NAME
                                return
                                    <ACCOUNT_HOLDER_NAME>{ data($ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>
                            }
                            {
                                for $CARD_HOLDER_NAME in $consultaDatosTarjetaCreditoResponseRecordType/CARD_HOLDER_NAME
                                return
                                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
                            }
                            {
                                for $CARD_TYPE in $consultaDatosTarjetaCreditoResponseRecordType/CARD_TYPE
                                return
                                    <CARD_TYPE>{ data($CARD_TYPE) }</CARD_TYPE>
                            }
                            {
                                for $CUSTOMER_ID in $consultaDatosTarjetaCreditoResponseRecordType/CUSTOMER_ID
                                return
                                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
                            }
                            {
                                for $CARD_HOLDER_LEGAL_ID in $consultaDatosTarjetaCreditoResponseRecordType/CARD_HOLDER_LEGAL_ID
                                return
                                    <CARD_HOLDER_LEGAL_ID>{ data($CARD_HOLDER_LEGAL_ID) }</CARD_HOLDER_LEGAL_ID>
                            }
                            {
                                for $ACCOUNT_HOLDER_LEGAL_ID in $consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_HOLDER_LEGAL_ID
                                return
                                    <ACCOUNT_HOLDER_LEGAL_ID>{ data($ACCOUNT_HOLDER_LEGAL_ID) }</ACCOUNT_HOLDER_LEGAL_ID>
                            }
                            {
                                for $ACCOUNT_NUMBER in $consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_NUMBER
                                return
                                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                            }
                            {
                                for $PRODUCT in $consultaDatosTarjetaCreditoResponseRecordType/PRODUCT
                                return
                                    <PRODUCT>{ data($PRODUCT) }</PRODUCT>
                            }
                            {
                                for $AFINITY_GROUP in $consultaDatosTarjetaCreditoResponseRecordType/AFINITY_GROUP
                                return
                                    <AFINITY_GROUP>{ data($AFINITY_GROUP) }</AFINITY_GROUP>
                            }
                            {
                                for $ACCOUNT_STATUS in $consultaDatosTarjetaCreditoResponseRecordType/ACCOUNT_STATUS
                                return
                                    <ACCOUNT_STATUS>{ data($ACCOUNT_STATUS) }</ACCOUNT_STATUS>
                            }
                            {
                                for $CARD_STATUS in $consultaDatosTarjetaCreditoResponseRecordType/CARD_STATUS
                                return
                                    <CARD_STATUS>{ data($CARD_STATUS) }</CARD_STATUS>
                            }
                            {
                                for $CARD_EXPIRATION_DATE in $consultaDatosTarjetaCreditoResponseRecordType/CARD_EXPIRATION_DATE
                                return
                                    <CARD_EXPIRATION_DATE>{ data($CARD_EXPIRATION_DATE) }</CARD_EXPIRATION_DATE>
                            }
                        </ns1:consultaDatosTarjetaCreditoResponseRecordType>
                }
            </ns1:consultaDatosTarjetaCreditoResponseType>
        </ns1:consultaDatosTarjetaCreditoResponse>
};

declare variable $consultaDatosTarjetaCreditoResponse as element(ns0:consultaDatosTarjetaCreditoResponse) external;

xf:consultaDatosTarjetaCreditoCBOut($consultaDatosTarjetaCreditoResponse)