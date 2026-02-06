xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraTarjetaDebitoResponse1" element="ns1:ConsultaMaestraTarjetaDebitoResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTDClienteResponse" location="consultaTDClienteTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTDClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteOut/";

declare function xf:consultaTDClienteOut($consultaMaestraTarjetaDebitoResponse1 as element(ns1:ConsultaMaestraTarjetaDebitoResponse))
    as element(ns0:consultaTDClienteResponse) {
        <ns0:consultaTDClienteResponse>
            {
                for $CUSTOMER in $consultaMaestraTarjetaDebitoResponse1/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType[1]/CUSTOMER
                return
                    <CUSTOMER_ID>{ data($CUSTOMER) }</CUSTOMER_ID>
            }
            <ns0:consultaTDClienteResponseType>
                {
                    for $mWSFICODEBITCARDCUSTOMERDetailType in $consultaMaestraTarjetaDebitoResponse1/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType
                    return
                        <ns0:consultaTDClienteResponseRecordType>
                            {
                                for $CARDNUMBER in $mWSFICODEBITCARDCUSTOMERDetailType/CARDNUMBER
                                return
                                    <CARD_NUMBER>{ data($CARDNUMBER) }</CARD_NUMBER>
                            }
                            {
                                for $NAMEONCARD in $mWSFICODEBITCARDCUSTOMERDetailType/NAMEONCARD
                                return
                                    <CARD_HOLDER_NAME>{ data($NAMEONCARD) }</CARD_HOLDER_NAME>
                            }
                            {
                                for $TYPEOFCARD in $mWSFICODEBITCARDCUSTOMERDetailType/TYPEOFCARD
                                return
                                    <CARD_CATEGORY>{ data($TYPEOFCARD) }</CARD_CATEGORY>
                            }
                            {
                                for $PRODUCTTYPE in $mWSFICODEBITCARDCUSTOMERDetailType/PRODUCTTYPE
                                return
                                    <CARD_TYPE>{ data($PRODUCTTYPE) }</CARD_TYPE>
                            }
                            {
                                for $ISSUEDATE in $mWSFICODEBITCARDCUSTOMERDetailType/ISSUEDATE
                                return
                                    <ISSUE_DATE>{ data($ISSUEDATE) }</ISSUE_DATE>
                            }
                            {
                                for $CARDNUMBER in $mWSFICODEBITCARDCUSTOMERDetailType/CARDNUMBER
                                return
                                                            
                                 if (substring(data($CARDNUMBER), 1,1) = '4') then (
                                    <CARD_BRAND>VISA</CARD_BRAND>
            					 ) else if (substring(data($CARDNUMBER), 1,1) = '5') then (
            						<CARD_BRAND>MASTER CARD</CARD_BRAND>
            					 ) else if (substring(data($CARDNUMBER), 1,1) = '3') then (
            						<CARD_BRAND>AMERICAN EXPRESS</CARD_BRAND>
                                 ) else (
                                    <CARD_BRAND>OTRA</CARD_BRAND>
                                 )                          
                            }
                            {
                                for $CURRENCY1 in $mWSFICODEBITCARDCUSTOMERDetailType/CURRENCY1
                                return
                                    <CARD_CURRENCY>{ data($CURRENCY1) }</CARD_CURRENCY>
                            }
                            {
                                for $PRIMARYACCT in $mWSFICODEBITCARDCUSTOMERDetailType/PRIMARYACCT
                                return
                                    <CARD_ACCOUNT_NUMBER>{ data($PRIMARYACCT) }</CARD_ACCOUNT_NUMBER>
                            }
                        </ns0:consultaTDClienteResponseRecordType>
                }
            </ns0:consultaTDClienteResponseType>
        </ns0:consultaTDClienteResponse>
};

declare variable $consultaMaestraTarjetaDebitoResponse1 as element(ns1:ConsultaMaestraTarjetaDebitoResponse) external;

xf:consultaTDClienteOut($consultaMaestraTarjetaDebitoResponse1)