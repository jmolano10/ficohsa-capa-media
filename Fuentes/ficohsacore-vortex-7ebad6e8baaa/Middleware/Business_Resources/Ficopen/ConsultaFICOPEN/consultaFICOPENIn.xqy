xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFICOPEN1" element="ns1:consultaFICOPEN" location="consultaFICOPENTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resource/ConsultaFICOPEN/xsd/FICOPEN_OSB_K_CONSULTAFICOPEN_TOPLEVEL-24OSB_CON_FICOPEN.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/consultaFICOPENIn/";

declare function xf:consultaFICOPENIn($consultaFICOPEN1 as element(ns1:consultaFICOPEN))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:INVESTMENT_CODE>{ data($consultaFICOPEN1/INVESTMENT_CODE) }</ns0:INVESTMENT_CODE>
            <ns0:START_DATE>{ data($consultaFICOPEN1/START_DATE) }</ns0:START_DATE>
            <ns0:END_DATE>{ data($consultaFICOPEN1/END_DATE) }</ns0:END_DATE>
        </ns0:InputParameters>
};

declare variable $consultaFICOPEN1 as element(ns1:consultaFICOPEN) external;

xf:consultaFICOPENIn($consultaFICOPEN1)