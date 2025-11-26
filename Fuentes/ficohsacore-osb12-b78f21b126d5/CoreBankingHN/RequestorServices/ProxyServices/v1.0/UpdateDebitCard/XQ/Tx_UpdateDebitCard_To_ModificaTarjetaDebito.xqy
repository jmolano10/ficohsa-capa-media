xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerDebitCards/XMLSchema_-155258746.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $updateDebitCard as element() (:: schema-element(ns2:updateDebitCardRequest) ::) external;
declare variable $userName as xs:string external;
declare variable $secondaryAccount as xs:string external;
declare variable $productType as xs:string external;
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


declare function xq:Tx_UpdateDebitCard_To_ModificaTarjetaDebito($updateDebitCard as element() (:: schema-element(ns2:updateDebitCardRequest) ::), 
                                                                $userName as xs:string,$secondaryAccount as xs:string,$productType as xs:string) 
                                                                as element() (:: schema-element(ns1:ModificacionTarjetaDebito) ::) {
    <ns1:ModificacionTarjetaDebito>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($userName)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <noOfAuth>0</noOfAuth>
        </OfsFunction>
        <LATAMCARDORDERMODIFICATIONWSType id ="{fn:concat($productType,".",fn:data($updateDebitCard/ns2:cardNumber))}">
            <gACCTCCY>
                <mACCTCCY>
                    <sgSCNDRYACCT>
                      {
                      (:Este segmento permite identificar si existen cuentas secundarias, evitando que la sobre escriba en T24:)
                       if (fn:string($secondaryAccount)!='') 
                       then (
                       let $ORG_SECOND_ACCT := fn:tokenize(fn:string($secondaryAccount),"!!")
                       for $i in 1 to fn:count($ORG_SECOND_ACCT)
                       return                       
                        <SecondaryAccount>{ xs:string($ORG_SECOND_ACCT[$i]) } </SecondaryAccount>
                        ) else ()
                       } 
                       {
                      (:Este segmento incorpora o adiciona las nuevas cuentas secundarias:)
                      let $NEW_SECOND_ACCT := $updateDebitCard/ns2:SecondaryAccounts
                      for $n in 1 to fn:count($NEW_SECOND_ACCT)
                      return
                       <SecondaryAccount>{ xs:string($NEW_SECOND_ACCT[$n]) } </SecondaryAccount>
                            }                              
                    </sgSCNDRYACCT>
                </mACCTCCY>
            </gACCTCCY>
        </LATAMCARDORDERMODIFICATIONWSType>
    </ns1:ModificacionTarjetaDebito>
};

xq:Tx_UpdateDebitCard_To_ModificaTarjetaDebito($updateDebitCard, $userName,$secondaryAccount,$productType)
