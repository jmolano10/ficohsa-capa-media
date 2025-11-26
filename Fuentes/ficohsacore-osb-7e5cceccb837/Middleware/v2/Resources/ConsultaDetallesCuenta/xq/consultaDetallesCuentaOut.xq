xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetallesCuentaResponse" location="../xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/xq/consultaDetallesCuentaOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:consultaDetallesCuentaOut($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:consultaDetallesCuentaResponse) {
		if (fn:string($consultadedetallesdelacuentaResponse1/Status/successIndicator/text()) = "Success" and
    		fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/ZERORECORDS/text()) = "") then (
	        <ns1:consultaDetallesCuentaResponse>
	            {
	                for $gWSACCOUNTLISTDetailType in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType
	                return
	                    <ns1:consultaDetallesCuentaResponseType>
	                        {
	                            for $mWSACCOUNTLISTDetailType in $gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType
	                            return
	                                <ns1:consultaDetallesCuentaResponseRecordType>
	                                    <ACCOUNT_NUMBER>{ data($mWSACCOUNTLISTDetailType/ID) }</ACCOUNT_NUMBER>
	                                    <CUSTOMER_ID>{ data($mWSACCOUNTLISTDetailType/CUSTOMERNUMBER) }</CUSTOMER_ID>
	                                    <ACCOUNT_NAME>{ data($mWSACCOUNTLISTDetailType/SHORTTITLE) }</ACCOUNT_NAME>
	                                    <CATEGORY>{ data($mWSACCOUNTLISTDetailType/CATEGORY) }</CATEGORY>
	                                    <CURRENCY>{ data($mWSACCOUNTLISTDetailType/CURRENCY) }</CURRENCY>
	                                    <LIMIT_REF>{ data($mWSACCOUNTLISTDetailType/LIMITREF) }</LIMIT_REF>
	                                    <RESTRICTIONS>{ data($mWSACCOUNTLISTDetailType/POSTINGRESTRICT) }</RESTRICTIONS>
	                                    <ALT_ACCOUNT>{ data($mWSACCOUNTLISTDetailType/ALTACCTID) }</ALT_ACCOUNT>
	                                    <OPENING_DATE>{ data($mWSACCOUNTLISTDetailType/OPENINGDATE) }</OPENING_DATE>
	                                    <OPERATION_TYPE>{ data($mWSACCOUNTLISTDetailType/OPERATIONTYPE) }</OPERATION_TYPE>
	                                    <ACCOUNT_OFFICER>{ data($mWSACCOUNTLISTDetailType/ACCOUNTOFFICER) }</ACCOUNT_OFFICER>
	                                    <BRANCH_CODE>{ data($mWSACCOUNTLISTDetailType/BRANCHCODE) }</BRANCH_CODE>
	                                    <LEGAL_ID>{ data($mWSACCOUNTLISTDetailType/LEGALID) }</LEGAL_ID>
	                                    <REQUIRED_SIGNATURES>{ data($mWSACCOUNTLISTDetailType/REQUIREDSIGNATURES) }</REQUIRED_SIGNATURES>
	                                    <SIGNATURE_DESC>{ fn:replace($mWSACCOUNTLISTDetailType/SIGNATUREDESC, "!!", "") }</SIGNATURE_DESC>
	                                    <INACTIVE_MARKER>{ data($mWSACCOUNTLISTDetailType/INACTIVEMARKER) }</INACTIVE_MARKER>
	                                </ns1:consultaDetallesCuentaResponseRecordType>
	                        }
	                    </ns1:consultaDetallesCuentaResponseType>
	            }
	        </ns1:consultaDetallesCuentaResponse>
        ) else (
        	<ns1:consultaDetallesCuentaResponse/>
        )
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaDetallesCuentaOut($consultadedetallesdelacuentaResponse1)