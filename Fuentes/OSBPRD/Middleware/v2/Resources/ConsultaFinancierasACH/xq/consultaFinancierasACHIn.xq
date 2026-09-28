(:: pragma bea:global-element-parameter parameter="$RequestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaFinancierasACH" element="ns1:consultaFinancierasACH" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadedestinosACH" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinancierasACH/consultaFinancierasACHIn/";

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

declare function xf:consultaFinancierasACHIn($RequestHeader1 as element(ns2:RequestHeader),
    $consultaFinancierasACH as element(ns1:consultaFinancierasACH))
    as element(ns0:ConsultadedestinosACH) {
        <ns0:ConsultadedestinosACH>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($RequestHeader1/Authentication/UserName)),
                        data($RequestHeader1/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($RequestHeader1/Authentication/UserName)),
                        data($RequestHeader1/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <WSACHBANKLISTType>
            {
            	if($consultaFinancierasACH/DESTINATION_CODE/text()) then (
	                <enquiryInputCollection>
	                    <columnName>@ID</columnName>
	                    <criteriaValue>{ data($consultaFinancierasACH/DESTINATION_CODE) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
                )
                else ()
            }
            </WSACHBANKLISTType>            
        </ns0:ConsultadedestinosACH>
};

declare variable $RequestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaFinancierasACH as element(ns1:consultaFinancierasACH) external;

xf:consultaFinancierasACHIn($RequestHeader1,
    $consultaFinancierasACH)