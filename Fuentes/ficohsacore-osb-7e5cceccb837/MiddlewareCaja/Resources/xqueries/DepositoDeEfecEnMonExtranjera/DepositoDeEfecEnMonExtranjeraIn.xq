(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedaextranjera" element="ns0:Depositoefecenmonedaextranjera" location="../../xsds/DepositoDeEfecEnMonExtranjera/DepositoDeEfecEnMonExtranjera.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Depositoefecenmonedaextranjera" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoDeEfecEnMonExtranjera/DepositoDeEfecEnMonExtranjeraIn/";

declare function xf:DepositoDeEfecEnMonExtranjeraIn($depositoefecenmonedaextranjera as element(ns0:Depositoefecenmonedaextranjera))
    as element(ns0:Depositoefecenmonedaextranjera) {
        $depositoefecenmonedaextranjera
};

declare variable $depositoefecenmonedaextranjera as element(ns0:Depositoefecenmonedaextranjera) external;

xf:DepositoDeEfecEnMonExtranjeraIn($depositoefecenmonedaextranjera)