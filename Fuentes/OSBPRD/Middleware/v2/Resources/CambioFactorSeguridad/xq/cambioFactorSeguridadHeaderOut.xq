(:: pragma bea:global-element-parameter parameter="$updateSecurityDeviceByUserNameMessageOut" element="ns7:UpdateSecurityDeviceByUserNameMessageOut" location="../../../BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.svc.singleWsdl.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns6 = "urn:Infocorp.framework.services.common";
declare namespace ns5 = "urn:infocorp.framework.businessentities.common";
declare namespace ns7 = "urn:tailored.icbanking.services.administration.users";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambioFactorSeguridad/xq/cambioFactorSeguridadHeaderOut/";
declare namespace ns4 = "urn:infocorp.framework.businessentities.security";
declare namespace ns3 = "urn:infocorp.framework.services.common";

declare function getSuccessIndicator($result as xs:int) as xs:string {
	if ($result = 0) then "Success"
	else "ERROR"
};

declare function xf:cambioFactorSeguridadHeaderOut($updateSecurityDeviceByUserNameMessageOut as element(ns7:UpdateSecurityDeviceByUserNameMessageOut))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            <successIndicator>{ getSuccessIndicator(data($updateSecurityDeviceByUserNameMessageOut/ns7:OperationResult)) }</successIndicator>
            <messages>{ data($updateSecurityDeviceByUserNameMessageOut/ns7:OperationResultDescription) }</messages>
        </ns2:ResponseHeader>
};

declare variable $updateSecurityDeviceByUserNameMessageOut as element(ns7:UpdateSecurityDeviceByUserNameMessageOut) external;

xf:cambioFactorSeguridadHeaderOut($updateSecurityDeviceByUserNameMessageOut)