(:: pragma bea:global-element-parameter parameter="$transferenciaentrecuentasRequest" element="ns0:Transferenciaentrecuentas" location="../../xsds/TransferenciaEntreCuentas/TransferenciaEntreCuentas.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Transferenciaentrecuentas" location="../../xsds/Transferencias/XMLSchema_1840876228.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TransferenciaEntreCuentas/TransferenciaEntreCuentasIn/";

declare function xf:TransferenciaEntreCuentasIn($transferenciaentrecuentasRequest as element(ns0:Transferenciaentrecuentas))
    as element(ns0:Transferenciaentrecuentas) {
        $transferenciaentrecuentasRequest
};

declare variable $transferenciaentrecuentasRequest as element(ns0:Transferenciaentrecuentas) external;

xf:TransferenciaEntreCuentasIn($transferenciaentrecuentasRequest)