(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanks1" element="ns1:pagoRecaudoAbanks" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudoreferenciadodbcta" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksRefDbCtaIn/";

declare function xf:pagoRecaudoAbanksRefDbCtaIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks),
    $uuid as xs:string)
    as element(ns0:Pagoderecaudoreferenciadodbcta) {
        <ns0:Pagoderecaudoreferenciadodbcta>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader1/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader1/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<gtsControl></gtsControl>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>1</noOfAuth>
				<replace></replace>  
            </OfsFunction>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                {
                    for $DEBIT_ACCOUNT in $pagoRecaudoAbanks1/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                    return
                        <DEBITACCTNO>{ data($DEBIT_ACCOUNT) }</DEBITACCTNO>
                }
                <DEBITCURRENCY>{ data($pagoRecaudoAbanks1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</DEBITCURRENCY>
                <LRPAYCODE>{ data($pagoRecaudoAbanks1/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>
                        {
                            if (data($pagoRecaudoAbanks1/BILL_NUMBER) != "") then
                                (data($pagoRecaudoAbanks1/BILL_NUMBER))
                            else 
                                data($pagoRecaudoAbanks1/DEBTOR_CODE)
                        }
						</LRINVOICENO>
                        <LRDUEDATE>20140708</LRDUEDATE>
                        <LRAMT>{ concat(data($pagoRecaudoAbanks1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) , $pagoRecaudoAbanks1/AMOUNT) }</LRAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>{ data($pagoRecaudoAbanks1/DEBTOR_CODE) }</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($pagoRecaudoAbanks1/CONTRACT_ID) }</LRAGCLIENTID>
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
        </ns0:Pagoderecaudoreferenciadodbcta>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks) external;
declare variable $uuid as xs:string external;

xf:pagoRecaudoAbanksRefDbCtaIn($autenticacionRequestHeader1,
    $pagoRecaudoAbanks1,
    $uuid)