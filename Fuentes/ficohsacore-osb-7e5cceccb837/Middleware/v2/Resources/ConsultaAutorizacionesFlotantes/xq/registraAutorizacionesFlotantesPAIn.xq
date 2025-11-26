(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$ConDatoCuentaOut" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$VPFlotantesOut" element="ns0:OutstandingAuthorizationInquiryResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/RegistraFlotanteTC/xsd/registraAutorizacionesFlotantes_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraAutorizacionesFlotantes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAutorizacionesFlotantes/xq/registraAutorizacionesFlotantesPAIn/";

declare function xf:registraAutorizacionesFlotantesPAIn($resultGroup as element(*),
    $Country as xs:string,
    $ConDatoCuentaOut as element(ns1:OutputParameters),
    $VPFlotantesOut as element(ns0:OutstandingAuthorizationInquiryResponse),
    $startdate as xs:string,
    $enddate as xs:string,
    $org as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGO_PAIS>{ $Country }</ns2:PV_CODIGO_PAIS>
            <ns2:PT_CAF>
                <ns2:ACCOUNT_NUMBER>{ data($resultGroup/OUTSTANDING_AUTHORIZATION_INQUIRY_RESPONSES/ns0:OutstandingAuthorizationInquiryResponse[1]/OutstandingAuthArray/OutstandingAuthData[1]/OFXOAO-CARD-NBR)  }</ns2:ACCOUNT_NUMBER>
                <ns2:LOGO1>{ $org }</ns2:LOGO1>
                <ns2:AUTHORIZATION_ITEMS1>
                    {
                        for $nodes  in ($resultGroup/OUTSTANDING_AUTHORIZATION_INQUIRY_RESPONSES/ns0:OutstandingAuthorizationInquiryResponse)  
                        return
                            (<AUTHORIZATION>
                            <ORG>{ data($nodes/OFXOAO-ORG) }</ORG>
                            <CARD_NUMBER>{ data($nodes/OutstandingAuthArray/OutstandingAuthData[1]/OFXOAO-CARD-NBR) }</CARD_NUMBER>
                            <AUTHORIZATION_ITEMS>
                            {
                            for $authorization in $nodes/OutstandingAuthArray/OutstandingAuthData
                            return(
                            <AUTHORIZATION_ITEM>
                            <SEQUENCE_CARD>{ data($authorization/OFXOAO-CARD-SEQ) }</SEQUENCE_CARD>
                            <CREDIT_PLAN>{ data($authorization/OFXOAO-CREDIT-PLAN) }</CREDIT_PLAN>
                            <AVAILABLE_PURCHASE>{ data($authorization/OFXOAO-AVAIL-CREDIT) }</AVAILABLE_PURCHASE>
                            <CASH_AVAILABLE_CREDIT>{ data($authorization/OFXOAO-CASH-AVAIL-CREDIT) }</CASH_AVAILABLE_CREDIT>
                            <EFFECTIVE_DATE>{ data($authorization/OFXOAO-EFF-DATE) }</EFFECTIVE_DATE>
                            <TIME>{ data($authorization/OFXOAO-TIME) }</TIME>
                            <AUTH_AMOUNT>{ data($authorization/OFXOAO-AUTH-AMOUNT) }</AUTH_AMOUNT>
                            <ACTION>{ data($authorization/OFXOAO-ACTION) }</ACTION>
                            <ACTION_REASON>{ data($authorization/OFXOAO-ACTION-REASON) }</ACTION_REASON>
                            <REASON_DESCRIPTION>{ data($authorization/OFXOAO-REASON-DESC) }</REASON_DESCRIPTION>
                            <REQUEST_TYPE>{ data($authorization/OFXOAO-REQUEST-TYPE) }</REQUEST_TYPE>
                            <AUTH_TYPE>{ data($authorization/OFXOAO-AUTH-TYPE) }</AUTH_TYPE>
                            <AUTHORIZATION_CODE>{ data($authorization/OFXOAO-AUTHORIZATION-CODE) }</AUTHORIZATION_CODE>
                            <MERCH_CAT_CD>{ data($authorization/OFXOAO-MERCH-CAT-CD) }</MERCH_CAT_CD>
                            <CATEGORY_DESCRIPTION>{ data($authorization/OFXOAO-CATEGORY-DESC) }</CATEGORY_DESCRIPTION>
                            <NAME_LOCATION_CARD_ACCEPTOR>{ data($authorization/OFXOAO-CRD-ACCPT-NAME-LOC) }</NAME_LOCATION_CARD_ACCEPTOR>
                            <TRANSACTION_DESCRIPTION>{ data($authorization/OFXOAO-TRANSACTION-DESC) }</TRANSACTION_DESCRIPTION>
                            <TRANSACTION_ENTRY_MODE>{ data($authorization/OFXOAO-PAN-ENTRY-MODE) }</TRANSACTION_ENTRY_MODE>
                            <TRANSACTION_ENTRY_DESCRIPTION>{ data($authorization/OFXOAO-PAN-ENTRY-DESCRIPTION) }</TRANSACTION_ENTRY_DESCRIPTION>
                            <MERCHANT_CODE>{ data($authorization/OFXOAO-MER-CODE) }</MERCHANT_CODE>
                            <RESPONSE_CODE>{ data($authorization/OFXOAO-B039-RESP-CODE) }</RESPONSE_CODE>
                            <CURRENCY_CODE>{ data($authorization/OFXOAO-CURR-CODE) }</CURRENCY_CODE>
                            <CRD_ACCPT_ST_CTRY>{ data($authorization/OFXOAO-CRD-ACCPT-ST-CTRY) }</CRD_ACCPT_ST_CTRY>
                            <TRANSACTION_SOURCE>{ data($authorization/OFXOAO-TRANS-SOURCE) }</TRANSACTION_SOURCE>
                            <MERCHANT_CODE_2>{ data($authorization/OFXOAO-MERCH-CODE) }</MERCHANT_CODE_2>
                            <PROCESSING_CODE>{ data($authorization/OFXOAO-B003-PROC-CODE) }</PROCESSING_CODE>
                            <TRANSACTION_AMOUNT>{ data($authorization/OFXOAO-B004-TXN-AMT) }</TRANSACTION_AMOUNT>
                            <TRANSACTION_TIME>{ data($authorization/OFXOAO-AUTH-B012-LCL-TXN-TM) }</TRANSACTION_TIME>
                            <TRANSACTION_DATE>{ data($authorization/OFXOAO-REF-NBR) }</TRANSACTION_DATE>
                            <REFERENCE_NUMBER>{ data($authorization/OFXOAO-B013-LCL-TXN-DTE) }</REFERENCE_NUMBER>
                            <TRANSACTION_CURRENCY>{ data($authorization/OFXOAO-B049-CURR-CODE) }</TRANSACTION_CURRENCY>
                            </AUTHORIZATION_ITEM>
                            )
                            }
                            </AUTHORIZATION_ITEMS>
                            </AUTHORIZATION>)
                    }
</ns2:AUTHORIZATION_ITEMS1>
                <ns2:START_DATE>{$startdate}</ns2:START_DATE>
                <ns2:END_DATE>{$enddate}</ns2:END_DATE>
            </ns2:PT_CAF>
        </ns2:InputParameters>
};

declare variable $resultGroup as element(*) external;
declare variable $Country as xs:string external;
declare variable $ConDatoCuentaOut as element(ns1:OutputParameters) external;
declare variable $VPFlotantesOut as element(ns0:OutstandingAuthorizationInquiryResponse) external;
declare variable $startdate as xs:string external;
declare variable $enddate as xs:string external;
declare variable $org as xs:string external;

xf:registraAutorizacionesFlotantesPAIn($resultGroup,
    $Country,
    $ConDatoCuentaOut,
    $VPFlotantesOut,
    $startdate,
    $enddate,
    $org)
