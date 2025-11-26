xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCreditCardDetailsTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getCreditCardDetailsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegisterCreditCardData";
(:: import schema at "../../../../../ProviderServices/XSD/RegisterCreditCardData/RegisterCreditCardData_sp.xsd" ::)

declare variable $GetCreditCardDetailsResponse as element() (:: schema-element(ns1:getCreditCardDetailsResponse) ::) external;
declare variable $country as xs:string external;

declare function local:func($GetCreditCardDetailsResponse as element() (:: schema-element(ns1:getCreditCardDetailsResponse) ::), 
                            $country as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PT_DATOS_TARJETA>
            <ns2:PT_DATOS_TARJETA_ITEM>
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardNumber)
                    then <ns2:CARD_NUMBER>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardNumber)}</ns2:CARD_NUMBER>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountHolderName)
                    then <ns2:ACCOUNT_HOLDER_NAME>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountHolderName)}</ns2:ACCOUNT_HOLDER_NAME>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardHolderName)
                    then <ns2:CARD_HOLDER_NAME>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardHolderName)}</ns2:CARD_HOLDER_NAME>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardType)
                    then <ns2:CARD_TYPE>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardType)}</ns2:CARD_TYPE>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CustomerId)
                    then <ns2:CUSTOMER_ID>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CustomerId)}</ns2:CUSTOMER_ID>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardHolderLegalId)
                    then <ns2:CARD_HOLDER_LEGAL_ID>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardHolderLegalId)}</ns2:CARD_HOLDER_LEGAL_ID>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountHolderLegalId)
                    then <ns2:ACCOUNT_HOLDER_LEGAL_ID>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountHolderLegalId)}</ns2:ACCOUNT_HOLDER_LEGAL_ID>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountNumber)
                    then <ns2:ACCOUNT_NUMBER>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountNumber)}</ns2:ACCOUNT_NUMBER>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:Product)
                    then <ns2:PRODUCT>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:Product)}</ns2:PRODUCT>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AfinityGroup)
                    then <ns2:AFINITY_GROUP>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AfinityGroup)}</ns2:AFINITY_GROUP>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountStatus)
                    then <ns2:ACCOUNT_STATUS>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:AccountStatus)}</ns2:ACCOUNT_STATUS>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardStatus)
                    then <ns2:CARD_STATUS>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardStatus)}</ns2:CARD_STATUS>
                    else ()
                }
                {
                    if ($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardExpirationDate)
                    then <ns2:CARD_EXPIRATION_DATE>{fn:data($GetCreditCardDetailsResponse/ns1:GetCreditCardDetailsResponseType/ns1:GetCreditCardDetailsResponseRecordType/ns1:CardExpirationDate)}</ns2:CARD_EXPIRATION_DATE>
                    else ()
                }
            </ns2:PT_DATOS_TARJETA_ITEM>
        </ns2:PT_DATOS_TARJETA>
        <ns2:PV_COUNTRY_CODE>{fn:data($country)}</ns2:PV_COUNTRY_CODE>
    </ns2:InputParameters>
};

local:func($GetCreditCardDetailsResponse, $country)