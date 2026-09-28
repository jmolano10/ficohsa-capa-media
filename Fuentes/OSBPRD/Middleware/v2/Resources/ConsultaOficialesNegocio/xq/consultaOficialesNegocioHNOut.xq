(:: pragma bea:global-element-parameter parameter="$consultaOficialesNegocioResponse" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaOficialesNegocioResponse" location="../../../../Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOficialesNegocio";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioHNOut/";

declare function xf:consultaOficialesNegocioHNOut($consultaOficialesNegocioResponse as element(ns0:OutputParameters))
    as element(ns1:consultaOficialesNegocioResponse) {
		let $officerCode := $consultaOficialesNegocioResponse/ns0:PT_OFFICER_CODE/ns0:PT_OFFICER_CODE_ITEM
    	let $officerName := $consultaOficialesNegocioResponse/ns0:P_OFFICER_NAME/ns0:P_OFFICER_NAME_ITEM
    	let $branchCode := $consultaOficialesNegocioResponse/ns0:PT_BRANCH_CODE/ns0:PT_OFFICER_CODE_ITEM
    	let $branchName := $consultaOficialesNegocioResponse/ns0:P_BRANCH_NAME/ns0:P_OFFICER_NAME_ITEM
    	let $departmentId := $consultaOficialesNegocioResponse/ns0:P_DEPARTMENT_ID/ns0:PT_OFFICER_CODE_ITEM
    	let $departmentName := $consultaOficialesNegocioResponse/ns0:P_DEPARTMENT_NAME/ns0:P_OFFICER_NAME_ITEM
    	return
    		if (count($officerCode) < 1) then (
    			<ns1:consultaOficialesNegocioResponse/>
    		) else (
    			<ns1:consultaOficialesNegocioResponse>
		            <ns1:consultaOficialesNegocioResponseType>
		            {
			    		for $i in (1 to count($officerCode))
			    		return
			    			<ns1:consultaOficialesNegocioResponseRecordType>
			    				<OFFICER_CODE>{ data($officerCode[$i]) }</OFFICER_CODE>
			    				<OFFICER_NAME>{ data($officerName[$i]) }</OFFICER_NAME>
			    				<BRANCH_CODE>{ data($branchCode[$i]) }</BRANCH_CODE>
			    				<BRANCH_NAME>{ data($branchName[$i]) }</BRANCH_NAME>
			    				<DEPARTMENT_ID>{ data($departmentId[$i]) }</DEPARTMENT_ID>
			    				<DEPARTMENT_NAME>{ data($departmentName[$i]) }</DEPARTMENT_NAME>
			    			</ns1:consultaOficialesNegocioResponseRecordType>
		            }
		            </ns1:consultaOficialesNegocioResponseType>
		        </ns1:consultaOficialesNegocioResponse>
    		)
};

declare variable $consultaOficialesNegocioResponse as element(ns0:OutputParameters) external;

xf:consultaOficialesNegocioHNOut($consultaOficialesNegocioResponse)