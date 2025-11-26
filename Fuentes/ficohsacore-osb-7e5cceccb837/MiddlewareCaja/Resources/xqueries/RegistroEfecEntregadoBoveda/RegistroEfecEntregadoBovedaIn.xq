(:: pragma bea:global-element-parameter parameter="$movimientodeefechaciaboveda" element="ns0:Movimientodeefechaciaboveda" location="../../xsds/RegistroEfecEntregadoBoveda/RegistroEfecEntregadoBoveda.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Movimientodeefechaciaboveda" location="../../xsds/RegistroEfecEntregadoBoveda/RegistroEfecEntregadoBoveda.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistroEfecEntregadoBoveda/RegistroEfecEntregadoBovedaIn/";

declare function xf:RegistroEfecEntregadoBovedaIn($movimientodeefechaciaboveda as element(ns0:Movimientodeefechaciaboveda))
    as element(ns0:Movimientodeefechaciaboveda) {
        $movimientodeefechaciaboveda
};

declare variable $movimientodeefechaciaboveda as element(ns0:Movimientodeefechaciaboveda) external;

xf:RegistroEfecEntregadoBovedaIn($movimientodeefechaciaboveda)