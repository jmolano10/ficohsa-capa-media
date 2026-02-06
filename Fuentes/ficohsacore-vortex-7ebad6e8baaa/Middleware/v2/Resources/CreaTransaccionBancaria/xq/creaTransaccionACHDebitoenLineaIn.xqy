xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creaTransaccionBancaria1" element="ns1:creaTransaccionBancaria" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:TransferenciaACHDebitoenLinea" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionACHDebitoenLineaIn/";

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
 
declare function getReferenceNumber($REFERENCE_NUMBER as xs:string,$uuid as xs:string) as xs:string {
	if ($REFERENCE_NUMBER = "") then (
			$uuid
		)
	else (
			$REFERENCE_NUMBER
		)
};

declare function xf:creaTransaccionACHDebitoenLineaIn($requestHeader1 as element(ns2:RequestHeader),
    $creaTransaccionBancaria1 as element(ns1:creaTransaccionBancaria),
    $uuid as xs:string)
    as element(ns0:TransferenciaACHDebitoenLinea) {
        <ns0:TransferenciaACHDebitoenLinea>
            <WebRequestCommon>
                <userName>
                {
                    fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                    data($requestHeader1/Authentication/UserName))
                }
                </userName>
                <password>
                {
                    fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                    data($requestHeader1/Authentication/Password))
                }
                </password>   
            </WebRequestCommon>
            <OfsFunction>
                 <messageId>
                {
                	getReferenceNumber(fn:string($creaTransaccionBancaria1/ORIGINATOR_INFO/REFERENCE_NUMBER/text()),$uuid)  
                }
                </messageId>
            </OfsFunction>
            <FUNDSTRANSFERRETAILDEBITACHWSType>
            
                <DebitAccount>{ data($creaTransaccionBancaria1/DEBIT_ACCOUNT) }</DebitAccount>
                <DebitCurrency>{ data($creaTransaccionBancaria1/CURRENCY) }</DebitCurrency>
                <DebitAmount>{ data($creaTransaccionBancaria1/TRANSFER_AMOUNT) }</DebitAmount>
                <LRFICOACHPXD>
                {
                	getReferenceNumber(fn:string($creaTransaccionBancaria1/ORIGINATOR_INFO/REFERENCE_NUMBER/text()),$uuid)
                }
                </LRFICOACHPXD>                
                <LRCONTRACTACH>{ data($creaTransaccionBancaria1/CONTRACT_ID) }</LRCONTRACTACH>
            </FUNDSTRANSFERRETAILDEBITACHWSType>
        </ns0:TransferenciaACHDebitoenLinea>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $creaTransaccionBancaria1 as element(ns1:creaTransaccionBancaria) external;
declare variable $uuid as xs:string external;

xf:creaTransaccionACHDebitoenLineaIn($requestHeader1,
    $creaTransaccionBancaria1,
    $uuid)