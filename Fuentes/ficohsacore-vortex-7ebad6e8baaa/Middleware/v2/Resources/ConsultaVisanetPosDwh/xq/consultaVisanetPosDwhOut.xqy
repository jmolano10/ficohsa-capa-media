xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaVisanetPosDwhResponse" location="../xsd/consultaVisanetPosDwhTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaVisanetPosDwhTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaVisanetPosDwh/xq/consultaVisanetPosDwhOut/";

declare function xf:consultaVisanetPosDwhOut($outputParameters1 as node())
    as element(ns0:consultaVisanetPosDwhResponse) {
        <ns0:consultaVisanetPosDwhResponse>
            <ns0:MERCHANTS>
                {
                    for $merchant in $outputParameters1/MERCHANT
                    return
                        <ns0:MERCHANT>
                            <ns0:MERCHANT_ID>{ $merchant/MERCHANT_ID/text() }</ns0:MERCHANT_ID>
                            <ns0:MERCHANT_NAME>{ $merchant/MERCHANT_NAME/text() }</ns0:MERCHANT_NAME>
                            <ns0:MERCHANT_CATEGORY_CODE>{ $merchant/MERCHANT_CATEGORY_CODE/text() }</ns0:MERCHANT_CATEGORY_CODE>
                            <ns0:MERCHANT_CATEGORY_NAME>{ $merchant/MERCHANT_CATEGORY_NAME/text() }</ns0:MERCHANT_CATEGORY_NAME>
                            <ns0:STATUS_DESCRIPTION>{ $merchant/STATUS_DESCRIPTION/text() }</ns0:STATUS_DESCRIPTION>
                            <ns0:TAX_ID>{ $merchant/TAX_ID/text() }</ns0:TAX_ID>
                            <ns0:MERCHANT_TYPE>{ $merchant/MERCHANT_TYPE/text() }</ns0:MERCHANT_TYPE>
                            <ns0:CONTACT_ID>{ $merchant/CONTACT_ID/text() }</ns0:CONTACT_ID>
                            <ns0:MERCHANT_CONTACT_NAME>{ $merchant/MERCHANT_CONTACT_NAME/text() }</ns0:MERCHANT_CONTACT_NAME>
                            <ns0:MDR_BG_NAME>{ $merchant/MDR_BG_NAME/text() }</ns0:MDR_BG_NAME>
                            <ns0:MDR_CI_NAME>{ $merchant/MDR_CI_NAME/text() }</ns0:MDR_CI_NAME>
                            <ns0:MDR_VC_NAME>{ $merchant/MDR_VC_NAME/text() }</ns0:MDR_VC_NAME>
                            <ns0:MDR_LU_NAME>{ $merchant/MDR_LU_NAME/text() }</ns0:MDR_LU_NAME>
                            
                            <ns0:CARD_ACQUIRES>
                                {
                                    for $cardAcquire in $merchant/CARD_ACQUIRES/CARD_ACQUIRE
                                    return
                                        <ns0:CARD_ACQUIRE>
                                            <ns0:CARD_ACQUIRER_ID>{ $cardAcquire/CARD_ACQUIRER_ID/text() }</ns0:CARD_ACQUIRER_ID>
                                            <ns0:CARD_ACQUIRER_NAME>{ $cardAcquire/CARD_ACQUIRER_NAME/text() }</ns0:CARD_ACQUIRER_NAME>
                                            <ns0:CARD_ACQUIRER_ACTIVE>{ $cardAcquire/CARD_ACQUIRER_ACTIVE/text() }</ns0:CARD_ACQUIRER_ACTIVE>
                                            <ns0:CLEARING_CURRENCY>{ $cardAcquire/CLEARING_CURRENCY/text() }</ns0:CLEARING_CURRENCY>
                                            <ns0:CARD_ACQUIRER_CONTACT_NAME>{ $cardAcquire/CARD_ACQUIRER_CONTACT_NAME/text() }</ns0:CARD_ACQUIRER_CONTACT_NAME>
                                            <ns0:PHONE>{ $cardAcquire/PHONE/text() }</ns0:PHONE>
                                            <ns0:ADDRESS>
                                                <ns0:BRANCH_ADDRESS>{ $cardAcquire/ADDRESS/BRANCH_ADDRESS/text() }</ns0:BRANCH_ADDRESS>
                                                <ns0:CITY>{ $cardAcquire/ADDRESS/CITY/text() }</ns0:CITY>
                                                <ns0:TOWN>{ $cardAcquire/ADDRESS/TOWN/text() }</ns0:TOWN>
                                            </ns0:ADDRESS>
                                            <ns0:TERMINALS>
                                                {
                                                    for $terminal in $cardAcquire/TERMINALS/TERMINAL
                                                    return
                                                        <ns0:TERMINAL>
                                                            <ns0:TERMINAL_ID>{ $terminal/TERMINAL_ID/text() }</ns0:TERMINAL_ID>
                                                            <ns0:TERMINAL_ACTIVE>{ $terminal/TERMINAL_ACTIVE/text() }</ns0:TERMINAL_ACTIVE>
                                                            <ns0:VISA_TERMINAL_TYPE>{ $terminal/VISA_TERMINAL_TYPE/text() }</ns0:VISA_TERMINAL_TYPE>
                                                            <ns0:QUOTES_PROFILE>{ $terminal/QUOTES_PROFILE/text() }</ns0:QUOTES_PROFILE>
                                                            <ns0:CHECKOUT_RATE>{ $terminal/CHECKOUT_RATE/text() }</ns0:CHECKOUT_RATE>
                                                            <ns0:CARD_PRESENCE_REQUIRED>{ $terminal/CARD_PRESENCE_REQUIRED/text() }</ns0:CARD_PRESENCE_REQUIRED>
                                                        </ns0:TERMINAL>
                                                }
                                            </ns0:TERMINALS>
                                            <ns0:EMAILS>
                                                {
                                                    for $email in $cardAcquire/EMAILS/EMAIL
                                                    return
                                                        <ns0:EMAIL>
                                                            <ns0:CORRELATIVE>{ $email/CORRELATIVE/text() }</ns0:CORRELATIVE>
                                                            <ns0:EMAIL>{ $email/EMAIL/text() }</ns0:EMAIL>
                                                        </ns0:EMAIL>
                                                }
                                            </ns0:EMAILS>
                                        </ns0:CARD_ACQUIRE>
                                }
                            </ns0:CARD_ACQUIRES>
                        </ns0:MERCHANT>
                }
            </ns0:MERCHANTS>
        </ns0:consultaVisanetPosDwhResponse>
};

declare variable $outputParameters1 as node() external;

xf:consultaVisanetPosDwhOut($outputParameters1)