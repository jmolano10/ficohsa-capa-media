xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CreaProductosCliente/v1.0/XMLSchema_379817454.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $assignDebitCard as element() (:: schema-element(ns1:assignDebitCardRequest) ::) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

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



declare function xq:Tx_AssignDebitCard_To_T24($assignDebitCard as element() (:: schema-element(ns1:assignDebitCardRequest) ::), 
                                              $userName as xs:string, 
                                              $password as xs:string) 
                                              as element() (:: schema-element(ns2:CreaciondeCuentasparaDigital) ::) {
    <ns2:CreaciondeCuentasparaDigital>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction></OfsFunction>
        <FICOBULKAPPRCLNTINPUTPRODUCTDYNWSType>
            <PROCESSTYPE>7</PROCESSTYPE>
            <CUSTOMER>{fn:data($assignDebitCard/ns1:CustomerCode)}</CUSTOMER>
            {
                if ($assignDebitCard/ns1:CardNumber)
                then <TDCODID>{fn:data($assignDebitCard/ns1:CardNumber)}</TDCODID>
                else ()
            }
            <PRIMARYACCT>{fn:data($assignDebitCard/ns1:PrimaryAccount)}</PRIMARYACCT>
            <TOAGENCY>{fn:data($assignDebitCard/ns1:DeliveryBranch)}</TOAGENCY>
            <LRREEMISIONTD>{fn:data($assignDebitCard/ns1:EmissionPay)}</LRREEMISIONTD>
            <EMBOSSEDTYPE>{fn:data($assignDebitCard/ns1:EmbossedType)}</EMBOSSEDTYPE>
            {
                if ($assignDebitCard/ns1:CardType)
                then <CARDTYPE>{fn:data($assignDebitCard/ns1:CardType)}</CARDTYPE>
                else ()
            }
            <gFIELDS81 	g="1"/>
            <gFIELDS86 	g="0"/>
            <gFIELDS87 	g="0"/>
            <gFIELDS88 	g="0"/>
            <gFIELDS89 	g="0"/>
            <gFIELDS90/>
            <gFIELDS91 	g="0"/>            
            <USERID>{fn:data($assignDebitCard/ns1:InterfaceUser)}</USERID>
        </FICOBULKAPPRCLNTINPUTPRODUCTDYNWSType>
    </ns2:CreaciondeCuentasparaDigital>
};

xq:Tx_AssignDebitCard_To_T24($assignDebitCard, $userName, $password)