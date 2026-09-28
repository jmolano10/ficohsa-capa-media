(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$compraPaquete" element="ns0:compraPaquete" location="../xsd/compraPaqueteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:PagoDePaquetesMovilesFT" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraPaqueteTypes";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/pagoPaquetesMovilesIng/";
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

declare function xf:pagoPaquetesMovilesIng($requestHeader as element(ns1:RequestHeader),
    $compraPaquete as element(ns0:compraPaquete),
    $contractId as xs:string)
    as element(ns2:PagoDePaquetesMovilesFT) {
        <ns2:PagoDePaquetesMovilesFT>
        	<WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentitacion/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
			</password>
            </WebRequestCommon>
             <OfsFunction>
            	<gtsControl></gtsControl>
	            <messageId></messageId>
                <noOfAuth></noOfAuth>
                <replace></replace>
    	     </OfsFunction>
            <FUNDSTRANSFERFICOMOBILEPACKAGEPAYWSType>
                <DEBITACCTNO>{ data($compraPaquete/DEBIT_ACCOUNT) }</DEBITACCTNO>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ data($compraPaquete/PHONE_NUMBER) }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
                <LRAGCLIENTID>{ $contractId }</LRAGCLIENTID>
                <LROPERCODE>{ data($compraPaquete/PACK_CODE) }</LROPERCODE>
            </FUNDSTRANSFERFICOMOBILEPACKAGEPAYWSType>
        </ns2:PagoDePaquetesMovilesFT>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $compraPaquete as element(ns0:compraPaquete) external;
declare variable $contractId as xs:string external;

xf:pagoPaquetesMovilesIng($requestHeader,
    $compraPaquete,
    $contractId)