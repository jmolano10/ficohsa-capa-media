xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/DisbursmentLoanCreditAccount/XMLSchema_-2126816862.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare variable $transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::) external;
declare variable $user as xs:string external;
declare variable $password as xs:string external;

declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::), 
                            $user as xs:string, 
                            $password as xs:string) 
                            as element() (:: schema-element(ns2:Desembolsoporcreditoacuenta) ::) {
    <ns2:Desembolsoporcreditoacuenta> 
     <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( local:getUsername(data($user)),
                        data($user))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( local:getPassword(data($user)),
                        data($password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERFICOHNDESEMBOLSOCTAHNL2Type>
                <DebitAmount>{ $transfersLocalAccountRequest/ns1:TransferAmmount/text() }</DebitAmount>
                <CreditAccount>{ $transfersLocalAccountRequest/ns1:CreditAccount/text() }</CreditAccount>
                <gPAYMENTDETAILS>
                {
                    if($transfersLocalAccountRequest/ns1:Description)then(
                    <PaymentDetails>{ data($transfersLocalAccountRequest/ns1:Description) }</PaymentDetails>
                    )else()
                }
                </gPAYMENTDETAILS>
                <LRLOANNO>{ data($transfersLocalAccountRequest/ns1:AdditionalInfo/*:KV_PAIR[*:Key='LOAN_NUMBER']/*:Value) }</LRLOANNO>
            </FUNDSTRANSFERFICOHNDESEMBOLSOCTAHNL2Type>
    </ns2:Desembolsoporcreditoacuenta>
};

local:func($transfersLocalAccountRequest, $user, $password)
