(:: pragma bea:global-element-parameter parameter="$referenciasporclienteResponse" element="ns0:ReferenciasporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaReferenciasClienteResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaReferenciasCliente/consultaReferenciasClienteOut/";

declare function xf:consultaReferenciasClienteOut($referenciasporclienteResponse as element(ns0:ReferenciasporclienteResponse))
    as element(ns1:consultaReferenciasClienteResponse) {
        <ns1:consultaReferenciasClienteResponse>
        {
        	if (empty($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/ZERORECORDS/text())) then (
	            <CUSTOMER_ID>{ data($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/ID) }</CUSTOMER_ID>,
	            <CUSTOMER_NAME>{ concat($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/GIVENNAMES, " "
	                     , $referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/FAMILYNAMES) }</CUSTOMER_NAME>,
	            <COMMERCIAL_NAME>{ data($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/COMMERCIALNAME) }</COMMERCIAL_NAME>,
	            <NAME_OF_BUSINESS>{ data($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/NAMEOFBUSINESS) }</NAME_OF_BUSINESS>,
	            <PERSONAL_REFERENCES>
	            {
	            	let $givenNames := fn:tokenize($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/PERSREFGIVENNAME, "!!")
	            	let $familyNames := fn:tokenize($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/PERSREFLASTNAME, "!!")
	            	let $relationCustomers := fn:tokenize($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/PERSREFRELATION, "!!")
	            	let $phoneNumbers := fn:tokenize($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/PERSREFPHONE, "!!")
	            	
	            	for $givenName at $i in $givenNames
	            	return 
	            		if ( $givenName != "" ) then (
			                <PERSONAL_REFERENCES_RECORD>
			                    <GIVEN_NAMES>{ $givenName }</GIVEN_NAMES>
			                    <FAMILY_NAMES>{ $familyNames[$i] }</FAMILY_NAMES>
			                    <RELATION_WITH_CUSTOMER>{ $relationCustomers[$i] }</RELATION_WITH_CUSTOMER>
			                    <PHONE_NUMBER>{ $phoneNumbers[$i] }</PHONE_NUMBER>
			                </PERSONAL_REFERENCES_RECORD>
		                ) else ()
		        }
	            </PERSONAL_REFERENCES>,
	            <COMMERCIAL_REFERENCES>
	            {
	            	let $businessNames := fn:tokenize($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/COMMREFNAME, "!!")
	            	let $contacts := fn:tokenize($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/COMMREFCONTACT, "!!")
	            	let $phoneNumbers := fn:tokenize($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/gWSCUSTOMERREFSDetailType/mWSCUSTOMERREFSDetailType[1]/COMMREFPHONE, "!!")
	            	
	            	for $businessName at $i in  $businessNames
	            	return
	            		if ( $businessName != "" ) then (
	                		<COMMERCIAL_REFERENCES_RECORD>
	                    		<BUSINESS_NAME>{ $businessName }</BUSINESS_NAME>
	                    		<CONTACT>{ $contacts[$i] }</CONTACT>
	                    		<PHONE_NUMBER>{ $phoneNumbers[$i] }</PHONE_NUMBER>
	                		</COMMERCIAL_REFERENCES_RECORD>
	                	) else ()
	            }
	            </COMMERCIAL_REFERENCES>
	     	) else ()
	     }
        </ns1:consultaReferenciasClienteResponse>
};

declare variable $referenciasporclienteResponse as element(ns0:ReferenciasporclienteResponse) external;

xf:consultaReferenciasClienteOut($referenciasporclienteResponse)