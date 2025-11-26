(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMultipleMontoTSP" element="ns0:consultaMultipleMontoTSP" location="../../OperacionesTSP/xsd/operacionesTSPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadeMontoTSP" location="../../../BusinessServices/T24/svcOperacionesTSP/xsd/XMLSchema_-163607763.xsd" ::)
(:: pragma  parameter="$anyType" type="xs:anyType" ::)
(:: pragma  type="xs:anyType" ::)


declare namespace functx = "http://www.functx.com";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2= "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTSPTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleMontoTSP/xq/consultadeMontoTSPIn/";

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
 
declare function trama($anyType as element(*), $user as xs:string) as element(*){

                           for $transactions in $anyType/TRANSACTIONS
		                         return
                               <a>
		    						{ 
		    							for $transaction in $transactions/TRANSACTION
		    							return 
		    			 						concat($transaction/ID,"!!",$transaction/REFERENCE,"!!",$transaction/TYPE_CODE,"!!",fn-bea:if-then-else(empty($transaction/CUSTOMER_ID),"-",$transaction/CUSTOMER_ID),"!!",$transaction/ACCOUNT_NUMBER,"!!",$transaction/AMOUNT,"!!",fn-bea:if-then-else(empty($transaction/CURRENCY),"-",$transaction/CURRENCY),"!!",$transaction/DATE,"!!",fn-bea:if-then-else(empty($transaction/DESTINATION_CUSTOMER_ID),"-",$transaction/DESTINATION_CUSTOMER_ID),"!!",$transaction/DESTINATION_ACCOUNT_NUMBER,"!!",fn-bea:if-then-else(empty($transaction/DESTINATION_CURRENCY),"-",$transaction/DESTINATION_CURRENCY),"!!", $user,"!!",fn-bea:if-then-else(empty($transaction/AGREEMENT_ID),"-",$transaction/AGREEMENT_ID),"||")
		    						}
		    				</a>
					          
                   };

declare function xf:consultadeMontoTSPIn($requestHeader as element(ns2:RequestHeader),$consultaMultipleMontoTSP as element(ns0:consultaMultipleMontoTSP))
    as element(ns1:ConsultadeMontoTSP) {
        <ns1:ConsultadeMontoTSP>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <FICOTSPCONSULTAMONTOWSType>
                <enquiryInputCollection>
                    <columnName>STRING.TRANSACTION</columnName>
                    <criteriaValue>
                        {  
                               let $message := replace(trama($consultaMultipleMontoTSP,data($requestHeader/Authentication/UserName))," ","")
                               return
                            	fn:substring( $message,1,fn:string-length($message)-2) 
                        }
                    </criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOTSPCONSULTAMONTOWSType>
        </ns1:ConsultadeMontoTSP>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaMultipleMontoTSP as element(ns0:consultaMultipleMontoTSP) external;
declare variable $anyType as element(*) external;

xf:consultadeMontoTSPIn($requestHeader,$consultaMultipleMontoTSP)
