(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetallePD/consultaDetallePDConsultaCuentaIn/";

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

declare function xf:consultaDetallePDConsultaCuentaIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $string1 as xs:string)
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/UserName))
                    }
</userName>
                <password>{
                        fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/Password))
                    }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $string1 }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $string1 as xs:string external;

xf:consultaDetallePDConsultaCuentaIn($autenticacionRequestHeader1,
    $string1)