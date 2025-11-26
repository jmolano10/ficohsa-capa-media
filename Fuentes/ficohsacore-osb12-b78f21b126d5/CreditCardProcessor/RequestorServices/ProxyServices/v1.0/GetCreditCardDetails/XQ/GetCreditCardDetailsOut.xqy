xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/getCreditCardDetailsTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getCreditCardDetailsTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCreditCardData";
(:: import schema at "../../../../../ProviderServices/XSD/GetCreditCardData/GetCreditCardData_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCreditCardDetails_V2";
(:: import schema at "../../../../../ProviderServices/XSD/GetCreditCardDetails/GetCreditCardDetails_V2_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $GetCreditCardDataResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $GetCreditCardDetailsResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $tipoTarjeta as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($GetCreditCardDataResponse as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $GetCreditCardDetailsResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $tipoTarjeta as xs:string,
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns3:getCreditCardDetailsResponse) ::) {
    <ns3:getCreditCardDetailsResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:GetCreditCardDetailsResponseType>
            {
              if(not(empty($GetCreditCardDetailsResponse/ns2:PT_DATOS_TARJETA/ns2:PT_DATOS_TARJETA_ITEM[1])))then(
                for $PT_DATOS_TARJETA_ITEM in $GetCreditCardDetailsResponse/ns2:PT_DATOS_TARJETA/ns2:PT_DATOS_TARJETA_ITEM
                return 
                <ns3:GetCreditCardDetailsResponseRecordType>
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:CARD_NUMBER)
                        then <ns3:CardNumber>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:CARD_NUMBER)}</ns3:CardNumber>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_HOLDER_NAME)
                        then <ns3:AccountHolderName>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_HOLDER_NAME)}</ns3:AccountHolderName>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:CARD_HOLDER_NAME)
                        then <ns3:CardHolderName>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:CARD_HOLDER_NAME)}</ns3:CardHolderName>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:CARD_TYPE)
                        then <ns3:CardType>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:CARD_TYPE)}</ns3:CardType>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:CUSTOMER_ID)
                        then <ns3:CustomerId>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:CUSTOMER_ID)}</ns3:CustomerId>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:CARD_HOLDER_LEGAL_ID)
                        then <ns3:CardHolderLegalId>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:CARD_HOLDER_LEGAL_ID)}</ns3:CardHolderLegalId>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_HOLDER_LEGAL_ID)
                        then <ns3:AccountHolderLegalId>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_HOLDER_LEGAL_ID)}</ns3:AccountHolderLegalId>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_NUMBER)
                        then <ns3:AccountNumber>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_NUMBER)}</ns3:AccountNumber>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:PRODUCT)
                        then <ns3:Product>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:PRODUCT)}</ns3:Product>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:AFINITY_GROUP)
                        then <ns3:AfinityGroup>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:AFINITY_GROUP)}</ns3:AfinityGroup>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_STATUS)
                        then <ns3:AccountStatus>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:ACCOUNT_STATUS)}</ns3:AccountStatus>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:CARD_STATUS)
                        then <ns3:CardStatus>{fn:data($PT_DATOS_TARJETA_ITEM/ns2:CARD_STATUS)}</ns3:CardStatus>
                        else ()
                    }
                    {
                        if ($PT_DATOS_TARJETA_ITEM/ns2:CARD_EXPIRATION_DATE)
                        then <ns3:CardExpirationDate>{substring(xs:string(xs:dateTime($PT_DATOS_TARJETA_ITEM/ns2:CARD_EXPIRATION_DATE)),1,10)}</ns3:CardExpirationDate>
                        else ()
                    }</ns3:GetCreditCardDetailsResponseRecordType>
                )else(
                      <ns3:GetCreditCardDetailsResponseRecordType>
                          <ns3:CardNumber>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numtarjeta"])}</ns3:CardNumber>
                          <ns3:AccountHolderName>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_name"])}</ns3:AccountHolderName>
                          <ns3:CardHolderName>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="cardholder_name"])}</ns3:CardHolderName>
                          <ns3:CardType>{$tipoTarjeta}</ns3:CardType>
                          <ns3:CustomerId>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="customer_id"])}</ns3:CustomerId>
                          <ns3:CardHolderLegalId>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="card_holder_id"])}</ns3:CardHolderLegalId>
                          <ns3:AccountHolderLegalId>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_holder_legal_id"])}</ns3:AccountHolderLegalId>
                          <ns3:AccountNumber>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numcuenta"])}</ns3:AccountNumber>
                          <ns3:Product>TRC</ns3:Product>
                          <ns3:AfinityGroup>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="logo"])}</ns3:AfinityGroup>
                          <ns3:AccountStatus>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoCuenta"])}</ns3:AccountStatus>
                          <ns3:CardStatus>{fn:data($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoPlastico"])}</ns3:CardStatus>
                          <ns3:CardExpirationDate>{substring(xs:string(xs:dateTime($GetCreditCardDataResponse/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="fecexpira"])),1,10)}</ns3:CardExpirationDate>
                      </ns3:GetCreditCardDetailsResponseRecordType>
                )
            }
        </ns3:GetCreditCardDetailsResponseType>
    </ns3:getCreditCardDetailsResponse>
};

local:func($GetCreditCardDataResponse, $GetCreditCardDetailsResponse, $tipoTarjeta, $uuid)