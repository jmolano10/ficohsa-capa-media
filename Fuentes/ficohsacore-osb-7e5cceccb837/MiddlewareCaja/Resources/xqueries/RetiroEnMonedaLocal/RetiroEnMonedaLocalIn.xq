(:: pragma bea:global-element-parameter parameter="$retiroenmonedalocalRequest" element="ns0:Retiroenmonedalocal" location="../../xsds/RetiroEnMonedaLocal/RetiroEnMonedaLocal.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Retiroenmonedalocal" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroEnMonedaLocal/RetiroEnMonedaLocalIn/";

declare function xf:RetiroEnMonedaLocalIn($retiroenmonedalocalRequest as element(ns0:Retiroenmonedalocal))
    as element(ns0:Retiroenmonedalocal) {
        $retiroenmonedalocalRequest
};

declare variable $retiroenmonedalocalRequest as element(ns0:Retiroenmonedalocal) external;

xf:RetiroEnMonedaLocalIn($retiroenmonedalocalRequest)