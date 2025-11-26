(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns0:pagoRemesas" location="../xsd/pagoRemesaCB.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/LimitesTransaccionalesTNG/limiteTrxConsultar/xsd/limiteTrxConsultarRem_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/limiteTrxConsultarRem";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCB/xq/fgf/";

declare function xf:fgf($requestHeader as element(ns2:RequestHeader),
    $pagoRemesas as element(ns0:pagoRemesas))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ID_CLIENTE>{ data($pagoRemesas/BENEFICIARY_INFO/ID) }</ns1:PV_ID_CLIENTE>
            <ns1:PV_CANAL>{ data($requestHeader/BankingCorrespondent/Id) }</ns1:PV_CANAL>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $pagoRemesas as element(ns0:pagoRemesas) external;

xf:fgf($requestHeader,
    $pagoRemesas)
