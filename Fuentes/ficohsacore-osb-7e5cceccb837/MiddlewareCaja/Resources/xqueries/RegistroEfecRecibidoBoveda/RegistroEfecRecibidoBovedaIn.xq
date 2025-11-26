(:: pragma bea:global-element-parameter parameter="$movimientoefecdesdeboveda" element="ns0:Movimientoefecdesdeboveda" location="../../xsds/RegistroEfecRecibidoBoveda/RegistroEfecRecibidoBoveda.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Movimientoefecdesdeboveda" location="../../xsds/MovEfectivo/XMLSchema_1763986007.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistroEfecRecibidoBoveda/RegistroEfecRecibidoBovedaIn/";

declare function xf:RegistroEfecRecibidoBovedaIn($movimientoefecdesdeboveda as element(ns0:Movimientoefecdesdeboveda))
    as element(ns0:Movimientoefecdesdeboveda) {
        $movimientoefecdesdeboveda
};

declare variable $movimientoefecdesdeboveda as element(ns0:Movimientoefecdesdeboveda) external;

xf:RegistroEfecRecibidoBovedaIn($movimientoefecdesdeboveda)