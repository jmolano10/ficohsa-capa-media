(:: pragma bea:global-element-parameter parameter="$confirmaciondechequesResponse1" element="ns0:ConfirmaciondechequesResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadechequeconfirmado" location="../Resources/XMLSchema_-1265051491.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/ConfirmacionCheque/ConfirmacionChequeConsultaTransaccionIn2/";

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

declare function xf:ConfirmacionChequeConsultaTransaccionIn2($confirmaciondechequesResponse1 as element(ns0:ConfirmaciondechequesResponse),
    $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader))
    as element(ns0:Consultadechequeconfirmado) {
        <ns0:Consultadechequeconfirmado>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/Password))
                    }
</password>
            </WebRequestCommon>
            <WSLATAMAGCHEQUECONFIRMBROWENQType>
                <enquiryInputCollection>
                <columnName>@ID</columnName>
                    {
                        for $transactionId in $confirmaciondechequesResponse1/Status/transactionId
                        return
                            <criteriaValue>{ data($transactionId) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLATAMAGCHEQUECONFIRMBROWENQType>
        </ns0:Consultadechequeconfirmado>
};

declare variable $confirmaciondechequesResponse1 as element(ns0:ConfirmaciondechequesResponse) external;
declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;

xf:ConfirmacionChequeConsultaTransaccionIn2($confirmaciondechequesResponse1,
    $autenticacionRequestHeader1)