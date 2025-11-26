xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/UpdateDebitCardStatus/UpdateDebitCardStatus.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/updateDebitCardStatusIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $processType as xs:string external;
declare variable $updateDebitCardStatusRequest as element() (:: schema-element(ns2:updateDebitCardStatusRequest) ::) external;

declare function ns1:updateDebitCardStatusIn($username as xs:string, 
                                             $password as xs:string, 
                                             $processType as xs:string, 
                                             $updateDebitCardStatusRequest as element() (:: schema-element(ns2:updateDebitCardStatusRequest) ::)) 
                                             as element() (:: schema-element(ns3:AperturaCuentasCliente) ::) {
    <ns3:AperturaCuentasCliente>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction/>
        <FICOBULKAPPRCLNTINPUTPRODUCTWSType>
            <PROCESSTYPE>{fn:data($processType)}</PROCESSTYPE>
            {
                if ($updateDebitCardStatusRequest/ns2:CustomerId)
                then <CUSTOMER>{fn:data($updateDebitCardStatusRequest/ns2:CustomerId)}</CUSTOMER>
                else ()
            }
            {
                if ($updateDebitCardStatusRequest/ns2:cardNumber)
                then <TDCODID>{fn:data($updateDebitCardStatusRequest/ns2:cardNumber)}</TDCODID>
                else ()
            }
            <TOAGENCY/>
            <LRREEMISIONTD/>
            <gFIELDS81 	g="1"/>
            <gFIELDS86 	g="0"/>
            <gFIELDS87 	g="0"/>
            <gFIELDS88 	g="0"/>
            <gFIELDS89 	g="0"/>
            <gFIELDS90/>
            <gFIELDS91 	g="0"/>
            {
                if ($updateDebitCardStatusRequest/ns2:InterfaceUser)
                then <USERID>{fn:data($updateDebitCardStatusRequest/ns2:InterfaceUser)}</USERID>
                else ()
            }
        </FICOBULKAPPRCLNTINPUTPRODUCTWSType>
    </ns3:AperturaCuentasCliente>
};

ns1:updateDebitCardStatusIn($username, $password, $processType, $updateDebitCardStatusRequest)
