(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSobregiroCuenta1" element="ns1:consultaSobregiroCuenta" location="../xsd/consultaSobregiroCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetsobregiroufranticipo" location="../../../../Business_Resources/consultaDetallePD/Resources/XMLSchema_865025152.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSobregiroCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSobregiroCuenta/xq/consultaSobregiroCuentaIn/";

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

declare function xf:consultaSobregiroCuentaIn($requestHeader1 as element(ns2:RequestHeader),
    $t24Account as xs:string)
    as element(ns0:Consultadetsobregiroufranticipo) {
        <ns0:Consultadetsobregiroufranticipo>
            <WebRequestCommon>
                <userName>{
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }</userName>
                <password>{
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }</password>
            </WebRequestCommon>
            <FICOEPDCATEGLISTWSType>
                <enquiryInputCollection>
                	<columnName>ORIG.STLMNT.ACT</columnName>
                    <criteriaValue>{ $t24Account }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOEPDCATEGLISTWSType>
        </ns0:Consultadetsobregiroufranticipo>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $t24Account as xs:string external;

xf:consultaSobregiroCuentaIn($requestHeader1,
    $t24Account)