(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanks1" element="ns1:pagoRecaudoAbanks" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagorecaudoreferenciadochqotrbco" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksRefOBChqIn/";

declare function xf:pagoRecaudoAbanksRefOBChqIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks),
    $uuid as xs:string)
    as element(ns0:Pagorecaudoreferenciadochqotrbco) {
        <ns0:Pagorecaudoreferenciadochqotrbco>
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
            <TELLERLATAMREFOBCHQRESWSCOPYType>
                <CURRENCY1>{ data($pagoRecaudoAbanks1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</CURRENCY1>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        {
                            for $CHEQUE_NUMBER in $pagoRecaudoAbanks1/PAYMENT_INFORMATION/CHEQUE_NUMBER
                            return
                                <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                        }
                        {
                            for $BANK_CODE in $pagoRecaudoAbanks1/PAYMENT_INFORMATION/BANK_CODE
                            return
                                <CHEQUEBANKCDE>{ data($BANK_CODE) }</CHEQUEBANKCDE>
                        }
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
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
            </TELLERLATAMREFOBCHQRESWSCOPYType>
        </ns0:Pagorecaudoreferenciadochqotrbco>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks) external;
declare variable $uuid as xs:string external;

xf:pagoRecaudoAbanksRefOBChqIn($autenticacionRequestHeader1,
    $pagoRecaudoAbanks1,
    $uuid)