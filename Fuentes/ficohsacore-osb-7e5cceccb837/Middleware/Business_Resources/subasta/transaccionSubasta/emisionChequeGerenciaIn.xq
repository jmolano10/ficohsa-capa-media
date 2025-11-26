(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns1:transaccionSubasta" location="transaccionSubastaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EmisiondechequedegerenciaFCY" location="../../emisionChequesGerencia/Resources/XMLSchema_-1805424041.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciaInternacional/emisionChequeGerenciaIn/";

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

declare function xf:emisionChequeGerenciaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $transaccionSubasta as element(ns1:transaccionSubasta),
    $uuid as xs:string)
    as element(ns0:EmisiondechequedegerenciaFCY) {
        <ns0:EmisiondechequedegerenciaFCY>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
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
        </ns0:EmisiondechequedegerenciaFCY>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $transaccionSubasta as element(ns1:transaccionSubasta) external;
declare variable $uuid as xs:string external;

xf:emisionChequeGerenciaIn($autenticacionRequestHeader,
    $transaccionSubasta,
    $uuid)