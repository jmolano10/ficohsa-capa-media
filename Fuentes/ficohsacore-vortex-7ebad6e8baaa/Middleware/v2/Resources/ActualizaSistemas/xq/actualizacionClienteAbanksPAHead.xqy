xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../BusinessServices/ABKPA/actualizaClientes/wsdl/abandef_08032021.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionClienteAbanksPAHead/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.ficohsa.com/";

declare function getUsername ($username as xs:string)  as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($username)))
		return
			$data/con:username/text()
};
declare function getPassword ($username as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($username)))
  		return
		   $data/con:password/text()
};


declare function xf:actualizacionClienteAbanksPAHead($requestHeader1 as element(ns0:RequestHeader))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <Username>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
                 </Username>
                <Password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
               </Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($requestHeader1/Region/SourceBank) }</SourceBank>
                <DestinationBank>{ data($requestHeader1/Region/DestinationBank) }</DestinationBank>
            </Region>
        </ns1:RequestHeader>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;

xf:actualizacionClienteAbanksPAHead($requestHeader1)