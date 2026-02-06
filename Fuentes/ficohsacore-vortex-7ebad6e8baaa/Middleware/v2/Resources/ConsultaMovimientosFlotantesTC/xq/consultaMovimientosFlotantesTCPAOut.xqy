xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outstandingAuthorizationInquiryResponse" element="ns1:OutstandingAuthorizationInquiryResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosFlotantesTCResponse" location="../xsd/consultaMovimientosFlotantesTCTypes.xsd" ::)

declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosFlotantesTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosFlotantesTC/xq/consultaMovimientosFlotantesTCOut/";
declare namespace functx = "http://www.functx.com";
declare function functx:replace-first
  ( $arg as xs:string? ,
    $pattern as xs:string ,
    $replacement as xs:string )  as xs:string {

   replace($arg, concat('(^.*?)', $pattern),
             concat('$1',$replacement))
 } ;


declare function xf:consultaMovimientosFlotantesTCOut($outstandingAuthorizationInquiryResponse as element(ns1:OutstandingAuthorizationInquiryResponse),
    $cardHolderName as xs:string,
    $lcyAmmount as xs:string,
    $lcymovements as element(*),
    $carNumberRequest as xs:string)
    as element(ns0:consultaMovimientosFlotantesTCResponse) {
        <ns0:consultaMovimientosFlotantesTCResponse>
            <OWNER_NAME>{ $cardHolderName }</OWNER_NAME>
            <PRINCIPAL_CARD_NUMBER>{fn-bea:trim(fn:replace(fn:string(functx:replace-first($carNumberRequest, '0', '-')),"-", " "))}</PRINCIPAL_CARD_NUMBER>
            <TOTAL_LCY_AMOUNT>0.00</TOTAL_LCY_AMOUNT>
            <TOTAL_USD_AMOUNT>{if ($lcyAmmount = '0') then '0.00' else fn-bea:format-number(number($lcyAmmount),"##0.00")}</TOTAL_USD_AMOUNT>
            <CARDS>
                <CARD_DETAILS>
                    <CARD_NUMBER>{ 
                      fn-bea:trim(fn:replace(fn:string(functx:replace-first(data($lcymovements/OutstandingAuthArray/OutstandingAuthData[1]/OFXOAO-CARD-NBR), '0', '-')),"-", " "))
                     }</CARD_NUMBER>
                    <LCY_AMOUNT>0.00</LCY_AMOUNT>
                    <USD_AMOUNT>{if ($lcyAmmount = '0') then '0.00' else fn-bea:format-number(number($lcyAmmount),"##0.00")}</USD_AMOUNT> 
                    <MOVEMENTS>
                        {
                            for $OutstandingAuthData in $lcymovements/OutstandingAuthArray/OutstandingAuthData
                            return
                                <FLOATING_MOVEMENT>
                                    <MCC_CODE>{ data($OutstandingAuthData/OFXOAO-MERCH-CAT-CD) }</MCC_CODE>
                                    <MCC_DESCRIPTION>{ data($OutstandingAuthData/OFXOAO-CRD-ACCPT-NAME-LOC) }</MCC_DESCRIPTION>
                                    <DESCRIPTION>{ data($OutstandingAuthData/OFXOAO-TRANSACTION-DESC) }</DESCRIPTION>
                                    <DATE>{ data($OutstandingAuthData/OFXOAO-EFF-DATE) }</DATE>
                                    <TIME>{ data($OutstandingAuthData/OFXOAO-TIME) }</TIME>
                                    <AMOUNT>{ data($OutstandingAuthData/OFXOAO-AUTH-AMOUNT) }</AMOUNT>
                                    <CURRENCY>USD</CURRENCY>
                                    <FEE>00</FEE>
                                    <PAYMENT_METHOD>0000</PAYMENT_METHOD>
                                </FLOATING_MOVEMENT>
                        }
                    </MOVEMENTS>
                </CARD_DETAILS>
            </CARDS>
        </ns0:consultaMovimientosFlotantesTCResponse>
};

declare variable $outstandingAuthorizationInquiryResponse as element(ns1:OutstandingAuthorizationInquiryResponse) external;
declare variable $cardHolderName as xs:string external;
declare variable $lcyAmmount as xs:string external;
declare variable $lcymovements as element(*) external;
declare variable $carNumberRequest as xs:string external;

xf:consultaMovimientosFlotantesTCOut($outstandingAuthorizationInquiryResponse,
    $cardHolderName,
    $lcyAmmount,
    $lcymovements,
    $carNumberRequest)