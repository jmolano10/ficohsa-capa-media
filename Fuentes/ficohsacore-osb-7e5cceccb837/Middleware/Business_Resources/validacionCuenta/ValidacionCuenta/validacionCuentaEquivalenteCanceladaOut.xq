(:: pragma bea:global-element-parameter parameter="$consultadecuentascanceladasResponse1" element="ns0:ConsultadecuentascanceladasResponse" location="../../ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaResponse" location="validacionCuentaType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaEquivalenteCanceladaOut/";

declare function xf:validacionCuentaEquivalenteCanceladaOut($consultadecuentascanceladasResponse1 as element(ns0:ConsultadecuentascanceladasResponse),
    $accountNumber as xs:string)
    as element(ns1:validacionCuentaResponse) {
        <ns1:validacionCuentaResponse>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
            {
                for $ACCOUNTNAME in $consultadecuentascanceladasResponse1/WSACCOUNTCLOSEDType[1]/gWSACCOUNTCLOSEDDetailType/mWSACCOUNTCLOSEDDetailType[1]/ACCOUNTNAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
            }
            	<ACCOUNT_STATUS>CANCELLED</ACCOUNT_STATUS>
        </ns1:validacionCuentaResponse>
};

declare variable $consultadecuentascanceladasResponse1 as element(ns0:ConsultadecuentascanceladasResponse) external;
declare variable $accountNumber as xs:string external;

xf:validacionCuentaEquivalenteCanceladaOut($consultadecuentascanceladasResponse1,
    $accountNumber)