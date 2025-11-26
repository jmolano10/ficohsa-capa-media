(:: pragma bea:global-element-parameter parameter="$depositocombinadoRequest" element="ns0:Depositocombinado" location="../../xsds/DepositoCombinado/DepositoCombinado.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Depositocombinado" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoCombinado/DepositoCombinadoIn/";

declare function xf:DepositoCombinadoIn($depositocombinadoRequest as element(ns0:Depositocombinado))
    as element(ns0:Depositocombinado) {
        $depositocombinadoRequest
};

declare variable $depositocombinadoRequest as element(ns0:Depositocombinado) external;

xf:DepositoCombinadoIn($depositocombinadoRequest)