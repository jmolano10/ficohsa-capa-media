(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSolicitudSubasta" element="ns1:consultaSolicitudSubasta" location="consultaSolicitudSubastaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultasubastaporenviaraBCH" location="../Resources/XMLSchema_-1390898219.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/consultaSolicitudSubasta/consultaSubastaPorEnviarBCHIn/";

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

declare function xf:consultaSubastaPorEnviarBCHIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaSolicitudSubasta as element(ns1:consultaSolicitudSubasta),
    $cuentadeServicio as xs:string)
    as element(ns0:ConsultasubastaporenviaraBCH) {
        <ns0:ConsultasubastaporenviaraBCH>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSFICOEAUCINPNAUType>
                <enquiryInputCollection>
                    <columnName>DEBIT.ACCT.NO</columnName>
                    <criteriaValue>{ fn:string($cuentadeServicio) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	if(fn:string($consultaSolicitudSubasta/AUCTION_DATE/text()) != "") then (
						<enquiryInputCollection>
						   <columnName>AUCTION.DATE</columnName>
						   <criteriaValue>{ data($consultaSolicitudSubasta/AUCTION_DATE) }</criteriaValue>
						   <operand>EQ</operand>
						</enquiryInputCollection>
					) else ()
				}
            </WSFICOEAUCINPNAUType>
        </ns0:ConsultasubastaporenviaraBCH>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaSolicitudSubasta as element(ns1:consultaSolicitudSubasta) external;
declare variable $cuentadeServicio as xs:string external;

xf:consultaSubastaPorEnviarBCHIn($autenticacionRequestHeader,
    $consultaSolicitudSubasta,
    $cuentadeServicio)