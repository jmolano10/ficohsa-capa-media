(:: pragma bea:global-element-return element="ns0:Pagoderecaudoreferenciadodbcta" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoReferenciadoTCIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:pagoRecaudoReferenciadoTCIn(
    $usernameChannel as xs:string,
    $passwordChannel as xs:string,
    $contractID as xs:string,
    $debtorCode as xs:string,
    $debtorName as xs:string,
    $currency as xs:string,
    $amount as xs:string,
    $creditCard as xs:string,
    $expirationDate as xs:string,
    $billNumber as xs:string,
    $billDue as xs:string,
    $uuid as xs:string,
    $debitAccount as xs:string)
    as element(ns0:Pagoderecaudoreferenciadodbcta) {
        <ns0:Pagoderecaudoreferenciadodbcta>
                        <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($usernameChannel)), 
												data($usernameChannel)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($usernameChannel)),
                								data($passwordChannel)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                <DEBITACCTNO>{ $debitAccount }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($currency) }</DEBITCURRENCY>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ data($debtorCode) }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>                
                <LRPAYCODE>{ data($debtorCode) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($billNumber) }</LRINVOICENO>
                        <LRDUEDATE>{ data($billDue) }</LRDUEDATE>
                        <LRAMT>{ concat($currency , $amount) }</LRAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>{ data( $debtorName) }</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($contractID) }</LRAGCLIENTID>
                <LRCCARDNO>{ data($creditCard) }</LRCCARDNO>
                <LREXPIRYDATE>{ data($expirationDate) }</LREXPIRYDATE>
                                <gORDERINGBANK g="1">
					<ORDERINGBANK>999999</ORDERINGBANK>
				</gORDERINGBANK>
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
        </ns0:Pagoderecaudoreferenciadodbcta>
};


declare variable $usernameChannel as xs:string external;
declare variable $passwordChannel as xs:string external;
declare variable $contractID as xs:string external;
declare variable $debtorCode as xs:string external;
declare variable $debtorName as xs:string external;
declare variable $currency as xs:string external;
declare variable $amount as xs:string external;
declare variable $creditCard as xs:string external;
declare variable $expirationDate as xs:string external;
declare variable $billNumber as xs:string external;
declare variable $billDue as xs:string external;
declare variable $uuid as xs:string external;
declare variable $debitAccount as xs:string external;

xf:pagoRecaudoReferenciadoTCIn(
   $usernameChannel, 
   $passwordChannel,
   $contractID,
   $debtorCode,
   $debtorName,
   $currency,
   $amount,
   $creditCard,
   $expirationDate,
   $billNumber,
   $billDue,
   $uuid,
   $debitAccount)