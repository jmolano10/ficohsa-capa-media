(:: pragma bea:global-element-parameter parameter="$cargoporreposicionlibreta" element="ns0:Cargoporreposicionlibreta" location="../../xsds/CargoReposicionLibreta/CargoReposicionLibreta.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Cargoporreposicionlibreta" location="../../xsds/Cargos/XMLSchema_-282708305.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CargoReposicionLibreta/CargoReposicionLibretaIn/";

declare function xf:CargoReposicionLibretaIn($cargoporreposicionlibreta as element(ns0:Cargoporreposicionlibreta))
    as element(ns0:Cargoporreposicionlibreta) {
        $cargoporreposicionlibreta
};

declare variable $cargoporreposicionlibreta as element(ns0:Cargoporreposicionlibreta) external;

xf:CargoReposicionLibretaIn($cargoporreposicionlibreta)