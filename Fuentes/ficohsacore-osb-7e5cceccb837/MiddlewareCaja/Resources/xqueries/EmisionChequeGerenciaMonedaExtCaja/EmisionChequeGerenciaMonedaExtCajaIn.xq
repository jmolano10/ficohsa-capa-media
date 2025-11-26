(:: pragma bea:global-element-parameter parameter="$emisiondechequedegerenciaFCY" element="ns0:EmisiondechequedegerenciaFCY" location="../../xsds/EmisionChequeGerenciaMonedaExtCaja/EmisionChequeGerenciaMonedaExtCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EmisiondechequedegerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaMonedaExtCaja/EmisionChequeGerenciaMonedaExtCajaIn/";

declare function xf:EmisionChequeGerenciaMonedaExtCajaIn($emisiondechequedegerenciaFCY as element(ns0:EmisiondechequedegerenciaFCY))
    as element(ns0:EmisiondechequedegerenciaFCY) {
        $emisiondechequedegerenciaFCY
};

declare variable $emisiondechequedegerenciaFCY as element(ns0:EmisiondechequedegerenciaFCY) external;

xf:EmisionChequeGerenciaMonedaExtCajaIn($emisiondechequedegerenciaFCY)