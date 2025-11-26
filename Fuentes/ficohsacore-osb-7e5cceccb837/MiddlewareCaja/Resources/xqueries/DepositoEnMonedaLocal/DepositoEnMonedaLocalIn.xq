(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedalocal" element="ns0:Depositoefecenmonedalocal" location="../../xsds/DepositoEnMonedaLocal/DepositoEnMonedaLocal.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Depositoefecenmonedalocal" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoEnMonedaLocal/DepositoEnMonedaLocalIn/";

declare function xf:DepositoEnMonedaLocalIn($depositoefecenmonedalocal as element(ns0:Depositoefecenmonedalocal))
    as element(ns0:Depositoefecenmonedalocal) {
        $depositoefecenmonedalocal
};

declare variable $depositoefecenmonedalocal as element(ns0:Depositoefecenmonedalocal) external;

xf:DepositoEnMonedaLocalIn($depositoefecenmonedalocal)