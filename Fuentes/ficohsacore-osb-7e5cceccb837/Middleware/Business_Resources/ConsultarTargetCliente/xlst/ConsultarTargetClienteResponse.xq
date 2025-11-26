(:: pragma bea:global-element-parameter parameter="$consultaTargetClienteResponse1" element="ns1:ConsultaTargetClienteResponse" location="../xsd/svcGetTargetFromAccount_TypeArray.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTargetClienteResponse" location="../xsd/GetTargetFromAccountTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/GetTargetFromAccountTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultarTargetCliente/xlst/ConsultarTargetClienteResponse/";

declare function xf:ConsultarTargetClienteResponse($consultaTargetClienteResponse1 as element(ns1:ConsultaTargetClienteResponse))
    as element(ns0:consultaTargetClienteResponse) {
        <ns0:consultaTargetClienteResponse>
            <ns0:ConsultarTargetClienteResponseType>
                <ns0:ConsultarTargetClienteResponseRecordType>
                    {
                        for $AccountNumber in $consultaTargetClienteResponse1/WSFICOTARGETCUSDETAILType[1]/gWSFICOTARGETCUSDETAILDetailType/mWSFICOTARGETCUSDETAILDetailType[1]/AccountNumber
                        return
                            <ACCOUNT_NUMBER>{ data($AccountNumber) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $Target in $consultaTargetClienteResponse1/WSFICOTARGETCUSDETAILType[1]/gWSFICOTARGETCUSDETAILDetailType/mWSFICOTARGETCUSDETAILDetailType[1]/Target
                        return
                            <TARGET_ID>{ data($Target) }</TARGET_ID>
                    }
                    {
                        for $Description in $consultaTargetClienteResponse1/WSFICOTARGETCUSDETAILType[1]/gWSFICOTARGETCUSDETAILDetailType/mWSFICOTARGETCUSDETAILDetailType[1]/Description
                        return
                            <TARGET_DESCRIPTION>{ data($Description) }</TARGET_DESCRIPTION>
                    }
                </ns0:ConsultarTargetClienteResponseRecordType>
            </ns0:ConsultarTargetClienteResponseType>
        </ns0:consultaTargetClienteResponse>
};

declare variable $consultaTargetClienteResponse1 as element(ns1:ConsultaTargetClienteResponse) external;

xf:ConsultarTargetClienteResponse($consultaTargetClienteResponse1)