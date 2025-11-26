(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizaDatosClienteRequest1" element="ns0:actualizaDatosClienteRequest" location="../xsd/actualizaDatosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Actualizardatosdecliente" location="../../../BusinessServices/actualizaDatosCliente/xsd/XMLSchema_1014999265.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes/v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/ActualizaDatosClienteIn/";

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

declare function xf:ActualizaDatosClienteIn($requestHeader1 as element(ns2:RequestHeader),
    $actualizaDatosClienteRequest1 as element(ns0:actualizaDatosClienteRequest),
    $string1 as xs:string)
    as element(ns1:Actualizardatosdecliente) {
        <ns1:Actualizardatosdecliente>
            <WebRequestCommon>
                <userName>{
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    	} </userName>
                <password>{
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    	}</password>
            </WebRequestCommon>
            <OfsFunction>
            	<noOfAuth></noOfAuth>
         	</OfsFunction>            
            <CUSTOMERPROFILEUPDATEWSType id = "{ data($actualizaDatosClienteRequest1/CUSTOMER_ID) }">
                <gEMAIL1 g="1">
                    <EMAIL1>{ fn:string($actualizaDatosClienteRequest1/PRIMARY_EMAIL/text()) }</EMAIL1>
                    {
                    	if ($string1 != "") then (
	                    	let $LISTA_CORREOS := fn:tokenize($string1,"\|\|")
	                        for $CUSTOMER in $LISTA_CORREOS
	                        return
	                        	if ($CUSTOMER != fn:string($actualizaDatosClienteRequest1/PRIMARY_EMAIL/text())) then (
	                    			<EMAIL1>{ $CUSTOMER }</EMAIL1>
	                    		)
	                    		else ()
	                    ) else ()
                    }                    
                </gEMAIL1>
            </CUSTOMERPROFILEUPDATEWSType>
        </ns1:Actualizardatosdecliente>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $actualizaDatosClienteRequest1 as element(ns0:actualizaDatosClienteRequest) external;
declare variable $string1 as xs:string external;

xf:ActualizaDatosClienteIn($requestHeader1,
    $actualizaDatosClienteRequest1,
    $string1)