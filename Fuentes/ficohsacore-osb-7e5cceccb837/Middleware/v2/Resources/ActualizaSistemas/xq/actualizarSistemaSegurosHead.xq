(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../BusinessServices/ACSELX/ActualizarSistema/wsdl/WsDataBanco.asmx.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizarSistemaSegurosHead/";

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

declare function xf:actualizarSistemaSegurosHead($requestHeader1 as element(ns0:RequestHeader))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <ns1:Authentication>
                <ns1:UserName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
                </ns1:UserName>
                <ns1:Password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
                </ns1:Password>
            </ns1:Authentication>
            <ns1:Region>
                <ns1:SourceBank>{ data($requestHeader1/Region/SourceBank) }</ns1:SourceBank>
                <ns1:DestinationBank>{ data($requestHeader1/Region/DestinationBank) }</ns1:DestinationBank>
            </ns1:Region>
        </ns1:RequestHeader>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;

xf:actualizarSistemaSegurosHead($requestHeader1)