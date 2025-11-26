(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetsobregiroufranticipo" location="Resources/XMLSchema_865025152.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetallePD/consultaDetallePDIn/";

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

declare function xf:consultaDetallePDIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $string1 as xs:string)
    as element(ns0:Consultadetsobregiroufranticipo) {
        <ns0:Consultadetsobregiroufranticipo>
            <WebRequestCommon>
                <userName>{
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/UserName))
                    }</userName>
                <password>{
                        fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/Password))
                    }</password>
            </WebRequestCommon>
            <FICOEPDCATEGLISTWSType>
                <enquiryInputCollection>
                	<columnName>ORIG.STLMNT.ACT</columnName>
                    <criteriaValue>{ $string1 }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOEPDCATEGLISTWSType>
        </ns0:Consultadetsobregiroufranticipo>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $string1 as xs:string external;

xf:consultaDetallePDIn($autenticacionRequestHeader1,
    $string1)