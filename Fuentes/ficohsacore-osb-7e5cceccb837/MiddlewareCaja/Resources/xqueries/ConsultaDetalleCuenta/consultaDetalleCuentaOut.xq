(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleCuentaResponse" location="../../xsds/ConsultaDetalleCuenta/ConsultaDetalleCuenta.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultaDetalleCuenta";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaDetalleCuenta/consultaDetalleCuentaOut/";

declare function xf:consultaDetalleCuentaOut($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:consultaDetalleCuentaResponse) {
    	if (fn:string($consultadedetallesdelacuentaResponse1/Status/successIndicator/text()) = "Success" and
    		fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/ZERORECORDS/text()) = "") then
        (
	        <ns1:consultaDetalleCuentaResponse>
	            <ns1:consultaDetalleCuentaResponseType>
	                <ns1:consultaDetalleCuentaResponseRecordType>
	                    <ACCOUNT_NUMBER>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID) }</ACCOUNT_NUMBER>
	                    <CUSTOMER_ID>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CUSTOMERNUMBER) }</CUSTOMER_ID>
	                    <ACCOUNT_NAME>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE) }</ACCOUNT_NAME>
	                    <CATEGORY>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CATEGORY) }</CATEGORY>
	                    <CURRENCY>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CURRENCY) }</CURRENCY>
	                    <ALT_ACCOUNT>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID) }</ALT_ACCOUNT>
	                    <OPERATION_TYPE>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/OPERATIONTYPE) }</OPERATION_TYPE>
	                    <LEGAL_ID>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/LEGALID) }</LEGAL_ID>
	                    <REQUIRED_SIGNATURES>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/REQUIREDSIGNATURES) }</REQUIRED_SIGNATURES>
	                    <SIGNATURE_DESC>{ data($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SIGNATUREDESC) }</SIGNATURE_DESC>
	                </ns1:consultaDetalleCuentaResponseRecordType>
	            </ns1:consultaDetalleCuentaResponseType>
	        </ns1:consultaDetalleCuentaResponse>
        ) else (
        	<ns1:consultaDetalleCuentaResponse/>
        )
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaDetalleCuentaOut($consultadedetallesdelacuentaResponse1)