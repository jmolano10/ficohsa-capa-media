(:: pragma bea:global-element-parameter parameter="$consultadecuentascanceladasResponse1" element="ns0:ConsultadecuentascanceladasResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCuentasCanceladasResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaCuentasCanceladas/consultaCuentasCanceladasOut/";

declare function xf:consultaCuentasCanceladasOut($consultadecuentascanceladasResponse1 as element(ns0:ConsultadecuentascanceladasResponse))
    as element(ns1:consultaCuentasCanceladasResponse) {
        <ns1:consultaCuentasCanceladasResponse>
        {
            if ( $consultadecuentascanceladasResponse1/Status/successIndicator/text() = "Success" and empty($consultadecuentascanceladasResponse1/WSACCOUNTCLOSEDType[1]/ZERORECORDS/text())) then (
	            <consultaCuentasCanceladasType>
	                <consultaCuentasCanceladasResponseRecordType>
	                    <ACCOUNT_NUMBER>{ data($consultadecuentascanceladasResponse1/WSACCOUNTCLOSEDType[1]/gWSACCOUNTCLOSEDDetailType/mWSACCOUNTCLOSEDDetailType[1]/ID) }</ACCOUNT_NUMBER>
	                    <ACCOUNT_NAME>{ data($consultadecuentascanceladasResponse1/WSACCOUNTCLOSEDType[1]/gWSACCOUNTCLOSEDDetailType/mWSACCOUNTCLOSEDDetailType[1]/ACCOUNTNAME) }</ACCOUNT_NAME>
	                    <CLOSURE_DATE>{ data($consultadecuentascanceladasResponse1/WSACCOUNTCLOSEDType[1]/gWSACCOUNTCLOSEDDetailType/mWSACCOUNTCLOSEDDetailType[1]/CLOSUREDATE) }</CLOSURE_DATE>
	                </consultaCuentasCanceladasResponseRecordType>
	            </consultaCuentasCanceladasType>
            ) else ()
		}
        </ns1:consultaCuentasCanceladasResponse>
};

declare variable $consultadecuentascanceladasResponse1 as element(ns0:ConsultadecuentascanceladasResponse) external;

xf:consultaCuentasCanceladasOut($consultadecuentascanceladasResponse1)