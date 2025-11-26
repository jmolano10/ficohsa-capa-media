(:: pragma bea:global-element-parameter parameter="$depositoEfectivoMLME" element="ns0:DepositoEfectivoMLME" location="../../xsds/DepositoEfecMonLocalEnMonExtranjera/DepositoEfecMonLocalEnMonExtranjera.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DepositoEfectivoMLME" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoEfecMonLocalEnMonExtranjera/DepositoEfecMonLocalEnMonExtranjeraIn/";

declare function xf:DepositoEfecMonLocalEnMonExtranjeraIn($depositoEfectivoMLME as element(ns0:DepositoEfectivoMLME))
    as element(ns0:DepositoEfectivoMLME) {
        $depositoEfectivoMLME
};

declare variable $depositoEfectivoMLME as element(ns0:DepositoEfectivoMLME) external;

xf:DepositoEfecMonLocalEnMonExtranjeraIn($depositoEfectivoMLME)