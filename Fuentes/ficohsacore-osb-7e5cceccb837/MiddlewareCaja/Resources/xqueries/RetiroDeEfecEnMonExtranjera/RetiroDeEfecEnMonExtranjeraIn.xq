(:: pragma bea:global-element-parameter parameter="$retirodeefecenmonextranjeraRequest" element="ns0:Retirodeefecenmonextranjera" location="../../xsds/RetiroDeEfecEnMonExtranjera/RetiroDeEfecEnMonExtranjera.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Retirodeefecenmonextranjera" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeEfecEnMonExtranjera/RetiroDeEfecEnMonExtranjeraIn/";

declare function xf:RetiroDeEfecEnMonExtranjeraIn($retirodeefecenmonextranjeraRequest as element(ns0:Retirodeefecenmonextranjera))
    as element(ns0:Retirodeefecenmonextranjera) {
        $retirodeefecenmonextranjeraRequest
};

declare variable $retirodeefecenmonextranjeraRequest as element(ns0:Retirodeefecenmonextranjera) external;

xf:RetiroDeEfecEnMonExtranjeraIn($retirodeefecenmonextranjeraRequest)