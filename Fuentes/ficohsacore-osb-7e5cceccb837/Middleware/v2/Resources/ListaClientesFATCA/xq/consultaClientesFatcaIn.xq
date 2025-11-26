xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest" element="ns1:sjConsultaListasClienteRequest" location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaClientesFatca" location="../../../BusinessServices/T24/consultarListaFatca/xsd/XMLSchema_-131806455.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListaClientesFATCA/xq/consultaClientesFatcaIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";

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

declare function xf:consultaClientesFatcaIn($sjConsultaListasClienteRequest as element(ns1:sjConsultaListasClienteRequest))
    as element(ns0:ConsultaClientesFatca) {
        <ns0:ConsultaClientesFatca>
            <WebRequestCommon>
                <userName>
                   {
	                    fn-bea:fail-over( getUsername(data($sjConsultaListasClienteRequest/ns1:USERNAME)),
	                    	data($sjConsultaListasClienteRequest/ns1:USERNAME))
	               }
                </userName>
                <password>
                  {
	                    fn-bea:fail-over( getPassword(data($sjConsultaListasClienteRequest/ns1:USERNAME)),
	                    	data($sjConsultaListasClienteRequest/ns1:PASSWORD))
	              }
                </password>
            </WebRequestCommon>
            <NOFILEFICOFATCALISTType>
                <enquiryInputCollection>
                    <columnName>LEGAL.ID</columnName>
                    <criteriaValue>{ data($sjConsultaListasClienteRequest/ns1:CUSTOMER_LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </NOFILEFICOFATCALISTType>
        </ns0:ConsultaClientesFatca>
};

declare variable $sjConsultaListasClienteRequest as element(ns1:sjConsultaListasClienteRequest) external;

xf:consultaClientesFatcaIn($sjConsultaListasClienteRequest)
