(:: pragma bea:global-element-parameter parameter="$consultadeventanillaResponse" element="ns0:ConsultadeventanillaResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaVentanillaResponse" location="consultaVentanillaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaVentanillaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaVentanilla/consultaVentanillaOut/";

declare function xf:consultaVentanillaOut($consultadeventanillaResponse as element(ns0:ConsultadeventanillaResponse))
    as element(ns1:consultaVentanillaResponse) {
        <ns1:consultaVentanillaResponse>
            <TILL_ID>{ data($consultadeventanillaResponse/WSTELLERIDENQType[1]/gWSTELLERIDENQDetailType/mWSTELLERIDENQDetailType[1]/ID) }</TILL_ID>
            <ASSIGNED_USER>{ data($consultadeventanillaResponse/WSTELLERIDENQType[1]/gWSTELLERIDENQDetailType/mWSTELLERIDENQDetailType[1]/USER) }</ASSIGNED_USER>
            <TILL_STATUS>{ data($consultadeventanillaResponse/WSTELLERIDENQType[1]/gWSTELLERIDENQDetailType/mWSTELLERIDENQDetailType[1]/STATUS) }</TILL_STATUS>
            <BRANCH_CODE>{ data($consultadeventanillaResponse/WSTELLERIDENQType[1]/gWSTELLERIDENQDetailType/mWSTELLERIDENQDetailType[1]/BRANCHCODE) }</BRANCH_CODE>
        </ns1:consultaVentanillaResponse>
};

declare variable $consultadeventanillaResponse as element(ns0:ConsultadeventanillaResponse) external;

xf:consultaVentanillaOut($consultadeventanillaResponse)