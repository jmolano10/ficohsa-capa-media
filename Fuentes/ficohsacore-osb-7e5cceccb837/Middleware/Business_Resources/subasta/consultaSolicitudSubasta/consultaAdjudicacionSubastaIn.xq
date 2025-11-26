(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSolicitudSubasta" element="ns1:consultaSolicitudSubasta" location="consultaSolicitudSubastaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaadjudicacionsubasta" location="../Resources/XMLSchema_-1390898219.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/consultaAfiliacionSubasta/consultaAdjudicacionSubastaIn/";

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

declare function xf:consultaAdjudicacionSubastaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaSolicitudSubasta as element(ns1:consultaSolicitudSubasta))
    as element(ns0:Consultaadjudicacionsubasta) {
        <ns0:Consultaadjudicacionsubasta>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSFICOPAPENQAAUCType>
                <enquiryInputCollection>
                    <columnName>CUST.ID</columnName>
                    <criteriaValue>{ data($consultaSolicitudSubasta/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	if(fn:string($consultaSolicitudSubasta/AUCTION_DATE/text()) != "") then (
						<enquiryInputCollection>
						   <columnName>PAP.DATE</columnName>
						   <criteriaValue>{ data($consultaSolicitudSubasta/AUCTION_DATE) }</criteriaValue>
						   <operand>EQ</operand>
						</enquiryInputCollection>
					) else ()
				}
            </WSFICOPAPENQAAUCType>
        </ns0:Consultaadjudicacionsubasta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaSolicitudSubasta as element(ns1:consultaSolicitudSubasta) external;

xf:consultaAdjudicacionSubastaIn($autenticacionRequestHeader,
    $consultaSolicitudSubasta)