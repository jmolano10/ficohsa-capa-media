(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaAdjudicacionSubasta" element="ns0:consultaAdjudicacionSubasta" location="consultaAdjudicacionSubastaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultaadjudicacionsubasta" location="../Resources/XMLSchema_-1390898219.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAdjudicacionSubastaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaSubasta/consultaAdjudicacionSubasta/consultaAdjudicacionSubastaIn/";

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

declare function xf:consultaAdjudicacionSubastaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaAdjudicacionSubasta as element(ns0:consultaAdjudicacionSubasta))
    as element(ns1:Consultaadjudicacionsubasta) {
        <ns1:Consultaadjudicacionsubasta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSFICOPAPENQAAUCType>
                <enquiryInputCollection>
                    <columnName>CUST.ID</columnName>
                    <criteriaValue>{ data($consultaAdjudicacionSubasta/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
				{
					if(exists($consultaAdjudicacionSubasta/AUCTION_DATE/text())) then (                
		                <enquiryInputCollection>
		                    <columnName>PAP.DATE</columnName>
		                    <criteriaValue>{ data($consultaAdjudicacionSubasta/AUCTION_DATE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
		    	}
            </WSFICOPAPENQAAUCType>
        </ns1:Consultaadjudicacionsubasta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaAdjudicacionSubasta as element(ns0:consultaAdjudicacionSubasta) external;

xf:consultaAdjudicacionSubastaIn($autenticacionRequestHeader,
    $consultaAdjudicacionSubasta)