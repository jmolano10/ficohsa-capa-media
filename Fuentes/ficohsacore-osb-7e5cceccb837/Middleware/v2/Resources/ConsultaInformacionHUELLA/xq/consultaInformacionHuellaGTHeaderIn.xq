(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../BusinessServices/OIC/consultaInformacionHUELLA/xsd/XMLSchema_576690550.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionHUELLA/xq/consultaInformacionHuellaGTHeaderIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

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

declare function xf:consultaInformacionHuellaGTHeaderIn($serviceAccountName as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>
                	{ 
                		fn-bea:fail-over( getUsername(data($serviceAccountName)),
	                    	data($serviceAccountName))
                	}
                </UserName>
                <Password>
                	{ 
                		fn-bea:fail-over( getPassword(data($serviceAccountName)),
	                    	data($serviceAccountName))
                	}
                </Password>
            </Authentication>
        </ns0:RequestHeader>
};

declare variable $serviceAccountName as xs:string external;

xf:consultaInformacionHuellaGTHeaderIn($serviceAccountName)