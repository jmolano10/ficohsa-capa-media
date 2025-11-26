xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns2:transaccionSubasta" location="../../../../Business_Resources/subasta/transaccionSubasta/transaccionSubastaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:EmisiondechequedegerenciaFCY" location="../../../../Business_Resources/emisionChequesGerencia/Resources/XMLSchema_-1805424041.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionSubasta/xq/emisionChequeGerenciaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace ns1 = "T24WebServicesImpl";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
 
declare function xf:emisionChequeGerenciaIn($requestHeader as element(ns0:RequestHeader),
    $transaccionSubasta as element(ns2:transaccionSubasta),
    $uuid as xs:string)
    as element(ns1:EmisiondechequedegerenciaFCY) {
        <ns1:EmisiondechequedegerenciaFCY>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
				<noOfAuth/>
				<replace/>
            </OfsFunction>
            <FUNDSTRANSFEROD110FCYDRAFTIBWSType>
                <DebitAccount>{ data($transaccionSubasta/DEBIT_ACCOUNT) }</DebitAccount>
                <DraftCurrency>USD</DraftCurrency>
                <DraftAmount>{ data($transaccionSubasta/TRANSACTION_AMOUNT) }</DraftAmount>
                <gBENCUSTOMER>
                    {
                        for $BENEFICIARY_NAME in $transaccionSubasta/CASHIERS_CHEQUE/BENEFICIARY_NAME
                        return
                            <Beneficiary>{ data($BENEFICIARY_NAME) }</Beneficiary>
                    }
                </gBENCUSTOMER>
                <gPAYMENTDETAILS>
                    {
                        for $DESCRIPTION in $transaccionSubasta/CASHIERS_CHEQUE/DESCRIPTION
                        return
                            <PaymentDetails>{ data($DESCRIPTION) }</PaymentDetails>
                    }
                </gPAYMENTDETAILS>
                <LRFICOAUCTION>YES</LRFICOAUCTION>
                {
                	let $AUCTION_RATE_TYPE := fn:string($transaccionSubasta/AUCTION_RATE_TYPE/text())
                	return
                		if ($AUCTION_RATE_TYPE = ("MAX","MIN","AVG")) then (
                			<LRRATEOPTION>{ $AUCTION_RATE_TYPE }</LRRATEOPTION>
                		) else if($AUCTION_RATE_TYPE = "") then (
                			<LRRATEOPTION>AVG</LRRATEOPTION>
                		) else if($AUCTION_RATE_TYPE = "MAN") then (
                			<LRRATEOPTION>{ $AUCTION_RATE_TYPE }</LRRATEOPTION>,
                			<LRAUCRATE>{ data($transaccionSubasta/SUGGESTED_RATE) }</LRAUCRATE>		
                		) else ()
                }
                {
                    for $WITHDRAWAL_BRANCH_ID in $transaccionSubasta/CASHIERS_CHEQUE/WITHDRAWAL_BRANCH_ID
                    return
                        <ISSUEAGENCY>{ data($WITHDRAWAL_BRANCH_ID) }</ISSUEAGENCY>
                }
            </FUNDSTRANSFEROD110FCYDRAFTIBWSType>
        </ns1:EmisiondechequedegerenciaFCY>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transaccionSubasta as element(ns2:transaccionSubasta) external;
declare variable $uuid as xs:string external;

xf:emisionChequeGerenciaIn($requestHeader,
    $transaccionSubasta,
    $uuid)