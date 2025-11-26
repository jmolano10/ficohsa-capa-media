(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../BusinessServices/ABKGT/actualizaClientes/wsdl/abandef_08032021.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.ficohsa.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionClienteAbanksHead/";

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

declare function xf:actualizacionClienteAbanksHead($requestHeader as element(ns0:RequestHeader))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <Username>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
                 </Username>
                <Password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
               </Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($requestHeader/Region/SourceBank) }</SourceBank>
                <DestinationBank>{ data($requestHeader/Region/DestinationBank) }</DestinationBank>
            </Region>
        </ns1:RequestHeader>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:actualizacionClienteAbanksHead($requestHeader)