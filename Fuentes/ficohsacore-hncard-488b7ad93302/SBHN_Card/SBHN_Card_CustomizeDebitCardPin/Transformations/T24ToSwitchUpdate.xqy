xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../Schemas/services_1.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoEnviadoSwitchTypes";
(:: import schema at "../Schemas/procesaMensajeGenericoEnviadoSwitchTypes.xsd" ::)

declare variable $T24ToSwitchUpdate as element() (:: schema-element(ns1:getCustomizeDebitCardPinResponse) ::) external;
declare variable $bitmap as xs:string external;
declare variable $AdviceReason as xs:string external;

declare function local:funcT24ToSwitchUpdate($T24ToSwitchUpdate as element() (:: schema-element(ns1:getCustomizeDebitCardPinResponse) ::),
                                              $bitmap as xs:string,
                                              $AdviceReason as xs:string) as element() (:: schema-element(ns2:procesaMensajeGenericoEnviadoSwitch) ::) {
    <ns2:procesaMensajeGenericoEnviadoSwitch>
        <MESSAGE_DATA>
            <MESSAGE_DATA_ITEM>
                <MTI>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/MESSAGETYPEINDICATOR)}</MTI>
                <PROCESSING_CODE>000000</PROCESSING_CODE>
                <HEADER_MESSAGE_DETAILS>
                    <ITEM>
                        <KEY>EXTERNAL_MESSAGE</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/EXTERNALMESSAGE)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>PRODUCT_INDICATOR</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/PRODUCTINDICATOR)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>FIELD_SETTING</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/FIELDSETTING)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>STATUS_INDICATOR</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/STATUSINDICATOR)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>INTERFACE_HOST</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/INTERFACEHOST)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>HEADER_RESPONSE_CODE</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/RESPONSECODE)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>MESSAGE_TYPE_INDICATOR</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/MESSAGETYPEINDICATOR)}</VALUE>
                    </ITEM>
                    
                </HEADER_MESSAGE_DETAILS>
                
                <BODY_MESSAGE_DETAILS>
                    <ITEM>
                        <KEY>BITMAP_EXTENDED</KEY>
                        <VALUE>{fn:data($bitmap)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>PRIMARY_ACCOUNT_NUMBER</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/P2PRIMARYACCOUNTNUMBER)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>TRANSMISSION_DATETIME</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/P7TRANSMISSIONDATETIME)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>SYSTEMS_TRACE_AUDIT_NUMBER</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/P11SYSTRACEAUDITNUMBER)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>ADDITIONAL_DATA_PRIVATE</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/P48ADDITIONALDATA)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>TRANSACTION_CURRENCY_CODE</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/P49TRANSACTIONCURRENCYCODE)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>ADVICE_REASON_CODE</KEY>
                        <VALUE>{data($AdviceReason)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>FILE_UPDATE_CODE</KEY>
                        <VALUE>2</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>FILE_NAME</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/S101FILENAME)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>RESERVED_FOR_PRIVATE_USE_1</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/S120APPFILEANDTABLEINFO)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>RESERVED_FOR_PRIVATE_USE_2</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/S121APPFILEANDTABLEINFO)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>RESERVED_FOR_PRIVATE_USE_3</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/S122APPFILEANDTABLEINFO)}</VALUE>
                    </ITEM>
                    
                    <ITEM>
                        <KEY>ISSUER_TRACE_ID</KEY>
                        <VALUE>{fn:data($T24ToSwitchUpdate/FICOENQUPDPVVType/gFICOENQUPDPVVDetailType/mFICOENQUPDPVVDetailType/S126APPFILEANDTABLEINFO)}</VALUE>
                    </ITEM>
                </BODY_MESSAGE_DETAILS>
            </MESSAGE_DATA_ITEM>
        </MESSAGE_DATA>
    </ns2:procesaMensajeGenericoEnviadoSwitch>
};

local:funcT24ToSwitchUpdate($T24ToSwitchUpdate, $bitmap, $AdviceReason)
