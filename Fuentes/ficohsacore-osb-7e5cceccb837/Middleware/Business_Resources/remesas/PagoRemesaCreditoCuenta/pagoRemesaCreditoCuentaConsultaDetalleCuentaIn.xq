(:: pragma bea:global-element-parameter parameter="$validacionCuentaResponse" element="ns3:validacionCuentaResponse" location="../../validacionCuenta/ValidacionCuenta/validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta" element="ns1:pagoRemesaCreditoCuenta" location="pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaConsultaDetalleCuentaIn/";

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

declare function xf:pagoRemesaCreditoCuentaConsultaDetalleCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)),
                        data($autenticacionRequestHeader/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                        data($autenticacionRequestHeader/Password))
                    }
</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($pagoRemesaCreditoCuenta/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRemesaCreditoCuenta as element(ns1:pagoRemesaCreditoCuenta) external;

xf:pagoRemesaCreditoCuentaConsultaDetalleCuentaIn($autenticacionRequestHeader,
    $pagoRemesaCreditoCuenta)