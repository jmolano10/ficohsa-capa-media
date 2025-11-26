xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/TransferLoanDisbursement/svcDesembolsoPrestamoCredCtaTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare namespace key = "http://www.ficohsa.com.hn/middleware.services/keyValueTypes";
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $transfersAccount as element() (:: schema-element(ns1:transfersAccountRequest) ::) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

(: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
declare function xq:splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), xq:splitString(substring($String,$length+1),$length)) 
  else $String
};


(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };


declare function xq:Tx_TransfersAccount_To_T24($transfersAccount as element() (:: schema-element(ns1:transfersAccountRequest) ::),$userName as xs:string,$password as xs:string) as element() (:: schema-element(ns2:Desembolsoporcreditoacuenta) ::) {
    <ns2:Desembolsoporcreditoacuenta>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <gtsControl></gtsControl>
            <messageId></messageId>
            <noOfAuth>0</noOfAuth>
            <replace></replace>
        </OfsFunction>
        <FUNDSTRANSFERFICOHNDESEMBOLSOCTAHNL2Type>
            <DebitAmount>{fn:data($transfersAccount/ns1:TransferAmount)}</DebitAmount>
            {
                if ($transfersAccount/ns1:CreditAccount)
                then <CreditAccount>{fn:data($transfersAccount/ns1:CreditAccount)}</CreditAccount>
                else ()
            }
            <gPAYMENTDETAILS g="1">
            {
                		for $value in xq:splitString(data($transfersAccount/ns1:Description),34)
                		return
                			if(fn:string($value) != "") then (
                				<PaymentDetails>{concat($value, ".")}</PaymentDetails>
                			) else ()
            }    
            </gPAYMENTDETAILS>
            <ChargeCode></ChargeCode>
            <gCHARGETYPE>
                <mCHARGETYPE>
                    <ChargeType></ChargeType>
                    <ChargeAmount></ChargeAmount>
                </mCHARGETYPE>
            </gCHARGETYPE>
            <AmountDebited></AmountDebited>
            <AmountCredited></AmountCredited>
            <LRLOANNO>{fn:data($transfersAccount/ns1:AdditionalInfo[key:Key='LoanNumber']/key:Value)}</LRLOANNO>
            <LRGLOBALID>{fn:data($transfersAccount/ns1:GeneralInfo/com:GlobalId)}</LRGLOBALID>
        </FUNDSTRANSFERFICOHNDESEMBOLSOCTAHNL2Type>
    </ns2:Desembolsoporcreditoacuenta>
};

xq:Tx_TransfersAccount_To_T24($transfersAccount,$userName,$password)