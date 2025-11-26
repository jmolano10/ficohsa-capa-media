(:: pragma bea:global-element-parameter parameter="$emisiondechqdegerenciaTT" element="ns0:EmisiondechqdegerenciaTT" location="../../xsds/EmisionChequeGerenciaCaja/EmisionChequeGerenciaCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EmisiondechqdegerenciaTT" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaCaja/EmisionChequeGerenciaCajaIn/";

declare function xf:EmisionChequeGerenciaCajaIn($emisiondechqdegerenciaTT as element(ns0:EmisiondechqdegerenciaTT))
    as element(ns0:EmisiondechqdegerenciaTT) {
        $emisiondechqdegerenciaTT
};

declare variable $emisiondechqdegerenciaTT as element(ns0:EmisiondechqdegerenciaTT) external;

xf:EmisionChequeGerenciaCajaIn($emisiondechqdegerenciaTT)