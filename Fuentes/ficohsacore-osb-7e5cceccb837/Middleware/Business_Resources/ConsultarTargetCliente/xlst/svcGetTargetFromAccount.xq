(:: pragma bea:global-element-parameter parameter="$consultaTargetCliente1" element="ns0:ConsultaTargetCliente" location="../xsd/svcGetTargetFromAccount_TypeArray.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaTargetCliente" location="../xsd/svcGetTargetFromAccount_TypeArray.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/T24/svcGetTargetFromAccount/xlst/svcGetTargetFromAccount/";

declare function xf:svcGetTargetFromAccount($consultaTargetCliente1 as element(ns0:ConsultaTargetCliente))
    as element(ns0:ConsultaTargetCliente) {
        $consultaTargetCliente1
};

declare variable $consultaTargetCliente1 as element(ns0:ConsultaTargetCliente) external;

xf:svcGetTargetFromAccount($consultaTargetCliente1)