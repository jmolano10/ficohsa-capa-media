xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesAdvanceSalaryOut/";

declare function xf:consultaComisionesAdvanceSalaryOut($commisionPercent as xs:string,
$commisionAmount as xs:string)
    as element(ns0:consultaComisionesResponse) {
        <ns0:consultaComisionesResponse>
            <CURRENCY>HNL</CURRENCY>
            <AMOUNT>{ data($commisionAmount) }</AMOUNT>
            <COMMISSION_PERCENT>{ data($commisionPercent) }</COMMISSION_PERCENT>            
        </ns0:consultaComisionesResponse>
};

declare variable $commisionPercent as xs:string external;
declare variable $commisionAmount as xs:string external;

xf:consultaComisionesAdvanceSalaryOut($commisionPercent,$commisionAmount)