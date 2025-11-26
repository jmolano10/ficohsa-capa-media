(:: pragma bea:global-element-parameter parameter="$activaciondetarjetadedebito" element="ns0:Activaciondetarjetadedebito" location="../../xsds/ActivacionTarjetaDebito/ActivacionTarjetaDebito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Activaciondetarjetadedebito" location="../../xsds/TarjetaDebito/XMLSchema_-155258746.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActivacionTarjetaDebito/ActivacionTarjetaDebitoIn/";

declare function xf:ActivacionTarjetaDebitoIn($activaciondetarjetadedebito as element(ns0:Activaciondetarjetadedebito))
    as element(ns0:Activaciondetarjetadedebito) {
        $activaciondetarjetadedebito
};

declare variable $activaciondetarjetadedebito as element(ns0:Activaciondetarjetadedebito) external;

xf:ActivacionTarjetaDebitoIn($activaciondetarjetadedebito)