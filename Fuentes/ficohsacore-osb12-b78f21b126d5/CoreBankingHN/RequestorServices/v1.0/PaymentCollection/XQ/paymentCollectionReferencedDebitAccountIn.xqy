xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollection/XMLSchema_-263071553.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($username as xs:string, 
                            $password as xs:string, 
                            $uuid as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) 
                            as element() (:: schema-element(ns2:Pagoderecaudoreferenciadodbcta) ::) {
    <ns2:Pagoderecaudoreferenciadodbcta>
          <WebRequestCommon>
                <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
                <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                <DEBITACCTNO>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:DebitAccount) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency) }</DEBITCURRENCY>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ data($paymentCollectionRequest/ns1:DebtorCode) }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
                <LRPAYCODE>{ data($paymentCollectionRequest/ns1:DebtorCode) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($paymentCollectionRequest/ns1:BillInformation/ns1:BillNumber) }</LRINVOICENO>
                        <LRDUEDATE>{ data($paymentCollectionRequest/ns1:BillInformation/ns1:DueDate) }</LRDUEDATE>
                        <LRAMT>{ concat($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency , $paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount) }</LRAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>{ data($paymentCollectionRequest/ns1:DebtorName) }</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($paymentCollectionRequest/ns1:ContractId) }</LRAGCLIENTID>
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>  
    </ns2:Pagoderecaudoreferenciadodbcta>
};

local:func($username, $password, $uuid, $paymentCollectionRequest)