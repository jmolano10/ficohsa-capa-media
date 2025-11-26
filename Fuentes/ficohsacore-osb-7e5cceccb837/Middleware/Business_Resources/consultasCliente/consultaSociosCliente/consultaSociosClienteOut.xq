(:: pragma bea:global-element-parameter parameter="$consultadesociosporclienteResponse" element="ns0:ConsultadesociosporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSociosClienteResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaSociosCliente/consultaSociosClienteOut/";

declare function xf:consultaSociosClienteOut($consultadesociosporclienteResponse as element(ns0:ConsultadesociosporclienteResponse))
    as element(ns1:consultaSociosClienteResponse) {
        <ns1:consultaSociosClienteResponse>
            {
                for $ID in $consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/ID
                return
                    <CUSTOMER_ID>{ data($ID) }</CUSTOMER_ID>
            }
            {
                for $CUSTOMERNAME in $consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/CUSTOMERNAME
                return
                    <CUSTOMER_NAME>{ data($CUSTOMERNAME) }</CUSTOMER_NAME>
            }
            {
                for $COMMERCIALNAME in $consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/COMMERCIALNAME
                return
                    <COMMERCIAL_NAME>{ data($COMMERCIALNAME) }</COMMERCIAL_NAME>
            }
            {
                for $NAMEOFBUSINESS in $consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/NAMEOFBUSINESS
                return
                    <NAME_OF_BUSINESS>{ data($NAMEOFBUSINESS) }</NAME_OF_BUSINESS>
            }
            {
                for $NOOFSHRHLDRS in $consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/NOOFSHRHLDRS
                return
                    <NO_OF_SHAREHOLDERS>{ data($NOOFSHRHLDRS) }</NO_OF_SHAREHOLDERS>
            }
            {
                for $REGISTERDATE in $consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/REGISTERDATE
                return
                    <REGISTER_DATE>{ data($REGISTERDATE) }</REGISTER_DATE>
            }
            {
            	if ( fn:empty($consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/ZERORECORDS)) then (
		            <SHARE_HOLDERS>
					{
		            	let $SHRHLDLEGALIDS := fn:tokenize($consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/SHRHLDLEGALID, "!!")
		            	let $SHRHLDGIVENNAMES := fn:tokenize($consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/SHRHLDGIVENNAMES, "!!")
		            	let $SHRHLDFAMILYNAMES := fn:tokenize($consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/SHRHLDFAMILYNAME, "!!")
		            	let $SHRHLDPARTICIPATIONS := fn:tokenize($consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/gWSCUSTOMERBASSOCDetailType/mWSCUSTOMERBASSOCDetailType[1]/SHRHLDPARTICIPATION, "!!")
		            	
		            	for $SHRHLDLEGALID at $i in $SHRHLDLEGALIDS
			            return
			            	if ($SHRHLDLEGALID != "") then (
				            	<SHARE_HOLDER_RECORD>
				                	<SHR_HLD_LEGAL_ID>{ $SHRHLDLEGALID }</SHR_HLD_LEGAL_ID>
				                	<SHR_HLD_GIVEN_NAME>{ $SHRHLDGIVENNAMES[$i] }</SHR_HLD_GIVEN_NAME>
				                	<SHR_HLD_FAMILY_NAME>{ $SHRHLDFAMILYNAMES[$i] }</SHR_HLD_FAMILY_NAME>
				                	<SHR_HLD_PARTICIPATION>{ $SHRHLDPARTICIPATIONS[$i] }</SHR_HLD_PARTICIPATION>
				                </SHARE_HOLDER_RECORD>
			                ) else ()
				    }
		            </SHARE_HOLDERS>
				) else ()
		}
        </ns1:consultaSociosClienteResponse>
};

declare variable $consultadesociosporclienteResponse as element(ns0:ConsultadesociosporclienteResponse) external;

xf:consultaSociosClienteOut($consultadesociosporclienteResponse)